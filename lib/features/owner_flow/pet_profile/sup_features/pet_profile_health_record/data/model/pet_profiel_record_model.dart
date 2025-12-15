// import 'package:dart_mappable/dart_mappable.dart';
//
// import '../../domain/entity/health_record_entity.dart';
// import '../../domain/entity/pet_profile_records_entity.dart';
// import '../../domain/entity/reservation_entity.dart';
//
// part 'pet_profiel_record_model.mapper.dart';
//
// @MappableClass()
// class PetProfileRecordModel  extends PetEntity with PetProfileRecordModelMappable {
//
//
//   PetProfileRecordModel({
//     @MappableField(key: 'pet_id')required super.petId,
//    @MappableField(key: 'owner_id')  required super.ownerId,
//     @MappableField(key: 'owner_id')   required super.ownerName,
//     @MappableField(key: 'pet_name')  required super.petName,
//     @MappableField(key: 'pet_species')  required super.petSpecies,
//     @MappableField(key: 'pet_breed')  required super.petBreed,
//     @MappableField(key: 'pet_birthdate')  required super.petBirthdate,
//     @MappableField(key: 'pet_photo')   required super.petPhoto,
//     @MappableField(key: 'pet_gender') required super.petGender,
//     @MappableField(key: 'health_records') required super.healthRecords,
//      required super.reservations});
//
//   /// تحويل  Entity
//   PetEntity toEntity() {
//     return PetEntity(
//       petId: petId,
//       ownerId: ownerId,
//       ownerName: ownerName,
//       petName: petName,
//       petSpecies: petSpecies,
//       petBreed: petBreed,
//       petBirthdate: petBirthdate,
//       petPhoto: petPhoto,
//       petGender: petGender,
//       healthRecords: healthRecords.map((e) => e.toEntity()).toList(),
//       reservations: reservations.map((e) => e.toEntity()).toList(),
//     );
//   }
// }
//
//


import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/data/model/reservation_model.dart';

import '../../domain/entity/pet_profile_records_entity.dart';
import 'health_record_model.dart';

part 'pet_profiel_record_model.mapper.dart';

@MappableClass()
class PetProfileRecordModel  with PetProfileRecordModelMappable {
 final String petId;
 final String ownerId;
 final String? ownerName;
 // final String ownerName;
 final String petName;
 final String petSpecies;
 final String petBreed;
 final DateTime petBirthdate;
 final String petPhoto;
 final String petGender;
 final List<HealthRecordModel> healthRecords;
 final List<ReservationModel> reservations;

 PetProfileRecordModel({
  @MappableField(key: 'pet_id') required this.petId,
  @MappableField(key: 'owner_id') required this.ownerId,
  @MappableField(key: 'owner_name')  this.ownerName,
  @MappableField(key: 'pet_name') required this.petName,
  @MappableField(key: 'pet_species') required this.petSpecies,
  @MappableField(key: 'pet_breed') required this.petBreed,
  @MappableField(key: 'pet_birthdate') required this.petBirthdate,
  @MappableField(key: 'pet_photo') required this.petPhoto,
  @MappableField(key: 'pet_gender') required this.petGender,

  @MappableField(key: 'health_records') required this.healthRecords,
  @MappableField(key: 'reservations') required this.reservations,
 });

 /// تحويل للمس Entity
 PetEntity toEntity() {
  return PetEntity(
   petId: petId,
   ownerId: ownerId,
   ownerName: ownerName,
   petName: petName,
   petSpecies: petSpecies,
   petBreed: petBreed,
   petBirthdate: petBirthdate,
   petPhoto: petPhoto,
   petGender: petGender,
   healthRecords: healthRecords.map((e) => e.toEntity()).toList(),
   reservations: reservations.map((e) => e.toEntity()).toList(),
  );
 }
}
