import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/models/reservation_model.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/book_appointment/data/datasources/clinic_booking_datasource.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/book_appointment/domain/repositories/clinic_booking_repo_domain.dart';

@LazySingleton(as: ClinicBookingRepoDomain)
class ClinicBookingRepoData implements ClinicBookingRepoDomain {
  final BaseBookingDataSource dataSource;

  ClinicBookingRepoData(this.dataSource);

@override
  Future<Result<ReservationOptEntity, String>> createBooking(
    ReservationOptEntity booking,
  ) async {
    try {
      final model = ReservationModel(
        id: booking.id,
        userId: booking.userId,
        providerId: booking.providerId,
        serviceItemId: booking.serviceItemId,
        petId: booking.petId,
        startDate: booking.startDate,
        endDate: booking.endDate,
        status: booking.status,
        notes: booking.notes,
        createdAt: booking.createdAt,
        time: booking.time,
      );

      final result = await dataSource.createBooking(model);
      return Result.success(result);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}