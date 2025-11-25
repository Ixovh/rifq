import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/profile/data/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_profile_entity.dart';

abstract class BaseUserProfileDataSourc{
  Future<Result<UserProfileModel, String>> getUserProfile(String authId);
  Future<Result<UserProfileModel, String>> updateUserProfile(UserProfileEntity user);
}

@LazySingleton(as: BaseUserProfileDataSourc)
class DataBaseDataSource implements BaseUserProfileDataSourc{
  final SupabaseClient supabase;
  DataBaseDataSource(this.supabase);

  @override
  Future<Result<UserProfileModel, String>> getUserProfile(String authId) async {
    try {
      final response = await supabase.from('users')
          .select()
          .eq('auth_id', authId)
          .maybeSingle();
      if (response == null) return Result.error("User not found");
      final user = UserProfileModelMapper.fromMap(response);
      return Result.success(user);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<UserProfileModel, String>> updateUserProfile(UserProfileEntity user) async {
    try {
      final response = await supabase
          .from('users')
          .update({'name': user.name, 'email': user.email,})
          .eq('id', user.id)
          .select()
          .maybeSingle();
      if (response == null) return Result.error("Failed to update user");
      final updatedUser = UserProfileModelMapper.fromMap(response);
      return Result.success(updatedUser);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
