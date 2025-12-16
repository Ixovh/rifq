part of 'edit_pet_profile_cubit.dart';

@immutable
sealed class EditPetProfileState {
  final PetProfileEntity pet;

  const EditPetProfileState({required this.pet});

}

final class EditPetProfileInitial extends EditPetProfileState {
  const EditPetProfileInitial({required super.pet});

}

class EditPetProfileLoading extends EditPetProfileState {
  const EditPetProfileLoading({required super.pet});

}

class EditPetProfileSuccess extends EditPetProfileState {
  const EditPetProfileSuccess({required super.pet});

}

class EditPetProfileError extends EditPetProfileState {
  final String message;
  const EditPetProfileError({required super.pet, required this.message});
}
