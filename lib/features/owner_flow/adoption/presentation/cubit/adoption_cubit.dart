import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/usecases/adotion_use_case.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final AdoptionUseCase _useCase;

  // Cache lists for UI access
  /// 1) All pets owned by the current user (used in "select pet" etc.)
  final List<AddPetEntity> myPets = [];

  /// 2) Pets owned by the user that are currently offered for adoption
  ///    -> Used by **MyPetsTab**
  final List<AddPetEntity> offeredForAdoptionPets = [];

  /// 3) All pets available to be adopted (public list)
  ///    -> Used by **AdoptionTab**
  final List<AddPetEntity> availablePets = [];

  /// 4) Requests (for request screens)
  final List<AdoptionRequestEntity> adoptionRequests = [];

  // Simple caching flags to avoid double loads
  bool _myPetsLoaded = false;
  bool _offeredLoaded = false;
  bool _availableLoaded = false;

  bool _isLoadingMyPets = false;
  bool _isLoadingOffered = false;
  bool _isLoadingAvailable = false;

  AdoptionCubit(this._useCase) : super(AdoptionInitial());

  // ==============================
  // Pet Owner Methods
  // ==============================

  /// Pet owner can get all their pets (to choose which one to offer for adoption)
  Future<void> getMyPets({bool forceRefresh = false}) async {
    if (_isLoadingMyPets) return;
    if (_myPetsLoaded && !forceRefresh) return;

    _isLoadingMyPets = true;
    emit(AdoptionLoading());

    final result = await _useCase.getMyPets();
    result.when(
      (pets) {
        myPets
          ..clear()
          ..addAll(pets);

        _myPetsLoaded = true;
        emit(MyPetsLoaded(List<AddPetEntity>.from(myPets)));
      },
      (error) {
        emit(AdoptionError(error.toString()));
      },
    );

    _isLoadingMyPets = false;
  }

  /// Load both my pets and offered pets together
  Future<void> getMyPetsAndOffered({bool forceRefresh = false}) async {
    emit(AdoptionLoading());

    // Call both use cases
    final myPetsResult = await _useCase.getMyPets();
    final offeredPetsResult = await _useCase.getOfferedPetsForAdoption();

    // Handle results
    if (myPetsResult.isError() || offeredPetsResult.isError()) {
      final error = myPetsResult.isError()
          ? myPetsResult.tryGetError()
          : offeredPetsResult.tryGetError();
      emit(AdoptionError(error.toString()));
      return;
    }

    final allPets = myPetsResult.tryGetSuccess() ?? [];
    final offeredPets = offeredPetsResult.tryGetSuccess() ?? [];

    // Update cached lists
    myPets
      ..clear()
      ..addAll(allPets);

    offeredForAdoptionPets
      ..clear()
      ..addAll(offeredPets);

    _myPetsLoaded = true;
    _offeredLoaded = true;

    emit(MyPetsAndOfferedLoaded(allPets: allPets, offeredPets: offeredPets));
  }

  /// Pet owner can get all their pets that are currently offered for adoption
  /// -> feeds MyPetsTab
  Future<void> getOfferedPetsForAdoption({bool forceRefresh = false}) async {
    if (_isLoadingOffered) return;
    if (_offeredLoaded && !forceRefresh) return;

    _isLoadingOffered = true;
    emit(AdoptionLoading());

    final result = await _useCase.getOfferedPetsForAdoption();
    result.when(
      (pets) {
        offeredForAdoptionPets
          ..clear()
          ..addAll(pets);

        _offeredLoaded = true;
        emit(
          OfferedPetsLoaded(List<AddPetEntity>.from(offeredForAdoptionPets)),
        );
      },
      (error) {
        emit(AdoptionError(error.toString()));
      },
    );

    _isLoadingOffered = false;
  }

  /// Pet owner can add his/her pet for adoption
  Future<void> addPetForAdoption({required AddPetEntity pet}) async {
    emit(AdoptionLoading());

    final result = await _useCase.addPetForAdoption(pet: pet);
    result.when(
      (_) {
        // Add to cached list
        offeredForAdoptionPets.add(pet);

        // Also add to available pets list if it's already loaded (for immediate UI update)
        if (_availableLoaded) {
          availablePets.add(pet);
          emit(AvailablePetsLoaded(List<AddPetEntity>.from(availablePets)));
        } else {
          // If not loaded yet, invalidate cache so it will be loaded when needed
          invalidateAvailableCache();
        }

        // Emit both success state and the loaded state so UI can display the updated list
        emit(PetAddedForAdoptionSuccess(pet));
        emit(
          OfferedPetsLoaded(List<AddPetEntity>.from(offeredForAdoptionPets)),
        );
      },
      (error) {
        emit(AdoptionError(error.toString()));
      },
    );
  }

  /// Pet owner can see the number of requests on his/her offered pet
  Future<void> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.getAdoptionRequestCountForPet(
      petId: petId,
      ownerId: ownerId,
    );
    result.when(
      (count) => emit(PetRequestCountLoaded(petId: petId, count: count)),
      (error) => emit(AdoptionError(error.toString())),
    );
  }

  /// Pet owner can see all adoption requests for a specific pet
  Future<void> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId,
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.getAdoptionRequestsForPet(
      petId: petId,
      ownerId: ownerId,
    );
    result.when((requests) {
      adoptionRequests
        ..clear()
        ..addAll(requests);
      emit(PetRequestsLoaded(petId: petId, requests: requests));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Pet owner can remove his/her own pet from being adopted
  Future<void> removePetFromAdoption({
    required String petId,
    required String ownerId,
  }) async {
    // Find and store the pet before removing (for potential rollback on error)
    final petIndex = offeredForAdoptionPets.indexWhere(
      (pet) => pet.id == petId,
    );
    if (petIndex == -1) {
      // Pet not found, already removed or doesn't exist
      return;
    }
    final removedPet = offeredForAdoptionPets[petIndex];

    // Optimistically remove from list immediately for UI responsiveness
    offeredForAdoptionPets.removeAt(petIndex);
    emit(PetRemovedFromAdoptionSuccess(petId));
    emit(OfferedPetsLoaded(List<AddPetEntity>.from(offeredForAdoptionPets)));

    // Then make the async call to update backend
    final result = await _useCase.removePetFromAdoption(
      petId: petId,
      ownerId: ownerId,
    );
    result.when(
      (_) {
        // Success - item already removed from offeredForAdoptionPets
        // Also remove from available pets list if it's already loaded (for immediate UI update)
        if (_availableLoaded) {
          availablePets.removeWhere((p) => p.id == petId);
          emit(AvailablePetsLoaded(List<AddPetEntity>.from(availablePets)));
        } else {
          // If not loaded yet, invalidate cache so it will be loaded when needed
          invalidateAvailableCache();
        }
      },
      (error) {
        // On error, re-add the pet back to the list at the same position
        offeredForAdoptionPets.insert(petIndex, removedPet);
        emit(AdoptionError(error.toString()));
        emit(
          OfferedPetsLoaded(List<AddPetEntity>.from(offeredForAdoptionPets)),
        );
      },
    );
  }

  /// Pet owner can accept or reject a request coming from a user
  Future<void> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId,
    required String status, // 'accepted' | 'rejected'
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.updateAdoptionRequestStatus(
      requestId: requestId,
      ownerId: ownerId,
      status: status,
    );
    result.when((request) {
      // Update in cached list
      final index = adoptionRequests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        adoptionRequests[index] = request;
      }
      emit(AdoptionRequestStatusUpdated(request));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  // ==============================
  // Regular User Methods
  // ==============================

  /// Regular user can see all the pets that are available to be adopted
  /// -> feeds AdoptionTab
  Future<void> getAvailablePetsForAdoption({bool forceRefresh = false}) async {
    if (_isLoadingAvailable) return;
    if (_availableLoaded && !forceRefresh) return;

    _isLoadingAvailable = true;
    emit(AdoptionLoading());

    final result = await _useCase.getAvailablePetsForAdoption();
    result.when(
      (pets) {
        availablePets
          ..clear()
          ..addAll(pets);

        _availableLoaded = true;
        emit(AvailablePetsLoaded(List<AddPetEntity>.from(availablePets)));
      },
      (error) {
        emit(AdoptionError(error.toString()));
      },
    );

    _isLoadingAvailable = false;
  }

  /// Regular user can send a request to pet owner to adopt their pet
  Future<void> sendAdoptionRequest({
    required String petId,
    required String userId,
    required String title,
    required String description,
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.sendAdoptionRequest(
      petId: petId,
      userId: userId,
      title: title,
      description: description,
    );
    result.when((request) {
      // Add to cached list
      adoptionRequests.add(request);
      emit(AdoptionRequestSent(request));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Regular user can see details of a pet available to be adopted
  Future<void> getPetDetails({required String petId}) async {
    emit(AdoptionLoading());
    final result = await _useCase.getPetDetails(petId: petId);
    result.when(
      (pet) => emit(PetDetailsLoaded(pet)),
      (error) => emit(AdoptionError(error.toString())),
    );
  }

  /// Regular user can see all their own adoption requests
  Future<void> getUserAdoptionRequests({required String userId}) async {
    emit(AdoptionLoading());
    final result = await _useCase.getUserAdoptionRequests(userId: userId);
    result.when((requests) {
      adoptionRequests
        ..clear()
        ..addAll(requests);
      emit(UserAdoptionRequestsLoaded(requests));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Regular user can cancel their own adoption request
  Future<void> cancelAdoptionRequest({
    required String requestId,
    required String userId,
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.cancelAdoptionRequest(
      requestId: requestId,
      userId: userId,
    );
    result.when((request) {
      // Update in cached list
      final index = adoptionRequests.indexWhere((r) => r.id == requestId);
      if (index != -1) {
        adoptionRequests[index] = request;
      }
      emit(AdoptionRequestCancelled(request));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  // ==============================
  // Cache Management
  // ==============================

  /// Invalidate offered pets cache (useful when you know data is stale)
  void invalidateOfferedCache() {
    _offeredLoaded = false;
    offeredForAdoptionPets.clear();
  }

  /// Invalidate available pets cache
  void invalidateAvailableCache() {
    _availableLoaded = false;
    availablePets.clear();
  }

  /// Invalidate my pets cache
  void invalidateMyPetsCache() {
    _myPetsLoaded = false;
    myPets.clear();
  }
}
