import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';

abstract class AdoptionRepoDomain {
  // ==============================
  // Pet Owner Methods
  // ==============================

  /// Pet owner can get all their pets (to choose which one to offer for adoption)
  /// Uses the currently logged-in user's ID
  Future<Result<List<AddPetEntity>, Object>> getMyPets();

  /// Pet owner can add his/her pet for adoption
  Future<Result<AddPetEntity, Object>> addPetForAdoption({
    required AddPetEntity pet,
  });

  /// Pet owner can see the number of requests on his/her offered pet
  Future<Result<int, Object>> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  });

  /// Pet owner can see all adoption requests for a specific pet
  Future<Result<List<AdoptionRequestEntity>, Object>>
  getAdoptionRequestsForPet({
    required String petId,
    required String ownerId, // to verify ownership
  });

  /// Pet owner can remove his/her own pet from being adopted
  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  });

  /// Pet owner can get all their pets that are currently offered for adoption
  /// Uses the currently logged-in user's ID
  Future<Result<List<AddPetEntity>, Object>> getOfferedPetsForAdoption();

  /// Pet owner can accept or reject a request coming from a user
  /// [status] should be: 'adopted' (accepted) or 'reserved' (rejected)
  Future<Result<AdoptionRequestEntity, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId, // to ensure only the pet owner can decide
    required String status, // 'adopted' | 'reserved'
  });

  // ==============================
  // Regular User Methods
  // ==============================

  /// Regular user can see all the pets that are available to be adopted
  Future<Result<List<AddPetEntity>, Object>> getAvailablePetsForAdoption();

  /// Regular user can send a request to pet owner to adopt their pet
  Future<Result<AdoptionRequestEntity, Object>> sendAdoptionRequest({
    required String petId,
    required String userId, // adopter's user id
    required String title,
    required String description,
  });

  /// Regular user can see details of a pet available to be adopted
  Future<Result<AddPetEntity, Object>> getPetDetails({required String petId});

  /// Regular user can see all their own adoption requests
  Future<Result<List<AdoptionRequestEntity>, Object>> getUserAdoptionRequests({
    required String userId,
  });

  /// Regular user can cancel their own adoption request
  Future<Result<AdoptionRequestEntity, Object>> cancelAdoptionRequest({
    required String requestId,
    required String userId,
  });
}
