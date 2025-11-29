// import 'package:injectable/injectable.dart';
// import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_profile_entity.dart';
//
// import '../../sup_features/pet_info_card/domain/repositories/pet_profile_repo_domain.dart';
// import '../datasources/pet_profile_datasources.dart';
// import '../../sup_features/pet_info_card/data/model/pet_profile_model.dart';
//
//
// @LazySingleton(as: PetProfileRepoDomain)
// class RepoDataPet implements PetProfileRepoDomain {
//   final PetProfileDataSource dataSource;
//   RepoDataPet(this.dataSource);
//
//   @override
//   Future<List<PetProfileEntity>> getPetsByOwner(String ownerId) async {
//     final result = await dataSource.getPetsByOwner(ownerId);
//     return result;
//   }
//
//   @override
//   Future<PetProfileEntity> getPetById(String petId) async {
//     final result = await dataSource.getPetById(petId);
//     return result;
//   }
//
//   @override
//   Future<PetProfileEntity> updatePetProfile(PetProfileEntity pet) async {
//     final model = PetProfileModel(
//       id: pet.id,
//       name: pet.name,
//       breed: pet.breed,
//       species: pet.species,
//       birthdate: pet.birthdate,
//       photoUrl: pet.photoUrl,
//       ownerId: pet.ownerId,
//       gender: pet.gender,
//       createdAt: pet.createdAt,
//     );
//     final updatedModel = await dataSource.updatePetProfile(model);
//     return updatedModel;
//   }
// }