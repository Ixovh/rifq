import 'package:multiple_result/multiple_result.dart';

import '../entity/pet_profile_entity.dart';


abstract class PetProfileRepoDomain {
  Future <List<PetProfileEntity>> getPetsByOwner(String ownerId); //عرض كل الحيوانات للمالك

  Future<PetProfileEntity> getPetById(String petId);// عشان ادخل على تفاصيل كل حيوان

  Future<PetProfileEntity> updatePet(PetProfileEntity  petId);

}