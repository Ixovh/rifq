import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ai_state.dart';

class AiCubit extends Cubit<AiState> {
  AiCubit() : super(AiInitial());
}
