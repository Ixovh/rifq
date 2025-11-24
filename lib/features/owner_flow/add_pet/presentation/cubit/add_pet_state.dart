part of 'add_pet_cubit.dart';

sealed class AddPetState extends Equatable {
  const AddPetState();

  @override
  List<Object> get props => [];
}

final class AddPetInitial extends AddPetState {}
