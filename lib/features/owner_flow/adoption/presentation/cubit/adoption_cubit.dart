import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adoption_state.dart';

class AdoptionCubit extends Cubit<AdoptionState> {
  AdoptionCubit() : super(AdoptionInitial());
}
