import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import '../repository/booking_hotel_repo_domain.dart';
@lazySingleton
class BookingHotelUsecase  {
  final BookingHotelRepoDomain bookinkhotel;
  BookingHotelUsecase(this.bookinkhotel);

  Future<Result<ReservationOptEntity, String>> createBooking(ReservationOptEntity booking)async{
    if (booking.userId.isEmpty){
      return Result.error("User ID is required");
    }
    if (booking.petId.isEmpty) {
      return Result.error("Pet is required");
    }
    if (booking.providerId.isEmpty) {
      return Result.error("Provider ID is required");
    }
    if(booking.startDate.isAfter(booking.endDate!)){
      return Result.error("Invalid date range ");
    }
    return bookinkhotel.createBooking(booking);


  }

  //
  //
  Future<Result<ReservationOptEntity, String>> getBookingById(String id)async{
    if (id.isEmpty) {
      return Result.error("Booking ID is required");
    }
    return await bookinkhotel.getBookingById(id);
  }
//
//

Future<Result<List<PetProfileEntity>,String>> getPetForUser(String userId)async{
    if(userId.isEmpty){
      return Result.error("User Id required");
    }
    return bookinkhotel.getPetForUser(userId);

}



}