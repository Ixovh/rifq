//
//
// import 'package:injectable/injectable.dart';
// import 'package:multiple_result/multiple_result.dart';
// import 'package:rifq/features/owner_flow/pet_profile/data/model/pet_profile_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// abstract class PetProfileDatasources{
//   Future<Result<PetProfileModel, String>>  getPetsByOwner(String ownerId);
//   Future<PetProfileModel> getPetById(String petId);
//   Future<void> updatePet(PetProfileModel pet);
//
// }
// @injectable
// @LazySingleton(as:PetProfileDatasources )
// class DataBaseDataSource implements PetProfileDatasources{
//   final SupabaseClient client;
//   DataBaseDataSource(this.client);
//
//
//   @override
//   Future<Result<List<PetProfileModel>, String>> getPetsByOwner(String ownerId) async {
//     try {
//       final response = await client
//           .from('pet_profile_view')
//           .select()
//           .eq('owner_id', ownerId);
//
//       if (response.error != null) {
//         return Result.error(response.error!.message);
//       }
//
//       final data = (response.data as List)
//           .map((e) => PetProfileModel.fromJson(e))
//           .toList();
//
//       return Success(data);
//     } catch (e) {
//       return Result.error(e.toString());
//     }
//   }
//
//   @override
//   Future<Result<PetProfileModel, String>> getPetById(String petId) async {
//     try {
//       final response = await client
//           .from('pet_profile_view')
//           .select()
//           .eq('pet_id', petId)
//           .single();
//
//       if (response.error != null) {
//         return Result.error(response.error!.message);
//       }
//
//       return Success(PetProfileModel.fromJson(response.data));
//     } catch (e) {
//       return Result.error(e.toString());
//     }
//   }
//
//   @override
//   Future<Result<void, String>> updatePet(PetProfileModel pet) async {
//     try {
//       final response = await client
//           .from('pets')
//           .update(pet.toJson())
//           .eq('id', pet.id);
//
//       if (response.error != null) {
//         return Result.error(response.error!.message);
//       }
//
//       return const Success(null);
//     } catch (e) {
//       return Result.error(e.toString());
//     }
//   }
//
// }
//
