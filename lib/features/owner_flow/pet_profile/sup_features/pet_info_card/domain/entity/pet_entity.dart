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



}