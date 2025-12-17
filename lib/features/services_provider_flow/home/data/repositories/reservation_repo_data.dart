import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/data/datasources/reservation_data_source.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/repositories/reservation_repo_domain.dart';

@LazySingleton(as: ReservationRepoDomain)
class ReservationRepoData implements ReservationRepoDomain {
  final BaseReservationDataSource dataSource;

  ReservationRepoData(this.dataSource);

  @override
  Future<Result<String?, Object>> getProviderIdByAuthId() async {
    final result = await dataSource.getProviderIdByAuthId();
    return result;
  }

  @override
  Future<Result<int?, Object>> getProviderServiceType(String providerId) async {
    final result = await dataSource.getProviderServiceType(providerId);
    return result;
  }

  @override
  Future<Result<List<ProviderReservationEntity>, Object>> getAllReservations(
    String providerId,
  ) async {
    final result = await dataSource.getAllReservations(providerId);
    return result;
  }

  @override
  Future<Result<AddPetEntity, Object>> getSpecificPet(String petId) async {
    final result = await dataSource.getSpecificPet(petId);
    return result;
  }

  @override
  Future<Result<ProviderReservationEntity, Object>> getSpecificReservation(
    String reservationId,
  ) async {
    final result = await dataSource.getSpecificReservation(reservationId);
    return result;
  }

  @override
  Future<Result<void, Object>> acceptReservation(String reservationId) async {
    final result = await dataSource.acceptReservation(reservationId);
    return result;
  }

  @override
  Future<Result<void, Object>> rejectReservation(String reservationId) async {
    final result = await dataSource.rejectReservation(reservationId);
    return result;
  }

  @override
  Future<Result<String?, Object>> getServiceItemName(
    String serviceItemId,
  ) async {
    final result = await dataSource.getServiceItemName(serviceItemId);
    return result;
  }

  @override
  Future<Result<void, Object>> updateReservationTreatment(
    String reservationId,
    String treatment,
  ) async {
    final result = await dataSource.updateReservationTreatment(
      reservationId,
      treatment,
    );
    return result;
  }
}
