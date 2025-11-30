part of 'edit_pet_profile_cubit.dart';

@immutable
sealed class EditPetProfileState {
  final PetProfileEntity pet;

  EditPetProfileState({required this.pet});

}

final class EditPetProfileInitial extends EditPetProfileState {
  EditPetProfileInitial({required super.pet});

}

class EditPetProfileLoading extends EditPetProfileState {
  EditPetProfileLoading({required super.pet});

}

class EditPetProfileSuccess extends EditPetProfileState {
  EditPetProfileSuccess({required super.pet});

}

class EditPetProfileError extends EditPetProfileState {
  final String message;
  EditPetProfileError({required super.pet, required this.message});
}
