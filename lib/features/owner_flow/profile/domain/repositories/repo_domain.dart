import 'package:multiple_result/multiple_result.dart';

import '../entities/user_profile_entity.dart';

abstract class RepoDomain {
  Future<Result<UserProfileEntity, String>> getUserProfile(String authId);
  Future<Result<UserProfileEntity, String>> updateUserProfile(UserProfileEntity user);


}