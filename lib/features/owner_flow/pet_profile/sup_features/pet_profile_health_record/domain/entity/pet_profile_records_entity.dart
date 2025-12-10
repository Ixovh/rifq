
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/reservation_entity.dart';

import 'health_record_entity.dart';

class PetEntity {
  final String petId;
  final String ownerId;
  final String ?ownerName;
  final String petName;
  final String petSpecies;
  final String petBreed;
  final DateTime petBirthdate;
  final String petPhoto;
  final String petGender;
  final List<HealthRecordEntity> healthRecords;
  final List<ReservationEntity>  reservations;

  PetEntity({
    required this.petId,
    required this.ownerId,
     this.ownerName,
    required this.petName,
    required this.petSpecies,
    required this.petBreed,
    required this.petBirthdate,
    required this.petPhoto,
    required this.petGender,
    required this.healthRecords,
    required this.reservations,
  });
}
