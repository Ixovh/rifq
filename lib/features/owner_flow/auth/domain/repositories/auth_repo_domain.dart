import 'package:multiple_result/multiple_result.dart';

import '../../../../../core/shared/shared_in_owner_flow/shared_auth/entities/auth_entity.dart';

abstract class AuthRepoDomain {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
  });

  //---------
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  //---------
  Future<Result<AuthEntity, Object>> verifyAccount({
    required String email,
    required String otp,
  });
}
