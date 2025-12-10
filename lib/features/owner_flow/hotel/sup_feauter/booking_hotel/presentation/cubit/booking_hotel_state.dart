part of 'booking_hotel_cubit.dart';

@immutable
sealed class BookingHotelState {}

final class BookingHotelInitial extends BookingHotelState {}

final class BookingHotelLoading extends BookingHotelState {}


// // getPets:
// final class PetsLoaded extends BookingHotelState {
//   final List<PetProfileEntity>pets;
//   PetsLoaded(this.pets);
//
// }
final class BookingSuccess extends BookingHotelState {
  final BookingHotelEntity booking;
  BookingSuccess(this.booking);
}
final class BookingError extends BookingHotelState {
  final String message;
  BookingError({required this.message});
}

