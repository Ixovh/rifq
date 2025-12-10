import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/usecases/adotion_use_case.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final AdoptionUseCase _useCase;

  // Form controllers for adoption request
  final adoptionRequestFormKey = GlobalKey<FormBuilderState>();
  final adoptionRequestPhoneNumberController = TextEditingController();
  final adoptionRequestDescriptionController = TextEditingController();

  // Cache lists for UI access
  /// 1) All pets owned by the current user (used in "select pet" etc.)
  final List<AddPetEntity> myPets = [];

  /// 2) Pets owned by the user that are currently offered for adoption
  ///    -> Used by **MyPetsTab**
  final List<AddPetEntity> offeredForAdoptionPets = [];

  /// 3) All pets available to be adopted (public list)
  ///    -> Used by **AdoptionTab**
  final List<AddPetEntity> availablePets = [];

  /// 4) Requests (for request screens) - DEPRECATED: Use pet-specific cache
  final List<AdoptionRequestEntity> adoptionRequests = [];

  /// 5) Pet-specific requests cache (petId -> requests)
  final Map<String, List<AdoptionRequestEntity>> _petRequestsCache = {};

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
    // Only emit loading if we don't have data yet (prevents flickering during pull-to-refresh)
    if (offeredForAdoptionPets.isEmpty) {
      emit(AdoptionLoading());
    }

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
        // Add to cached list (for MyPetsTab)
        offeredForAdoptionPets.add(pet);

        // Don't add to availablePets - the user's own pets should never appear
        // in the adoption tab. The data source filters them out.
        // Just invalidate the cache so other users will see the new pet when they refresh
        invalidateAvailableCache();

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
      // Store requests in pet-specific cache
      _petRequestsCache[petId] = List<AdoptionRequestEntity>.from(requests);
      // Also update the legacy list for backward compatibility
      adoptionRequests
        ..clear()
        ..addAll(requests);
      emit(PetRequestsLoaded(petId: petId, requests: requests));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Pet owner can see all adoption requests for a specific pet (with caching)
  /// This method ensures requests are scoped to a specific pet
  Future<void> getAdoptionRequestsForSpecificPet({
    required String petId,
    required String ownerId,
    bool forceRefresh = false,
  }) async {
    // Return cached data if available and not forcing refresh
    if (!forceRefresh && _petRequestsCache.containsKey(petId)) {
      final cachedRequests = _petRequestsCache[petId]!;
      emit(PetRequestsLoaded(petId: petId, requests: cachedRequests));
      return;
    }

    emit(AdoptionLoading());
    final result = await _useCase.getAdoptionRequestsForPet(
      petId: petId,
      ownerId: ownerId,
    );
    result.when((requests) {
      // Store requests in pet-specific cache
      _petRequestsCache[petId] = List<AdoptionRequestEntity>.from(requests);
      // Also update the legacy list for backward compatibility
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
        // Remove from available pets list if it exists (shouldn't be there for current user,
        // but might be for other users viewing the list)
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
    String?
    petId, // Optional: if provided, will reload requests for this specific pet
  }) async {
    // Don't emit loading to prevent UI flickering
    final result = await _useCase.updateAdoptionRequestStatus(
      requestId: requestId,
      ownerId: ownerId,
      status: status,
    );
    result.when((request) {
      final isAccepted = status == 'adopted' || status == 'accepted';

      // If request was accepted, the pet has been transferred to the requester
      if (isAccepted && petId != null) {
        // Remove pet from offered pets list (since it's no longer owned by current user)
        offeredForAdoptionPets.removeWhere((pet) => pet.id == petId);
        // Remove from my pets list as well
        myPets.removeWhere((pet) => pet.id == petId);
        // Remove from available pets (it's no longer available for adoption)
        availablePets.removeWhere((pet) => pet.id == petId);
        // Clear the pet's requests cache since it's no longer owned by this user
        _petRequestsCache.remove(petId);
        // Invalidate all caches to ensure fresh data
        invalidateOfferedCache();
        invalidateAvailableCache();
        invalidateMyPetsCache();
      } else {
        // Update in pet-specific cache if petId is provided
        if (petId != null && _petRequestsCache.containsKey(petId)) {
          final petRequests = _petRequestsCache[petId]!;
          final index = petRequests.indexWhere((r) => r.id == requestId);
          if (index != -1) {
            petRequests[index] = request;
            _petRequestsCache[petId] = List<AdoptionRequestEntity>.from(
              petRequests,
            );
          }
        }

        // Update in legacy cached list
        final index = adoptionRequests.indexWhere((r) => r.id == requestId);
        if (index != -1) {
          adoptionRequests[index] = request;
        }
      }

      emit(AdoptionRequestStatusUpdated(request: request, petId: petId));
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
    // Only emit loading if we don't have data yet (prevents flickering during pull-to-refresh)
    if (availablePets.isEmpty) {
      emit(AdoptionLoading());
    }

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
  /// User ID is now handled internally in the data source
  Future<void> sendAdoptionRequest({
    required String petId,
    required String phone,
    required String description,
  }) async {
    emit(AdoptionLoading());
    final result = await _useCase.sendAdoptionRequest(
      petId: petId,
      title: phone,
      description: description,
    );
    result.when((request) {
      // Add to cached list
      adoptionRequests.add(request);
      emit(AdoptionRequestSent(request));
      // Clear form after successful submission
      adoptionRequestPhoneNumberController.clear();
      adoptionRequestDescriptionController.clear();
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

  /// Get user name by user ID
  Future<String> getUserName({required String userId}) async {
    final result = await _useCase.getUserName(userId: userId);
    return result.when((name) => name, (error) => 'Unknown User');
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
