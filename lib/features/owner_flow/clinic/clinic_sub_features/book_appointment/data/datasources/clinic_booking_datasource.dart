import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/models/reservation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class BaseBookingDataSource {
  Future<ReservationModel> createBooking(ReservationModel booking);
}

@LazySingleton(as: BaseBookingDataSource)
class BookingDataSource  implements BaseBookingDataSource {
  final SupabaseClient supabase;

  BookingDataSource(this.supabase);

  @override
  Future<ReservationModel> createBooking(ReservationModel booking) async {
    final response = await supabase
        .from('reservations')
        .insert({
          'user_id': booking.userId,
          'provider_id': booking.providerId,
          'service_item_id': booking.serviceItemId,
          'pet_id': booking.petId,
          'start_date': booking.startDate.toIso8601String(),
          'end_date': booking.endDate?.toIso8601String(),
          'status': booking.status,
          'notes': booking.notes,
          'created_at': booking.createdAt.toIso8601String(),
          'time': booking.time,
        })
        .select()
        .single();

    return ReservationModelMapper.fromMap(response);
  }
}