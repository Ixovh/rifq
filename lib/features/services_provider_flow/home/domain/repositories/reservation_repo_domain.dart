import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';

abstract class ReservationRepoDomain {
  Future<Result<String?, String>> getProviderIdByAuthId();
  Future<Result<int?, String>> getProviderServiceType(String providerId);
  Future<Result<List<ProviderReservationEntity>, String>> getAllReservations(
    String providerId,
  );
  Future<Result<AddPetEntity, String>> getSpecificPet(String petId);
  Future<Result<ProviderReservationEntity, String>> getSpecificReservation(
    String reservationId,
  );
  Future<Result<void, String>> acceptReservation(String reservationId);
  Future<Result<void, String>> rejectReservation(String reservationId);
  Future<Result<String?, String>> getServiceItemName(String serviceItemId);
  Future<Result<void, String>> updateReservationTreatment(
    String reservationId,
    String treatment,
  );
}
