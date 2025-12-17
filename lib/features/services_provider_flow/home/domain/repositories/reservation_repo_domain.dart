import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';

abstract class ReservationRepoDomain {
  Future<Result<String?, Object>> getProviderIdByAuthId();
  Future<Result<int?, Object>> getProviderServiceType(String providerId);
  Future<Result<List<ProviderReservationEntity>, Object>> getAllReservations(
    String providerId,
  );
  Future<Result<AddPetEntity, Object>> getSpecificPet(String petId);
  Future<Result<ProviderReservationEntity, Object>> getSpecificReservation(
    String reservationId,
  );
  Future<Result<void, Object>> acceptReservation(String reservationId);
  Future<Result<void, Object>> rejectReservation(String reservationId);
  Future<Result<String?, Object>> getServiceItemName(String serviceItemId);
  Future<Result<void, Object>> updateReservationTreatment(
    String reservationId,
    String treatment,
  );
}
