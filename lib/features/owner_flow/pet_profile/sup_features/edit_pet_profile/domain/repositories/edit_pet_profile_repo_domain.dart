import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/data/model/pet_profile_model.dart';


abstract class EditPetProfileRepoDomain {
  Future<Result<Null, Object>> updatePetProfile(
      String id, String name, String imageUrl,
      );
}