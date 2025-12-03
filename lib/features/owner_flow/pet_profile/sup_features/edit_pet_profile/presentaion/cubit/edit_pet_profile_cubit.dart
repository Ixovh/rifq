import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../pet_info_card/domain/entity/pet_entity.dart';
import '../../domain/usecase/edit_pet_profile_usecase.dart';

part 'edit_pet_profile_state.dart';


class EditPetProfileCubit extends Cubit<EditPetProfileState> {
  final EditPetProfileUsecase usecase;
  final PetProfileEntity pet;
  EditPetProfileCubit(this.usecase, {required this.pet})
      : super(EditPetProfileInitial(pet: pet));

  Future<void> updatePet({String? newName, String? newPhotoUrl}) async {
    emit(EditPetProfileLoading(pet: pet));
    try {
      final updatedName = newName ?? pet.name;
      final updatedPhoto = newPhotoUrl ?? pet.photoUrl;
      final result = await usecase.updatePetProfile( pet.id,updatedName, updatedPhoto,  );
      result.when(
            (success) {
              final updatedPet = PetProfileEntity(
                id: pet.id,
                name: updatedName,
                breed: pet.breed,
                species: pet.species,
                birthdate: pet.birthdate,
                photoUrl: updatedPhoto,
                ownerId: pet.ownerId,
                gender: pet.gender,
                createdAt: pet.createdAt,);
          emit(EditPetProfileSuccess(pet: updatedPet));
        }, (error) {
          emit(EditPetProfileError(pet: pet, message: error.toString()));
        },
      );
    } catch (e) {
      emit(EditPetProfileError(pet: pet, message: e.toString()));
    }
  }
}


// Future<void> pickNewPhoto(PetProfileEntity pet) async {
  //   emit(EditPetProfileLoading(pet));
  //   final picker = ImagePicker();
  //   final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  //   if (file == null) return emit(EditPetProfileInitial(pet));
  //   try {
  //     final uploadedUrl = await uploadImageToSupabase(file);
  //     final updatedPet = PetProfileEntity(
  //       id: pet.id,
  //       name: pet.name,
  //       breed: pet.breed,
  //       species: pet.species,
  //       birthdate: pet.birthdate,
  //       photoUrl: uploadedUrl,
  //       ownerId: pet.ownerId,
  //       gender: pet.gender,
  //       createdAt: pet.createdAt,
  //     );
  //     final result = await usecase.updatePetProfile(updatedPet);
  //     result.when(
  //           (success) => emit(EditPetProfileSuccess(updatedPet)),
  //           (error) => emit(EditPetProfileError(pet, error)),
  //     );
  //   } catch (e) {
  //     emit(EditPetProfileError(pet, e.toString()));
  //   }
  // }
  //
  // //
  // //
  // //
  // Future<String> uploadImageToSupabase(XFile file) async {
  //   final bytes = await file.readAsBytes();
  //   final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
  //
  //   try {
  //     await supabase.storage
  //         .from('pets')
  //         .uploadBinary(fileName, bytes);
  //     // بعد ما ترفع الصورة، نجيب لها رابط عام
  //     final publicUrl = supabase.storage.from('pets').getPublicUrl(fileName);
  //     return publicUrl;
  //   } catch (e) {
  //     throw Exception('Error uploading image: $e');
  //   }
  // }




