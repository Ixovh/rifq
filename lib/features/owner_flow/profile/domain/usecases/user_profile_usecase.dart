import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' show Result;

import '../entities/user_profile_entity.dart';
import '../repositories/repo_domain.dart';


@lazySingleton
class UserProfileUsecase {
  final RepoDomain userProfileData;
  UserProfileUsecase({required this.userProfileData});

  Future<Result<UserProfileEntity, String>> getUserProfile(String authId) async {
    if (authId.isEmpty) {
      return Result.error("authId cannot be empty");
    }
    final result = await userProfileData.getUserProfile(authId);
    return result.when((success) => Result.success(success), (error) => Result.error(error),);
  }

  Future<Result<UserProfileEntity, String>> updateUserProfile(UserProfileEntity user) async {
    try {
      if (user.id.isEmpty) {
        return Result.error("User ID cannot be empty");
      }
      final result = await userProfileData.updateUserProfile(user);
      return result.when((success) => Result.success(success), (error) => Result.error(error),);
    } catch (e) {
      return Result.error(e.toString());
    }
  }



}
