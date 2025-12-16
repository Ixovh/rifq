import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../pet_info_card/domain/entity/pet_entity.dart';
import '../../domain/usecase/edit_pet_profile_usecase.dart';

part 'edit_pet_profile_state.dart';


class EditPetProfileCubit extends Cubit<EditPetProfileState> {
  final EditPetProfileUsecase usecase;
   PetProfileEntity pet;
  final SupabaseClient supabase = Supabase.instance.client;
  EditPetProfileCubit(this.usecase, {required this.pet,})
      : super(EditPetProfileInitial(pet: pet));

  Future<void> updatePet({String? newName, String? newPhotoUrl}) async {
    emit(EditPetProfileLoading(pet: pet));
    try {
      final updatedName = newName ?? pet.name;

      final updatedPhoto = (newPhotoUrl != null && newPhotoUrl.isNotEmpty)
          ? newPhotoUrl
          : state.pet.photoUrl;

      final result = await usecase.updatePetProfile(pet.id, updatedName, updatedPhoto);
      result.when(
            (success) {
          final data = success;
          final updatedPet = PetProfileEntity(
            id: pet.id,
            name: data['name'] ?? updatedName,
            photoUrl: data['photo'] ?? updatedPhoto,
            breed: pet.breed,
            species: pet.species,
            birthdate: pet.birthdate,
            ownerId: pet.ownerId,
            gender: pet.gender,
            createdAt: pet.createdAt,
          );
          pet = updatedPet;
          emit(EditPetProfileSuccess(pet: updatedPet));
        }, (error) {
          emit(EditPetProfileError(pet: state.pet, message: error.toString()));
        },
      );
    } catch (e) {
      emit(EditPetProfileError(pet: state.pet, message: e.toString()));
    }
  }

  Future<String?> pickAndUploadPhoto() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      print("11111");
      if (pickedFile == null) return null;
      print("11111=> ${pickedFile.path}");
      emit(EditPetProfileLoading(pet: pet));
      final Uint8List fileBytes = await File(pickedFile.path).readAsBytes();
      final fileName =
          'pets/${pet.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('pets').uploadBinary(
        fileName,
        fileBytes,
        fileOptions: const FileOptions(upsert: true),
      );
      // الرابط
      final publicUrl = supabase.storage.from('pets').getPublicUrl(fileName);
      return publicUrl;

      // await updatePet(newPhotoUrl: publicUrl);

    } catch (e) {
      emit(EditPetProfileError(pet: pet, message: e.toString()));
      return null;
    }
  }

}





