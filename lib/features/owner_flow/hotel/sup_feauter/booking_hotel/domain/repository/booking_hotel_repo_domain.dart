import 'package:multiple_result/multiple_result.dart';

import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import '../entity/booking_hotel_entity.dart';

abstract class BookingHotelRepoDomain {
  Future<Result<BookingHotelEntity, String>> createBooking(BookingHotelEntity booking);

  Future<Result<BookingHotelEntity, String>> getBookingById(String id);

  Future<Result<List<PetProfileEntity>,String>> getPetForUser(String userId);

}
