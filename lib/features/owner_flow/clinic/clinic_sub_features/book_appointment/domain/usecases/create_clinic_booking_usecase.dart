import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/book_appointment/domain/repositories/clinic_booking_repo_domain.dart';

@injectable
class CreateClinicBookingUseCase {
  final ClinicBookingRepoDomain repo;

  CreateClinicBookingUseCase(this.repo);

  Future<Result<ReservationOptEntity, String>> call(
    ReservationOptEntity booking,
  ) async {

    //!!! VALIDATION

    if (booking.userId.isEmpty) {
      return Result.error('User ID is required');
    }

    if (booking.providerId.isEmpty) {
      return Result.error('Provider ID is required');
    }

    if (booking.petId.isEmpty) {
      return Result.error('Pet ID is required');
    }

    // if (booking.startDate == null) {
    //   return Result.error('Start date is required');
    // }

    if (booking.time == null) {
      return Result.error('Time is required');
    }

    return repo.createBooking(booking);
  }
}
