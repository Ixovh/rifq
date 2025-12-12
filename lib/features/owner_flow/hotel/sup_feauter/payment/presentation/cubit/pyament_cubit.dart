import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pyament_state.dart';

class PyamentCubit extends Cubit<PyamentState> {
  PyamentCubit() : super(PyamentInitial());
}
