import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';

abstract class BookingHotelRepoDomain {
  Future<Result<ReservationOptEntity, String>> createBooking(ReservationOptEntity booking);

  Future<Result<ReservationOptEntity, String>> getBookingById(String id);

  Future<Result<List<PetProfileEntity>,String>> getPetForUser(String userId);

}
