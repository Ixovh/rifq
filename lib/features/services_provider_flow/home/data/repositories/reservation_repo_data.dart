import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/data/datasources/reservation_data_source.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/repositories/reservation_repo_domain.dart';

@LazySingleton(as: ReservationRepoDomain)
class ReservationRepoData implements ReservationRepoDomain {
  final BaseReservationDataSource dataSource;

  ReservationRepoData(this.dataSource);

  @override
  Future<Result<List<ReservationEntity>, String>> getAllReservations(
    String providerId,
  ) async {
    final result = await dataSource.getAllReservations(providerId);
    return result;
  }

  @override
  Future<Result<AddPetEntity, String>> getSpecificPet(String petId) async {
    final result = await dataSource.getSpecificPet(petId);
    return result;
  }

  @override
  Future<Result<ReservationEntity, String>> getSpecificReservation(
    String reservationId,
  ) async {
    final result = await dataSource.getSpecificReservation(reservationId);
    return result;
  }

  @override
  Future<Result<void, String>> acceptReservation(String reservationId) async {
    final result = await dataSource.acceptReservation(reservationId);
    return result;
  }

  @override
  Future<Result<void, String>> rejectReservation(String reservationId) async {
    final result = await dataSource.rejectReservation(reservationId);
    return result;
  }
}
