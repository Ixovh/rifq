import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pet_profile_state.dart';

class PetProfileCubit extends Cubit<PetProfileState> {
  PetProfileCubit() : super(PetProfileInitial());
}
