import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';

abstract class AdoptionRepoDomain {
  // ========== For Adoption Tab (Other Users) ==========
  /// Get list of all pets available for adoption
  Future<Result<List<AddPetEntity>, Object>> getPetsForAdoption();

  /// Get pet details by ID (for viewing pet details)
  Future<Result<AddPetEntity, Object>> getPetDetails(String petId);

  /// Send adoption request for a pet
  Future<Result<AdoptionRequestEntity, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId, // Requester ID
    required String title,
    required String description,
  });

  // ========== My Pets Tab (Pet Owner) ==========
  /// Get owner's pets (both for adoption and not for adoption)
  Future<Result<List<AddPetEntity>, Object>> getMyPets(String ownerId);

  /// Add pet for adoption
  Future<Result<Null, Object>> addPetForAdoption(String petId);

  /// Remove pet from adoption (but keep the pet)
  Future<Result<Null, Object>> removePetFromAdoption(String petId);

  /// Get adoption requests for owner's pets
  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequests(
    String ownerId,
  );

  /// Get adoption requests for a specific pet
  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequestsByPet(
    String petId,
  );

  /// Accept an adoption request
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId);

  /// Reject an adoption request
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId);

  /// Cancel adoption (if pet was already adopted)
  Future<Result<Null, Object>> cancelAdoption(String petId);

  /// Get list of adopted pets
  Future<Result<List<AddPetEntity>, Object>> getAdoptedPets(String ownerId);

  /// Get cancelled adoptions
  Future<Result<List<AdoptionRequestEntity>, Object>> getCancelledAdoptions(
    String ownerId,
  );

  /// Get owner names for multiple owner IDs
  Future<Result<Map<String, String?>, Object>> getOwnerNamesForPets(
    List<String> ownerIds,
  );

  /// Get adoption request counts for multiple pet IDs
  Future<Result<Map<String, int>, Object>> getAdoptionRequestCountsForPets(
    List<String> petIds,
  );
}
