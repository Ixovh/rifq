import 'package:multiple_result/multiple_result.dart';

import '../entity/pet_profile_entity.dart';


abstract class RepoDomain {
  Future<Result<PetProfileEntity, String>> getPetsByOwner(String ownerId); //عرض كل الحيوانات للمالك

  Future<Result<PetProfileEntity, String>> getPetById(String petId);// عشان ادخل على تفاصيل كل حيوان

  Future<Result<PetProfileEntity, String>> updatePet(PetProfileEntity  petId);

}