import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onbording_state.dart';

class OnbordingCubit extends Cubit<int> {
  OnbordingCubit() : super(0);

  void nextPage() {
    if (state < 2) {
      emit(state + 1);
    }
  }

  void skip() {
    emit(2);
  }

  void changePage(int index) {
    emit(index);
  }
}
