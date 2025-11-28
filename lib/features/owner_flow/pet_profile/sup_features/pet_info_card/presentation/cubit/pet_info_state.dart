part of 'pet_info_cubit.dart';

@immutable
sealed class PetInfoState {}

final class PetInfoInitial extends PetInfoState {}

final class PetLoading extends PetInfoState {}

final class PetLoaded extends PetInfoState {
  final List<PetProfileEntity> pets;
  PetLoaded(this.pets);
}

final class PetError extends PetInfoState {
  final String msg;

  PetError(this.msg);
}



