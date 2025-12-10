import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/repositories/adoption_repo_domain.dart';

@lazySingleton
class AdoptionUseCase {
  final AdoptionRepoDomain repoDomain;

  AdoptionUseCase(this.repoDomain);

  // ==============================
  // Pet Owner Methods
  // ==============================

  /// Pet owner can get all their pets (to choose which one to offer for adoption)
  Future<Result<List<AddPetEntity>, Object>> getMyPets() async =>
      await repoDomain.getMyPets();

  /// Pet owner can add his/her pet for adoption
  /// Pet owner can add his/her pet for adoption
  Future<Result<AddPetEntity, Object>> addPetForAdoption({
    required AddPetEntity pet,
  }) async => await repoDomain.addPetForAdoption(pet: pet);

  /// Pet owner can see all adoption requests for a specific pet
  Future<Result<List<AdoptionRequestEntity>, Object>>
  getAdoptionRequestsForPet({
    required String petId,
    required String ownerId, // to verify ownership
  }) async => await repoDomain.getAdoptionRequestsForPet(
    petId: petId,
    ownerId: ownerId,
  );

  /// Pet owner can remove his/her own pet from being adopted
  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  }) async =>
      await repoDomain.removePetFromAdoption(petId: petId, ownerId: ownerId);

  /// Pet owner can get all their pets that are currently offered for adoption
  Future<Result<List<AddPetEntity>, Object>>
  getOfferedPetsForAdoption() async =>
      await repoDomain.getOfferedPetsForAdoption();

  /// Pet owner can accept or reject a request coming from a user
  /// [status] should be: 'adopted' (accepted) or 'reserved' (rejected)
  Future<Result<AdoptionRequestEntity, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId, // to ensure only the pet owner can decide
    required String status, // 'adopted' | 'reserved'
  }) async => await repoDomain.updateAdoptionRequestStatus(
    requestId: requestId,
    ownerId: ownerId,
    status: status,
  );

  // ==============================
  // Regular User Methods
  // ==============================

  /// Regular user can see all the pets that are available to be adopted
  Future<Result<List<AddPetEntity>, Object>>
  getAvailablePetsForAdoption() async =>
      await repoDomain.getAvailablePetsForAdoption();

  /// Regular user can send a request to pet owner to adopt their pet
  /// User ID is handled internally in the data source (from auth)
  Future<Result<AdoptionRequestEntity, Object>> sendAdoptionRequest({
    required String petId,
    required String title,
    required String description,
  }) async => await repoDomain.sendAdoptionRequest(
    petId: petId,
    title: title,
    description: description,
  );

  /// Regular user can see details of a pet available to be adopted
  Future<Result<AddPetEntity, Object>> getPetDetails({
    required String petId,
  }) async => await repoDomain.getPetDetails(petId: petId);

  /// Get user name by user ID
  Future<Result<String, Object>> getUserName({required String userId}) async =>
      await repoDomain.getUserName(userId: userId);
}
