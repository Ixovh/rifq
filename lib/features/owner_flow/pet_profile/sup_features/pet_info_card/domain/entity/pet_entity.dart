import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/health_record_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/pet_profile_records_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/reservation_entity.dart';

class PetProfileEntity {
  final String id;
  final String name;
  final String breed;
  final String species;
  final DateTime birthdate;
  final String photoUrl;
  final String ownerId;
  final String gender;
  final DateTime createdAt;
  PetProfileEntity({
    required this.id,
    required this.name,
    required this.breed,
    required this.species,
    required this.birthdate,
    required this.photoUrl,
    required this.ownerId,
    required this.gender,
    required this.createdAt
  });


 // اسوي فنكشن تحول من انتيتي ل انتيتي الثانيه


}


extension PetProfileToPetEntity on PetProfileEntity {
  PetEntity toPetEntity({
    String? ownerName,
    List<HealthRecordEntity> healthRecords = const [],
    List<ReservationEntity> reservations = const [],
  }) {
    return PetEntity(
      petId: id,
      ownerId: ownerId,
      ownerName: ownerName ?? 'Unknown',
      petName: name,
      petSpecies: species,
      petBreed: breed,
      petBirthdate: birthdate,
      petPhoto: photoUrl,
      petGender: gender,
      healthRecords: healthRecords,
      reservations: reservations,
    );
  }
}
