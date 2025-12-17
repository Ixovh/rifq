import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/domain/repositories/booking_details_repo_domain.dart';

@injectable
class BookingDetailsUseCase {
  final BookingDetailsRepoDomain repository;

  BookingDetailsUseCase(this.repository);

  Future<Result<ReservationOptEntity, String>> createBooking(
    ReservationOptEntity booking,
  ) {
    return repository.createBooking(booking);
  }
}
