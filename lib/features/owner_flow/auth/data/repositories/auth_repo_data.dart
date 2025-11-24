
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared_auth/models/auth_model.dart';
import '../datasources/auth_data_source.dart';
import '../../domain/repositories/auth_repo_domain.dart';

@LazySingleton(as: AuthRepoDomain)
class AuthRepoData implements AuthRepoDomain {
  final BaseAuthDataSource authDataSource;

  AuthRepoData({required this.authDataSource});

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async => await authDataSource.login(email: email, password: password);

  //
  //
  //

  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
  }) async =>
      await authDataSource.signUp(name: name, email: email, password: password);

  //
  //
  //

  @override
  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async => await authDataSource.verifyAccount(email: email, otp: otp);
}
