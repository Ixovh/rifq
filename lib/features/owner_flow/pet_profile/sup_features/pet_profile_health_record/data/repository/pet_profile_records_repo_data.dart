import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/health_record_entity.dart';
import '../../domain/repositories/pet_profile_records_repo.dart';
import '../datasourse/pet_prifile_record_data.dart';
import '../model/health_record_model.dart';
import '../model/reservation_model.dart';

@LazySingleton(as:PetProfileRecordsRepo )
class PetProfileRecordsRepoData implements PetProfileRecordsRepo {
  final BaseDataSourcePetReacord datasours;
  PetProfileRecordsRepoData(this.datasours);

  @override
  Future<void> addHealthRecord(HealthRecordEntity record) async {
    final model = HealthRecordModel(
      id: record.id,
      petId: record.petId,
      type: record.type,
      title: record.title,
      description: record.description,
      date: record.date,
      clinicName: record.clinicName,
    );
    await datasours.addHealthRecord(model);
  }


  @override
  Future<List<HealthRecordModel>> getRecordsByPet(String petId) async {
   final result= await datasours.getRecordsByPet(petId);
   return result;
  }

  @override
  Future<List<ReservationModel>> getReservationsByPet(String petId)async {
    final result= await datasours.getReservationsByPet(petId);
    return result;
  }
}