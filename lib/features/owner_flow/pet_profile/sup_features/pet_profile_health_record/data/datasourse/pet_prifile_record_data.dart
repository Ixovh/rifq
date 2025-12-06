import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/data/model/health_record_model.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/data/model/reservation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseDataSourcePetReacord{
  Future<List<HealthRecordModel>> getRecordsByPet(String petId);

  Future<List<ReservationModel>> getReservationsByPet(String petId);

  Future<void> addHealthRecord(HealthRecordModel record);
}

@LazySingleton(as: BaseDataSourcePetReacord)

class PetPrifileRecordDataSource implements BaseDataSourcePetReacord {
  final SupabaseClient supabase;
  PetPrifileRecordDataSource(this.supabase);

  @override
  Future<void> addHealthRecord(HealthRecordModel record) async {
    try {
      await supabase.from('health_records').insert({
        'id': record.id,
        'pet_id': record.petId,
        'type': record.type,
        'title': record.title,
        'description': record.description,
        'date': record.date.toIso8601String(),
        'clinic_name': record.clinicName,
      });
    } catch (e) {
      throw Exception('Failed to add health record: $e');
    }
  }


  @override
  Future<List<HealthRecordModel>> getRecordsByPet(String petId)async {
    final data = await supabase
        .from('pet_profile_view')
        .select()
        .eq('pet_id', petId);
    return data.map((e) => HealthRecordModel.fromMap(e)).toList();
  }

  @override
  Future<List<ReservationModel>> getReservationsByPet(String petId) async {
    try {
      final data = await supabase
          .from('pet_profile_view')
          .select()
          .eq('pet_id', petId);
      return data.map((e) => ReservationModel.fromMap(e)).toList();
    } catch (e) {
      throw Exception('Failed to get reservations: $e');
    }
  }


}