part of 'hotel_cubit.dart';

@immutable
sealed class HotelState {}

final class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<ProviderEntity> hotels;
  HotelLoaded(this.hotels);
}

class HotelDetailLoaded extends HotelState {
  final ProviderItemsViewEntity hotel;
  HotelDetailLoaded(this.hotel);
}

class HotelError extends HotelState {
  final String message;
  HotelError(this.message);
}

class HotelLocationOpened extends HotelState {}

// class RoomSelectionChanged extends HotelState {
//   final String roomId;
//   RoomSelectionChanged(this.roomId);
// }

class RoomSelectionChanged extends HotelDetailLoaded {
  final String roomId;
  RoomSelectionChanged(this.roomId, ProviderItemsViewEntity hotel) : super(hotel);
}



//
// class RoomSelectionChanged extends HotelDetailLoaded {
//   final String roomId;
//   RoomSelectionChanged(this.roomId, ProviderItemsViewEntity hotel) : super(hotel);
// }