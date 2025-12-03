import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_hotel_state.dart';

class BookingHotelCubit extends Cubit<BookingHotelState> {
  BookingHotelCubit() : super(BookingHotelInitial());
}
