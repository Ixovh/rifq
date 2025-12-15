import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import '../../domain/usecase/booking_hotel_usecase.dart';

part 'booking_hotel_state.dart';

class BookingHotelCubit extends Cubit<BookingHotelState> {
  final BookingHotelUsecase bookingusecase;
  BookingHotelCubit(this.bookingusecase) : super(BookingHotelInitial());

  // إنشاء حجز
  Future<void> createBooking(ReservationOptEntity booking) async {
  emit(BookingHotelLoading());
  final result = await bookingusecase.createBooking(booking);
  result.when(
        (success) => emit(BookingSuccess(success)),
        (error) => emit(BookingError(message: error.toString())),
  );}

  //  حجز محدد بالـ ID
  Future<void> getBookingById(String id) async {
  emit(BookingHotelLoading());
  final result = await bookingusecase.getBookingById(id);
  result.when(
        (success) => emit(BookingSuccess(success)),
        (error) => emit(BookingError(message: error.toString())),
  );}

}

