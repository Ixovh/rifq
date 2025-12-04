import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/usecases/adotion_use_case.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  final AdoptionUseCase _useCase;

  AdoptionCubit(this._useCase) : super(AdoptionInitial());

  // ========== For Adoption Tab (Other Users) ==========

  /// Get list of all pets available for adoption
  Future<void> getPetsForAdoption() async {
    emit(AdoptionLoading());
    (await _useCase.getPetsForAdoption()).when(
      (success) => emit(PetsForAdoptionLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Get pet details by ID
  Future<void> getPetDetails(String petId) async {
    emit(AdoptionLoading());
    (await _useCase.getPetDetails(petId)).when(
      (success) => emit(PetDetailsLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Send adoption request for a pet
  Future<void> sendAdoptionRequest({
    required String petId,
    required String ownerId,
    required String title,
    required String description,
  }) async {
    emit(AdoptionLoading());
    (await _useCase.sendAdoptionRequest(
      petId: petId,
      ownerId: ownerId,
      title: title,
      description: description,
    )).when(
      (success) => emit(AdoptionRequestSent(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  // ========== My Pets Tab (Pet Owner) ==========

  /// Get owner's pets
  Future<void> getMyPets(String ownerId) async {
    emit(AdoptionLoading());
    (await _useCase.getMyPets(ownerId)).when(
      (success) async {
        // Get unique owner IDs and pet IDs
        final ownerIds = success.map((pet) => pet.ownerId).toSet().toList();
        final petIds = success.map((pet) => pet.id).toList();

        // Fetch owner names and request counts in parallel
        final ownerNamesResult = await _useCase.getOwnerNamesForPets(ownerIds);
        final requestCountsResult = await _useCase
            .getAdoptionRequestCountsForPets(petIds);

        Map<String, String?> ownerNames = {};
        Map<String, int> requestCounts = {};

        ownerNamesResult.when(
          (success) => ownerNames = success,
          (error) => ownerNames = {},
        );

        requestCountsResult.when(
          (success) => requestCounts = success,
          (error) => requestCounts = {},
        );

        emit(
          MyPetsLoaded(
            success,
            ownerNames: ownerNames,
            requestCounts: requestCounts,
          ),
        );
      },
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Add pet for adoption
  Future<void> addPetForAdoption(String petId) async {
    emit(AdoptionLoading());
    (await _useCase.addPetForAdoption(petId)).when(
      (success) => emit(PetAddedForAdoption()),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Remove pet from adoption
  Future<void> removePetFromAdoption(String petId) async {
    emit(AdoptionLoading());
    (await _useCase.removePetFromAdoption(petId)).when(
      (success) => emit(PetRemovedFromAdoption()),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Get adoption requests for owner's pets
  Future<void> getAdoptionRequests(String ownerId) async {
    emit(AdoptionLoading());
    (await _useCase.getAdoptionRequests(ownerId)).when(
      (success) => emit(AdoptionRequestsLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Get adoption requests for a specific pet
  Future<void> getAdoptionRequestsByPet(String petId) async {
    emit(AdoptionLoading());
    (await _useCase.getAdoptionRequestsByPet(petId)).when(
      (success) => emit(AdoptionRequestsByPetLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Accept an adoption request
  Future<void> acceptAdoptionRequest(String requestId) async {
    emit(AdoptionLoading());
    (await _useCase.acceptAdoptionRequest(requestId)).when(
      (success) => emit(AdoptionRequestAccepted()),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Reject an adoption request
  Future<void> rejectAdoptionRequest(String requestId) async {
    emit(AdoptionLoading());
    (await _useCase.rejectAdoptionRequest(requestId)).when(
      (success) => emit(AdoptionRequestRejected()),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Cancel adoption
  Future<void> cancelAdoption(String petId) async {
    emit(AdoptionLoading());
    (await _useCase.cancelAdoption(petId)).when(
      (success) => emit(AdoptionCancelled()),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Get list of adopted pets
  Future<void> getAdoptedPets(String ownerId) async {
    emit(AdoptionLoading());
    (await _useCase.getAdoptedPets(ownerId)).when(
      (success) => emit(AdoptedPetsLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }

  /// Get cancelled adoptions
  Future<void> getCancelledAdoptions(String ownerId) async {
    emit(AdoptionLoading());
    (await _useCase.getCancelledAdoptions(ownerId)).when(
      (success) => emit(CancelledAdoptionsLoaded(success)),
      (error) => emit(
        AdoptionError(CatchErrorMessage(error: error).getWriteMessage()),
      ),
    );
  }
}
