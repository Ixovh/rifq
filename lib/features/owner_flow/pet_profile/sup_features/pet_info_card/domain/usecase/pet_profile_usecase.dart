import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../hotel/sup_feauter/booking_hotel/domain/entity/pet_entity.dart';
import '../entity/pet_entity.dart';
import '../repositories/pet_profile_repo_domain.dart';


@lazySingleton
class PetProfileUsecase {
  final PetProfileRepoDomain repository;
  PetProfileUsecase(this.repository);

  // عرض كل الحيوانات للمالك
  Future<Result<List<PetProfileEntity>, String>> getPetsByOwner(String ownerId) async {
    try {
      final pets = await repository.getPetsByOwner(ownerId);
      return Result.success(pets);
    } catch (e) {
      return Result.error(e.toString());
    }}
  //
  //


  // تفاصيل حيوان معين
  Future<Result<PetProfileEntity, String>> getPetById(String petId) async {
    try {
      final pet = await repository.getPetById(petId);
      return Result.success(pet);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
  //
  //
  //


}