import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/data/datasources/adoption_data_source.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:rifq/features/owner_flow/adoption/domain/repositories/adoption_repo_domain.dart';

@LazySingleton(as: AdoptionRepoDomain)
class AdoptionRepoData implements AdoptionRepoDomain {
  final AdoptionDataSource dataSource;
  AdoptionRepoData(this.dataSource);

  @override
  Future<Result<List<AddPetEntity>, Object>> getMyPets() async {
    return await dataSource.getMyPets();
  }

  @override
  Future<Result<PetModel, Object>> addPetForAdoption({
    required AddPetEntity pet,
  }) async {
    // Convert AddPetEntity to PetModel
    final petModel = PetModel(
      id: pet.id,
      ownerId: pet.ownerId,
      name: pet.name,
      species: pet.species,
      gender: pet.gender,
      breed: pet.breed,
      birthdate: pet.birthdate,
      photoUrl: pet.photoUrl,
      createdAt: DateTime.now(),
    );

    return await dataSource.addPetForAdoption(pet: petModel);
  }

  @override
  Future<Result<int, Object>> getAdoptionRequestCountForPet({
    required String petId,
    required String ownerId,
  }) async => await dataSource.getAdoptionRequestCountForPet(
    petId: petId,
    ownerId: ownerId,
  );

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsForPet({
    required String petId,
    required String ownerId,
  }) async => await dataSource.getAdoptionRequestsForPet(
    petId: petId,
    ownerId: ownerId,
  );

  @override
  Future<Result<Null, Object>> removePetFromAdoption({
    required String petId,
    required String ownerId,
  }) async =>
      await dataSource.removePetFromAdoption(petId: petId, ownerId: ownerId);

  @override
  Future<Result<List<AddPetEntity>, Object>>
  getOfferedPetsForAdoption() async =>
      await dataSource.getOfferedPetsForAdoption();

  @override
  Future<Result<AdoptionModel, Object>> updateAdoptionRequestStatus({
    required String requestId,
    required String ownerId,
    required String status,
  }) async => await dataSource.updateAdoptionRequestStatus(
    requestId: requestId,
    ownerId: ownerId,
    status: status,
  );

  @override
  Future<Result<List<PetModel>, Object>> getAvailablePetsForAdoption() async =>
      await dataSource.getAvailablePetsForAdoption();

  @override
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String userId,
    required String title,
    required String description,
  }) async => await dataSource.sendAdoptionRequest(
    petId: petId,
    userId: userId,
    title: title,
    description: description,
  );

  @override
  Future<Result<PetModel, Object>> getPetDetails({
    required String petId,
  }) async => await dataSource.getPetDetails(petId: petId);

  @override
  Future<Result<List<AdoptionModel>, Object>> getUserAdoptionRequests({
    required String userId,
  }) async => await dataSource.getUserAdoptionRequests(userId: userId);

  @override
  Future<Result<AdoptionModel, Object>> cancelAdoptionRequest({
    required String requestId,
    required String userId,
  }) async => await dataSource.cancelAdoptionRequest(
    requestId: requestId,
    userId: userId,
  );
}
