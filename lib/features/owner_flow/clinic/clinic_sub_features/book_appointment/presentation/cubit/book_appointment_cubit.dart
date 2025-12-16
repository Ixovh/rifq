import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/book_appointment/domain/usecases/create_clinic_booking_usecase.dart';

part 'book_appointment_state.dart';


@injectable
class ClinicBookingCubit extends Cubit<ClinicBookingState> {
  final CreateClinicBookingUseCase createBookingUseCase;

  ClinicBookingCubit(this.createBookingUseCase)
      : super(ClinicBookingInitial());

  Future<void> createBooking(ReservationOptEntity booking) async {
    emit(ClinicBookingLoading());

    final result = await createBookingUseCase(booking);

    result.when(
      (success) => emit(ClinicBookingSuccess(success)),
      (error) => emit(ClinicBookingError(error)),
    );
  }

  void reset() {
    emit(ClinicBookingInitial());
  }
}
