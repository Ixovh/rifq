import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entity/reservation_entity.dart';
import '../repositories/reservation_repository.dart';

@lazySingleton
class ReservationUsecase {
  final ReservationRepository repository;

  ReservationUsecase(this.repository);

  Future<Result<List<ReservationEntity>, String>> getReservationsByPet(String petId) async {
    try {
      final reservations = await repository.getReservationsByPet(petId);
      return Success(reservations);
    } catch (e) {
      return Error(e.toString());
    }
  }
}