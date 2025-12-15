import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/data/datasources/booking_details_data_source.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/domain/repositories/booking_details_repo_domain.dart';


@LazySingleton(as: BookingDetailsRepoDomain)
class BookingDetailsRepoData implements BookingDetailsRepoDomain {
  final BaseBookingDetailsDataSource dataSource;

  BookingDetailsRepoData(this.dataSource);

  @override
  Future<Result<ReservationOptEntity, String>> createBooking(
    ReservationOptEntity booking,
  ) async {
    try {
      final result = await dataSource.createBooking(booking);
      return Result.success(result);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}