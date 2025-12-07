import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/usecases/adotion_use_case.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final AdoptionUseCase _useCase;

  // Cache lists for UI access
  final List<AddPetEntity> myPets = [];
  final List<AddPetEntity> offeredForAdoptionPets = [];
  final List<AdoptionRequestEntity> adoptionRequests = [];

  AdoptionCubit(this._useCase) : super(AdoptionInitial());

  // ==============================
  // Pet Owner Methods
  // ==============================

  /// Pet owner can get all their pets (to choose which one to offer for adoption)
  Future<void> getMyPets() async {
    emit(AdoptionLoading());
    final result = await _useCase.getMyPets();
    result.when((pets) {
      myPets.clear();
      myPets.addAll(pets);
      emit(MyPetsLoaded(pets));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Load both my pets and offered pets together
  Future<void> getMyPetsAndOffered() async {
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
    myPets.clear();
    myPets.addAll(allPets);

    offeredForAdoptionPets.clear();
    offeredForAdoptionPets.addAll(offeredPets);

    emit(MyPetsAndOfferedLoaded(allPets: allPets, offeredPets: offeredPets));
  }

  /// Pet owner can get all their pets that are currently offered for adoption
  Future<void> getOfferedPetsForAdoption() async {
    emit(AdoptionLoading());
    final result = await _useCase.getOfferedPetsForAdoption();
    result.when((pets) {
      offeredForAdoptionPets.clear();
      offeredForAdoptionPets.addAll(pets);
      emit(OfferedPetsLoaded(pets));
    }, (error) => emit(AdoptionError(error.toString())));
  }

  /// Pet owner can add his/her pet for adoption
  Future<void> addPetForAdoption({required AddPetEntity pet}) async {
    emit(AdoptionLoading());
    final result = await _useCase.addPetForAdoption(pet: pet);
    result.when((adoptionRequest) {
      // Add to cached list
      offeredForAdoptionPets.add(adoptionRequest);
      emit(PetAddedForAdoptionSuccess(pet));
    }, (error) => emit(AdoptionError(error.toString())));
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
      adoptionRequests.clear();
      adoptionRequests.addAll(requests);
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

    // Then make the async call to update backend
    final result = await _useCase.removePetFromAdoption(
      petId: petId,
      ownerId: ownerId,
    );
    result.when(
      (_) {
        // Success - item already removed, no need to do anything
      },
      (error) {
        // On error, re-add the pet back to the list at the same position
        offeredForAdoptionPets.insert(petIndex, removedPet);
        emit(AdoptionError(error.toString()));
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
  Future<void> getAvailablePetsForAdoption() async {
    emit(AdoptionLoading());
    final result = await _useCase.getAvailablePetsForAdoption();
    result.when((pets) {
      offeredForAdoptionPets.clear();
      offeredForAdoptionPets.addAll(pets);
      emit(AvailablePetsLoaded(pets));
    }, (error) => emit(AdoptionError(error.toString())));
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
      adoptionRequests.clear();
      adoptionRequests.addAll(requests);
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
}
