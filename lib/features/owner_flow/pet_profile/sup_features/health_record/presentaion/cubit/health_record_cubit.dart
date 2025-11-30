import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'health_record_state.dart';

class HealthRecordCubit extends Cubit<HealthRecordState> {
  HealthRecordCubit() : super(HealthRecordInitial());
}
