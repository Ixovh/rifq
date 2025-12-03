part of 'hotel_cubit.dart';

@immutable
sealed class HotelState {}

final class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<ProviderServiceViewEntity> hotels;
  HotelLoaded(this.hotels);
}

class HotelDetailLoaded extends HotelState {
  final ProviderServiceViewEntity hotel;
  HotelDetailLoaded(this.hotel);
}

class HotelError extends HotelState {
  final String message;
  HotelError(this.message);
}

class HotelLocationOpened extends HotelState {}

