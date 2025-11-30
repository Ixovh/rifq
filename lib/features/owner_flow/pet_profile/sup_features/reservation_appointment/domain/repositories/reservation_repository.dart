import 'package:multiple_result/multiple_result.dart';
import '../entity/reservation_entity.dart';


abstract class ReservationRepository {
  Future<List<ReservationEntity>> getReservationsByPet(String petId);

}