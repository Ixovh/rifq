import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/repositories/add_pet_repo_domain.dart';

class AddPetUseCase {
  final AddPetRepoDomain repository;

  AddPetUseCase(this.repository);

  Future<AddPetEntity> addPet({
    required String ownerId,
    required String name,
    required String species,
    required String gender,
    required String breed,
    required DateTime birthdate,
    required String photoUrl,
  }) {
    return repository.addPet(
      ownerId: ownerId,
      name: name,
      species: species,
      gender: gender,
      breed: breed,
      birthdate: birthdate,
      photoUrl: photoUrl,
    );
  }
}
