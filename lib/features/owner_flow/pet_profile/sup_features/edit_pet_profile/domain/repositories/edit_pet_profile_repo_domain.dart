import 'package:multiple_result/multiple_result.dart';

abstract class EditPetProfileRepoDomain {
  Future<Result<Map<String, dynamic>, Object>> updatePetProfile(
      String id, String name, String imageUrl,);
}