import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rifq/features/owner_flow/hotel/sup_feauter/booking_hotel/domain/entity/booking_hotel_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';

import '../../domain/usecase/booking_hotel_usecase.dart';

part 'booking_hotel_state.dart';

class BookingHotelCubit extends Cubit<BookingHotelState> {
  final BookingHotelUsecase bookingusecase;
  BookingHotelCubit(this.bookingusecase) : super(BookingHotelInitial());

  //  الحيوانات الخاصة بالمستخدم
  // Future<void> fetchPets(String userId) async {
  //   emit(BookingHotelLoading());
  //   final result = await bookingusecase.getPetForUser(userId);
  //   result.when(
  //         (success) => emit(PetsLoaded(success)),
  //         (error) => emit(BookingError(message: error.toString())),
  //   );}
  // إنشاء حجز
  Future<void> createBooking(BookingHotelEntity booking) async {
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

