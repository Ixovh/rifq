part of 'book_appointment_cubit.dart';


sealed class ClinicBookingState {}

final class ClinicBookingInitial extends ClinicBookingState {}

final class ClinicBookingLoading extends ClinicBookingState {}

final class ClinicBookingSuccess extends ClinicBookingState {
  final ReservationOptEntity booking;

  ClinicBookingSuccess(this.booking);
}

final class ClinicBookingError extends ClinicBookingState {
  final String message;

  ClinicBookingError(this.message);
}
