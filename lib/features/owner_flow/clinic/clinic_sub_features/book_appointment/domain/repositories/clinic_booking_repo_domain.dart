import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';


abstract class ClinicBookingRepoDomain {
  Future<Result<ReservationOptEntity, String>> createBooking(
    ReservationOptEntity booking,
  );
}
