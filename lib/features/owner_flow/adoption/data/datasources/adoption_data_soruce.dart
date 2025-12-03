import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/adoption/data/models/adoption_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AdoptionDataSource {
  // ========== For Adoption Tab (Other Users) ==========
  Future<Result<List<PetModel>, Object>> getPetsForAdoption();
  Future<Result<PetModel, Object>> getPetDetails(String petId);
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId, // Requester ID
    required String title,
    required String description,
  });

  // ========== My Pets Tab (Pet Owner) ==========
  Future<Result<List<PetModel>, Object>> getMyPets(String ownerId);
  Future<Result<Null, Object>> addPetForAdoption(String petId);
  Future<Result<Null, Object>> removePetFromAdoption(String petId);
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequests(
    String ownerId,
  );
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsByPet(
    String petId,
  );
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId);
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId);
  Future<Result<Null, Object>> cancelAdoption(String petId);
  Future<Result<Null, Object>> deletePet(String petId);
  Future<Result<List<AdoptionModel>, Object>> getCancelledAdoptions(
    String ownerId,
  );
}

@LazySingleton(as: AdoptionDataSource)
class AdoptionDataBaseSoruce implements AdoptionDataSource {
  final SupabaseClient supabase;

  AdoptionDataBaseSoruce(this.supabase);

  @override
  Future<Result<List<PetModel>, Object>> getPetsForAdoption() {
    // TODO: implement getPetsForAdoption
    throw UnimplementedError();
  }

  @override
  Future<Result<PetModel, Object>> getPetDetails(String petId) {
    // TODO: implement getPetDetails
    throw UnimplementedError();
  }

  @override
  Future<Result<AdoptionModel, Object>> sendAdoptionRequest({
    required String petId,
    required String ownerId, // Requester ID
    required String title,
    required String description,
  }) {
    // TODO: implement sendAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<Result<List<PetModel>, Object>> getMyPets(String ownerId) {
    // TODO: implement getMyPets
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> addPetForAdoption(String petId) {
    // TODO: implement addPetForAdoption
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> removePetFromAdoption(String petId) {
    // TODO: implement removePetFromAdoption
    throw UnimplementedError();
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequests(
    String ownerId,
  ) {
    // TODO: implement getAdoptionRequests
    throw UnimplementedError();
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getAdoptionRequestsByPet(
    String petId,
  ) {
    // TODO: implement getAdoptionRequestsByPet
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> acceptAdoptionRequest(String requestId) {
    // TODO: implement acceptAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> rejectAdoptionRequest(String requestId) {
    // TODO: implement rejectAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> cancelAdoption(String petId) {
    // TODO: implement cancelAdoption
    throw UnimplementedError();
  }

  @override
  Future<Result<Null, Object>> deletePet(String petId) {
    // TODO: implement deletePet
    throw UnimplementedError();
  }

  @override
  Future<Result<List<AdoptionModel>, Object>> getCancelledAdoptions(
    String ownerId,
  ) {
    // TODO: implement getCancelledAdoptions
    throw UnimplementedError();
  }
}
