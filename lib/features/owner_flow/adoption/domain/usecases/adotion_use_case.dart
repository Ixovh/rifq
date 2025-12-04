import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/repositories/adoption_repo_domain.dart';

@lazySingleton
class AdoptionUseCase {
  final AdoptionRepoDomain repoDomain;

  AdoptionUseCase(this.repoDomain);

  Future<Result<List<AddPetEntity>, Object>> getPetsForAdoption() async {
    return await repoDomain.getPetsForAdoption();
  }

  Future<Result<AddPetEntity, Object>> getPetDetails(String petId) async {
    return await repoDomain.getPetDetails(petId);
  }

  Future<Result<AdoptionRequestEntity, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId,
    required String title,
    required String description,
  }) async {
    return await repoDomain.sendAdoptionRequest(
      petId: petId,
      ownerId: ownerId,
      title: title,
      description: description,
    );
  }

  // ========== My Pets Tab (Pet Owner) ==========
  Future<Result<List<AddPetEntity>, Object>> getMyPets(String ownerId) async {
    return await repoDomain.getMyPets(ownerId);
  }

  Future<Result<Null, Object>> addPetForAdoption(String petId) async {
    return await repoDomain.addPetForAdoption(petId);
  }

  Future<Result<Null, Object>> removePetFromAdoption(String petId) async {
    return await repoDomain.removePetFromAdoption(petId);
  }

  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequests(
    String ownerId,
  ) async {
    return await repoDomain.getAdoptionRequests(ownerId);
  }

  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequestsByPet(
    String petId,
  ) async {
    return await repoDomain.getAdoptionRequestsByPet(petId);
  }

  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId) async {
    return await repoDomain.acceptAdoptionRequest(requestId);
  }

  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId) async {
    return await repoDomain.rejectAdoptionRequest(requestId);
  }

  Future<Result<Null, Object>> cancelAdoption(String petId) async {
    return await repoDomain.cancelAdoption(petId);
  }

  Future<Result<List<AddPetEntity>, Object>> getAdoptedPets(
    String ownerId,
  ) async {
    return await repoDomain.getAdoptedPets(ownerId);
  }

  Future<Result<List<AdoptionRequestEntity>, Object>> getCancelledAdoptions(
    String ownerId,
  ) async {
    return await repoDomain.getCancelledAdoptions(ownerId);
  }

  Future<Result<Map<String, String?>, Object>> getOwnerNamesForPets(
    List<String> ownerIds,
  ) async {
    return await repoDomain.getOwnerNamesForPets(ownerIds);
  }

  Future<Result<Map<String, int>, Object>> getAdoptionRequestCountsForPets(
    List<String> petIds,
  ) async {
    return await repoDomain.getAdoptionRequestCountsForPets(petIds);
  }
}
