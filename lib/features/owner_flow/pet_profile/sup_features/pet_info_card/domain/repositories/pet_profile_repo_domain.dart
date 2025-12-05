
import '../entity/pet_entity.dart';


abstract class PetProfileRepoDomain {
  Future <List<PetProfileEntity>> getPetsByOwner(String ownerId); //عرض كل الحيوانات للمالك

  Future<PetProfileEntity> getPetById(String petId);// عشان ادخل على تفاصيل كل حيوان

  // Future<PetProfileEntity> updatePetProfile(PetProfileEntity  petId);

}