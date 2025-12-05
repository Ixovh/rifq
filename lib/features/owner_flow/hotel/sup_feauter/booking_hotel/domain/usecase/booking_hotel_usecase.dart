import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/hotel/sup_feauter/booking_hotel/domain/entity/pet_entity.dart';

import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import '../entity/booking_hotel_entity.dart';
import '../repository/booking_hotel_repo_domain.dart';
@lazySingleton
class BookingHotelUsecase  {
  final BookingHotelRepoDomain bookinkhotel;
  BookingHotelUsecase(this.bookinkhotel);

  Future<Result<BookingHotelEntity, String>> createBooking(BookingHotelEntity booking)async{
    if (booking.userId.isEmpty){
      return Result.error("User ID is required");
    }
    if (booking.petId.isEmpty) {
      return Result.error("Pet is required");
    }
    if (booking.providerId.isEmpty) {
      return Result.error("Provider ID is required");
    }
    return bookinkhotel.createBooking(booking);


  }

  //
  //
  Future<Result<BookingHotelEntity, String>> getBookingById(String id)async{
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