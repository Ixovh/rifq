import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/repositories/reservation_repo_domain.dart';

@injectable
class ReservationUseCase {
  final ReservationRepoDomain repository;
  Future<Result<String?, Object>> getProviderIdByAuthId() async {
    return await repository.getProviderIdByAuthId();
  }

  Future<Result<int?, Object>> getProviderServiceType(String providerId) async {
    return await repository.getProviderServiceType(providerId);
  }

  ReservationUseCase(this.repository);

  Future<Result<List<ProviderReservationEntity>, Object>> getAllReservations(
    String providerId,
  ) async {
    return await repository.getAllReservations(providerId);
  }

  Future<Result<AddPetEntity, Object>> getSpecificPet(String petId) async {
    return await repository.getSpecificPet(petId);
  }

  Future<Result<ProviderReservationEntity, Object>> getSpecificReservation(
    String reservationId,
  ) async {
    return await repository.getSpecificReservation(reservationId);
  }

  Future<Result<void, Object>> acceptReservation(String reservationId) async {
    return await repository.acceptReservation(reservationId);
  }

  Future<Result<void, Object>> rejectReservation(String reservationId) async {
    return await repository.rejectReservation(reservationId);
  }

  Future<Result<String?, Object>> getServiceItemName(
    String serviceItemId,
  ) async {
    return await repository.getServiceItemName(serviceItemId);
  }

  Future<Result<void, Object>> updateReservationTreatment(
    String reservationId,
    String treatment,
  ) async {
    return await repository.updateReservationTreatment(
      reservationId,
      treatment,
    );
  }
}
