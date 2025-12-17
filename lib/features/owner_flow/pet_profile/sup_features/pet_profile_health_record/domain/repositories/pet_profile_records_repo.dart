import '../entity/health_record_entity.dart';
import '../entity/reservation_entity.dart';


abstract class PetProfileRecordsRepo {
  Future<List<HealthRecordEntity>> getRecordsByPet(String petId);

  Future<List<ReservationEntity>> getReservationsByPet(String petId);

  Future<void> addHealthRecord(HealthRecordEntity record);



}