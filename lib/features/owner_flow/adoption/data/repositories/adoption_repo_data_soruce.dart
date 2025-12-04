import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/data/datasources/adoption_data_soruce.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/domain/repositories/adoption_repo_domain.dart';

@LazySingleton(as: AdoptionRepoDomain)
class AdoptionRepoData implements AdoptionRepoDomain {
  final AdoptionDataSource dataSource;
  AdoptionRepoData(this.dataSource);

  @override
  Future<Result<List<PetModel>, Object>> getAdoptedPets(String ownerId) async {
    return await dataSource.getAdoptedPets(ownerId);
  }

  @override
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId) async {
    return await dataSource.acceptAdoptionRequest(requestId);
  }

  @override
  Future<Result<Null, Object>> addPetForAdoption(String petId) async {
    return await dataSource.addPetForAdoption(petId);
  }

  @override
  Future<Result<Null, Object>> cancelAdoption(String petId) async {
    return await dataSource.cancelAdoption(petId);
  }

  @override
  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequests(
    String ownerId,
  ) async {
    return await dataSource.getAdoptionRequests(ownerId);
  }

  @override
  Future<Result<List<AdoptionRequestEntity>, Object>> getAdoptionRequestsByPet(
    String petId,
  ) async {
    return await dataSource.getAdoptionRequestsByPet(petId);
  }

  @override
  Future<Result<List<AdoptionRequestEntity>, Object>> getCancelledAdoptions(
    String ownerId,
  ) async {
    return await dataSource.getCancelledAdoptions(ownerId);
  }

  @override
  Future<Result<List<AddPetEntity>, Object>> getMyPets(String ownerId) async {
    return await dataSource.getMyPets(ownerId);
  }

  @override
  Future<Result<AddPetEntity, Object>> getPetDetails(String petId) async {
    return await dataSource.getPetDetails(petId);
  }

  @override
  Future<Result<List<AddPetEntity>, Object>> getPetsForAdoption() async {
    return await dataSource.getPetsForAdoption();
  }

  @override
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId) async {
    return await dataSource.rejectAdoptionRequest(requestId);
  }

  @override
  Future<Result<Null, Object>> removePetFromAdoption(String petId) async {
    return await dataSource.removePetFromAdoption(petId);
  }

  @override
  Future<Result<AdoptionRequestEntity, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId,
    required String title,
    required String description,
  }) async {
    return await dataSource.sendAdoptionRequest(
      petId: petId,
      ownerId: ownerId,
      title: title,
      description: description,
    );
  }

  @override
  Future<Result<Map<String, String?>, Object>> getOwnerNamesForPets(
    List<String> ownerIds,
  ) async {
    return await dataSource.getOwnerNamesForPets(ownerIds);
  }

  @override
  Future<Result<Map<String, int>, Object>> getAdoptionRequestCountsForPets(
    List<String> petIds,
  ) async {
    return await dataSource.getAdoptionRequestCountsForPets(petIds);
  }
}
