import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entity/health_record_entity.dart';
import '../entity/reservation_entity.dart';
import '../repositories/pet_profile_records_repo.dart';

@lazySingleton
class HealthRecordUsecase {
  final PetProfileRecordsRepo repository;
  HealthRecordUsecase(this.repository);

  Future<Result<List<HealthRecordEntity>, String>> getRecordsByPet(String petId) async {
    try {
      final records = await repository.getRecordsByPet(petId);
      return Result.success(records);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
  //
 //

  Future<Result<List<ReservationEntity>, String>> getReservationsByPet(String petId) async {
    try {
      final reservations = await repository.getReservationsByPet(petId);
      return Result.success(reservations);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

//
//

  Future<Result<void, String>> addHealthRecord(HealthRecordEntity record)async{
    try{
      await repository.addHealthRecord(record);
      return Result.success(null);

    }catch(e){
      return Result.error(e.toString());
    }

  }

}