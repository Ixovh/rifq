import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import '../repositories/edit_pet_profile_repo_domain.dart';

@lazySingleton
class EditPetProfileUsecase {
  final EditPetProfileRepoDomain repo;

  EditPetProfileUsecase(this.repo);

  // Future<Result<Null, Object>> updatePetProfile(String id, String name, String imageUrl) async {
  //   return await repo.updatePetProfile(id, name, imageUrl);
  // }



  Future<Result<Map<String, dynamic>, Object>> updatePetProfile(
      String id, String name, String imageUrl) async {
    return await repo.updatePetProfile(id, name, imageUrl);
  }
}
