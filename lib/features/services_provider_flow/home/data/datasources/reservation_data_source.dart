import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/services_provider_flow/home/data/models/provider_reservation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseReservationDataSource {
  Future<Result<String?, Object>> getProviderIdByAuthId();
  Future<Result<List<ProviderReservationModel>, Object>> getAllReservations(
    String providerId,
  );
  Future<Result<PetModel, Object>> getSpecificPet(String petId);
  Future<Result<ProviderReservationModel, Object>> getSpecificReservation(
    String reservationId,
  );
  Future<Result<void, Object>> acceptReservation(String reservationId);
  Future<Result<void, Object>> rejectReservation(String reservationId);
  Future<Result<int?, Object>> getProviderServiceType(String providerId);
  Future<Result<String?, Object>> getServiceItemName(String serviceItemId);
  Future<Result<void, Object>> updateReservationTreatment(
    String reservationId,
    String treatment,
  );
}

@LazySingleton(as: BaseReservationDataSource)
class ReservationDataSource implements BaseReservationDataSource {
  final SupabaseClient supabase;

  ReservationDataSource(this.supabase);

  @override
  Future<Result<String?, Object>> getProviderIdByAuthId() async {
    try {
      final authId = supabase.auth.currentUser?.id;
      if (authId == null) {
        return Result.error(CustomException(message: 'Please login first.'));
      }

      final provider = await supabase
          .from('providers')
          .select('id')
          .eq('auth_id', authId)
          .maybeSingle();

      if (provider == null) {
        return Result.error(
          CustomException(
            message: 'Provider account not found. Please sign up first.',
          ),
        );
      }

      return Result.success(provider['id'] as String?);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<List<ProviderReservationModel>, Object>> getAllReservations(
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
          .map(
            (item) =>
                ProviderReservationModel.fromMap(item as Map<String, dynamic>),
          )
          .toList();

      return Result.success(reservations);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<PetModel, Object>> getSpecificPet(String petId) async {
    try {
      final response = await supabase
          .from('pets')
          .select()
          .eq('id', petId)
          .maybeSingle();

      if (response == null) {
        return Result.error(CustomException(message: 'Pet not found'));
      }

      final pet = PetModelMapper.fromMap(response);
      return Result.success(pet);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<ProviderReservationModel, Object>> getSpecificReservation(
    String reservationId,
  ) async {
    try {
      final response = await supabase
          .from('reservations')
          .select('*, pet:pets(*)')
          .eq('id', reservationId)
          .maybeSingle();

      if (response == null) {
        return Result.error(CustomException(message: 'Reservation not found'));
      }

      final reservation = ProviderReservationModel.fromMap(response);
      return Result.success(reservation);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<void, Object>> acceptReservation(String reservationId) async {
    try {
      final response = await supabase
          .from('reservations')
          .update({'status': 'accepted'})
          .eq('id', reservationId)
          .select()
          .maybeSingle();

      if (response == null) {
        return Result.error(
          CustomException(
            message: 'Failed to accept reservation. Reservation not found.',
          ),
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<void, Object>> rejectReservation(String reservationId) async {
    try {
      final response = await supabase
          .from('reservations')
          .update({'status': 'rejected'})
          .eq('id', reservationId)
          .select()
          .maybeSingle();

      if (response == null) {
        return Result.error(
          CustomException(
            message: 'Failed to reject reservation. Reservation not found.',
          ),
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<int?, Object>> getProviderServiceType(String providerId) async {
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
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<String?, Object>> getServiceItemName(
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
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }

  @override
  Future<Result<void, Object>> updateReservationTreatment(
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
          CustomException(
            message: 'Failed to update treatment. Reservation not found.',
          ),
        );
      }

      return Result.success(null);
    } catch (e) {
      return Result.error(
        CustomException(message: CatchErrorMessage(error: e).getWriteMessage()),
      );
    }
  }
}
