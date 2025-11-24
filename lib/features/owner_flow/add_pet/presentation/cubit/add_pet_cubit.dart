import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  AddPetCubit() : super(AddPetInitial());
}
