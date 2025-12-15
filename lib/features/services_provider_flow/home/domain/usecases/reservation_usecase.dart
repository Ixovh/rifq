import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/repositories/reservation_repo_domain.dart';

@injectable
class ReservationUseCase {
  final ReservationRepoDomain repository;

  ReservationUseCase(this.repository);

  Future<Result<String?, String>> getProviderIdByAuthId() {
    return repository.getProviderIdByAuthId();
  }

  Future<Result<int?, String>> getProviderServiceType(String providerId) {
    return repository.getProviderServiceType(providerId);
  }

  Future<Result<List<ReservationEntity>, String>> getAllReservations(
    String providerId,
  ) {
    return repository.getAllReservations(providerId);
  }

  Future<Result<AddPetEntity, String>> getSpecificPet(String petId) {
    return repository.getSpecificPet(petId);
  }

  Future<Result<ReservationEntity, String>> getSpecificReservation(
    String reservationId,
  ) {
    return repository.getSpecificReservation(reservationId);
  }

  Future<Result<void, String>> acceptReservation(String reservationId) {
    return repository.acceptReservation(reservationId);
  }

  Future<Result<void, String>> rejectReservation(String reservationId) {
    return repository.rejectReservation(reservationId);
  }

  Future<Result<String?, String>> getServiceItemName(String serviceItemId) {
    return repository.getServiceItemName(serviceItemId);
  }

  Future<Result<void, String>> updateReservationTreatment(
    String reservationId,
    String treatment,
  ) {
    return repository.updateReservationTreatment(reservationId, treatment);
  }
}
