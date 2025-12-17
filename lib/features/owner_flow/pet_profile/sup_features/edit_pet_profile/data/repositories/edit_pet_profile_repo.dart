import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../domain/repositories/edit_pet_profile_repo_domain.dart';
import '../datasources/edit_pet_profile_datasources.dart';

@LazySingleton(as: EditPetProfileRepoDomain)
class EditPetProfileRepo implements EditPetProfileRepoDomain {
  final BaseEditPetProfile dataSource;

  EditPetProfileRepo(this.dataSource);
  @override
  Future<Result<Map<String, dynamic>, Object>> updatePetProfile(
    String id,
    String name,
    String imageUrl,
  ) async {
    return await dataSource.updatePetProfile(id, name, imageUrl);
  }
}
