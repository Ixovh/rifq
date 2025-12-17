part of 'booking_hotel_cubit.dart';

@immutable
sealed class BookingHotelState {}

final class BookingHotelInitial extends BookingHotelState {}

final class BookingHotelLoading extends BookingHotelState {}

final class BookingSuccess extends BookingHotelState {
  final ReservationOptEntity booking;
  BookingSuccess(this.booking);
}

final class BookingError extends BookingHotelState {
  final String message;
  BookingError({required this.message});
}
