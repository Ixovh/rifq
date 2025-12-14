import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/reservation_entity.dart';

abstract class ReservationRepoDomain {
  Future<Result<List<ReservationEntity>, String>> getAllReservations(
    String providerId,
  );
  Future<Result<AddPetEntity, String>> getSpecificPet(String petId);
  Future<Result<ReservationEntity, String>> getSpecificReservation(
    String reservationId,
  );
  Future<Result<void, String>> acceptReservation(String reservationId);
  Future<Result<void, String>> rejectReservation(String reservationId);
}
