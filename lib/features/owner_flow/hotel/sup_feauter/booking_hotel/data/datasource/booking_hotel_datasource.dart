import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/shared/shared_in_owner_flow/shared/models/reservation_model.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/data/model/pet_profile_model.dart';

abstract class BaseBookingHotelDataSource {
  Future<Result<ReservationModel, String>> createBooking(
    ReservationModel booking,
  );

  Future<Result<ReservationModel, String>> getBookingById(String id);

  Future<Result<List<PetProfileModel>, String>> getPetForUser(String userId);
}

@LazySingleton(as: BaseBookingHotelDataSource)
class BookingHotelDatasource implements BaseBookingHotelDataSource {
  final SupabaseClient supabase;
  BookingHotelDatasource(this.supabase);
  @override
  Future<Result<ReservationModel, String>> createBooking(
    ReservationModel booking,
  ) async {
    try {
      final response = await supabase
          .from('reservations')
          .insert({
            'user_id': booking.userId,
            'provider_id': booking.providerId,
            'service_item_id': booking.serviceItemId,
            'pet_id': booking.petId,
            'start_date': booking.startDate.toIso8601String(),
            'end_date': booking.endDate!.toIso8601String(),
            'status': booking.status,
            'notes': booking.notes,
            'created_at': booking.createdAt.toIso8601String(),
          })
          .select()
          .single();

      final bookingModel = ReservationModelMapper.fromMap(response);

      return Result.success(bookingModel);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<ReservationModel, String>> getBookingById(String id) async {
    try {
      final response = await supabase
          .from('reservations')
          .select()
          .eq('id', id)
          .single();
      final booking = ReservationModelMapper.fromMap(response);
      return Result.success(booking);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<PetProfileModel>, String>> getPetForUser(
    String userId,
  ) async {
    try {
      final response = await supabase
          .from('pet_profile_view')
          .select()
          .eq('owner_id', userId);
      final pets = response
          .map(
            (e) => PetProfileModelMapper.fromMap(Map<String, dynamic>.from(e)),
          )
          .toList();
      return Result.success(pets);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
