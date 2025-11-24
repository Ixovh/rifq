import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

part 'pet_model.mapper.dart';

@MappableClass()
class PetModel extends AddPetEntity with PetModelMappable {
  @MappableField(key: 'owner_id')
  final String ownerIdMapped;

  @MappableField(key: 'photo')
  final String photoMapped;

  @MappableField(key: 'created_at')
  final DateTime createdAt;

  const PetModel({
    required String id,
    required this.ownerIdMapped,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required this.photoMapped,
    required this.createdAt,
  }) : super(
          id: id,
          ownerId: ownerIdMapped,
          name: name,
          species: species,
          gender: gender,
          breed: breed,
          birthdate: birthdate,
          photoUrl: photoMapped,
        );
}
