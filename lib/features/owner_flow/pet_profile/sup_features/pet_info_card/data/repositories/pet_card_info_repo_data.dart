import 'package:injectable/injectable.dart';
import '../../domain/entity/pet_entity.dart';
import '../../domain/repositories/pet_profile_repo_domain.dart';
import '../datasources/pet_card_info_datasources.dart';

@LazySingleton(as: PetProfileRepoDomain)
class RepoDataPet implements PetProfileRepoDomain {
  final PatCard  dataSource;

  RepoDataPet(this.dataSource);

  @override
  Future<PetProfileEntity> getPetById(String petId) async{
    final result = await dataSource.getPetById(petId);
    return result;
  }

  @override
  Future<List<PetProfileEntity>> getPetsByOwner(String ownerId) async{
    final result = await dataSource.getPetsByOwner(ownerId);
    return result;
  }




}