part of 'booking_details_cubit.dart';

sealed class BookingDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingDetailsInitial extends BookingDetailsState {}

class BookingDetailsLoading extends BookingDetailsState {}

class BookingDetailsSuccess extends BookingDetailsState {
  final ReservationOptEntity booking;

  BookingDetailsSuccess(this.booking);

  @override
  List<Object?> get props => [booking];
}

class BookingDetailsError extends BookingDetailsState {
  final String message;

  BookingDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
