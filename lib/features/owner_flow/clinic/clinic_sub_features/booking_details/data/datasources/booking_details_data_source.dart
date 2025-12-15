import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseBookingDetailsDataSource {
  Future<ReservationOptEntity> createBooking(ReservationOptEntity booking);

}

@LazySingleton(as: BaseBookingDetailsDataSource)
class BookingDetailsDataSource implements BaseBookingDetailsDataSource {
  final SupabaseClient client;

  BookingDetailsDataSource(this.client);

  //!!---------------------CREATE BOOKING-----------------------------

  @override
    Future<ReservationOptEntity> createBooking(
    ReservationOptEntity booking,
  ) async {
    await client.from('reservations').insert({
      'user_id': booking.userId,
      'provider_id': booking.providerId,
      'service_item_id': booking.serviceItemId,
      'pet_id': booking.petId,
      'start_date': booking.startDate.toIso8601String(),
      'time': booking.time,
      'status': booking.status,
      'notes': booking.notes,
      'created_at': booking.createdAt.toIso8601String(),
    });
     return booking;
  }
}
