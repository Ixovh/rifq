import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/services_provider_flow/home/data/models/reservation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseReservationDataSource {
  Future<Result<List<ReservationModel>, String>> getAllReservations(
    String providerId,
  );
  Future<Result<PetModel, String>> getSpecificPet(String petId);
  Future<Result<ReservationModel, String>> getSpecificReservation(
    String reservationId,
  );
  Future<Result<void, String>> acceptReservation(String reservationId);
  Future<Result<void, String>> rejectReservation(String reservationId);
  Future<Result<int?, String>> getProviderServiceType(String providerId);
  Future<Result<String?, String>> getServiceItemName(String serviceItemId);
  Future<Result<void, String>> updateReservationTreatment(
    String reservationId,
    String treatment,
  );
}

@LazySingleton(as: BaseReservationDataSource)
class ReservationDataSource implements BaseReservationDataSource {
  final SupabaseClient supabase;

  ReservationDataSource(this.supabase);

  String _extractErrorMessage(Object error) {
    return CatchErrorMessage(error: error).getWriteMessage();
  }

  @override
  Future<Result<List<ReservationModel>, String>> getAllReservations(
    String providerId,
  ) async {
    try {
      final response = await supabase
          .from('reservations')
          .select('*, pet:pets(*)')
          .eq('provider_id', providerId)
          .order('created_at', ascending: false);

      if (response.isEmpty) {
        return Result.success([]);
      }

      final reservations = (response as List)
          .map((item) => ReservationModel.fromMap(item as Map<String, dynamic>))
          .toList();

      return Result.success(reservations);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<PetModel, String>> getSpecificPet(String petId) async {
    try {
      final response = await supabase
          .from('pets')
          .select()
          .eq('id', petId)
          .maybeSingle();

      if (response == null) {
        return Result.error('Pet not found');
      }

      final pet = PetModelMapper.fromMap(response);
      return Result.success(pet);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<ReservationModel, String>> getSpecificReservation(
    String reservationId,
  ) async {
    try {
      final response = await supabase
          .from('reservations')
          .select('*, pet:pets(*)')
          .eq('id', reservationId)
          .maybeSingle();

      if (response == null) {
        return Result.error('Reservation not found');
      }

      final reservation = ReservationModel.fromMap(response);
      return Result.success(reservation);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<void, String>> acceptReservation(String reservationId) async {
    try {
      final response = await supabase
          .from('reservations')
          .update({'status': 'accepted'})
          .eq('id', reservationId)
          .select()
          .maybeSingle();

      if (response == null) {
        return Result.error(
          'Failed to accept reservation. Reservation not found.',
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<void, String>> rejectReservation(String reservationId) async {
    try {
      final response = await supabase
          .from('reservations')
          .update({'status': 'rejected'})
          .eq('id', reservationId)
          .select()
          .maybeSingle();

      if (response == null) {
        return Result.error(
          'Failed to reject reservation. Reservation not found.',
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<int?, String>> getProviderServiceType(String providerId) async {
    try {
      // Get the service type ID from provider_services table
      // Check for clinic (1) or boarding (4)
      final response = await supabase
          .from('provider_services')
          .select('service_type_id')
          .eq('provider_id', providerId)
          .inFilter('service_type_id', [1, 4])
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return Result.success(null);
      }

      final serviceTypeId = response['service_type_id'] as int?;
      return Result.success(serviceTypeId);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<String?, String>> getServiceItemName(
    String serviceItemId,
  ) async {
    try {
      final response = await supabase
          .from('provider_service_items')
          .select('name')
          .eq('id', serviceItemId)
          .maybeSingle();

      if (response == null) {
        return Result.success(null);
      }

      final serviceName = response['name'] as String?;
      return Result.success(serviceName);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }

  @override
  Future<Result<void, String>> updateReservationTreatment(
    String reservationId,
    String treatment,
  ) async {
    try {
      final response = await supabase
          .from('reservations')
          .update({'notes': treatment})
          .eq('id', reservationId)
          .select()
          .maybeSingle();

      if (response == null) {
        return Result.error(
          'Failed to update treatment. Reservation not found.',
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(_extractErrorMessage(e));
    }
  }
}
