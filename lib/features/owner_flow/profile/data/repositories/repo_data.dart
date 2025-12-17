import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:rifq/features/owner_flow/profile/domain/entities/user_profile_entity.dart';

import '../../domain/repositories/repo_domain.dart';
import '../datasources/user_profile_datasources.dart';

@LazySingleton(as: RepoDomain)
class RepoData implements RepoDomain {
  final BaseUserProfileDataSourc dataSource;
  RepoData(this.dataSource);

  @override
  Future<Result<UserProfileEntity, String>> getUserProfile(String authId)async {
   final result= await dataSource.getUserProfile(authId);
   return result;

  }

  @override
  Future<Result<UserProfileEntity, String>> updateUserProfile(UserProfileEntity user)async {
    final result = await dataSource.updateUserProfile(user);
    return result;

  }
}