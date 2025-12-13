import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/services_provider_flow/auth/domain/repositories/provider_auth_repo_domain.dart';
import '../datasources/provider_atuh_data_source.dart';

@LazySingleton(as: ProviderAuthRepoDomain)
class ProviderAuthRepoData implements ProviderAuthRepoDomain {
  final ProviderBaseAuthDataSource _providerAuthDataSource;

  ProviderAuthRepoData(this._providerAuthDataSource);

  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  }) async => await _providerAuthDataSource.signUp(
    name: name,
    email: email,
    password: password,
    commercialRegister: commercialRegister,
    location: location,
    phoneNumber: phoneNumber,
    locationUrl: locationUrl,
  );

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async =>
      await _providerAuthDataSource.login(email: email, password: password);

  @override
  Future<Result<Null, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async =>
      await _providerAuthDataSource.verifyAccount(email: email, otp: otp);

  @override
  Future<Result<Null, Object>> logOut() async =>
      await _providerAuthDataSource.logOut();
  @override
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async =>
      await _providerAuthDataSource.resetPassword(newPassword: newPassword);
  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async =>
      await _providerAuthDataSource.sendPasswordResetEmail(email: email);

  @override
  Future<Result<Null, Object>> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  }) async => await _providerAuthDataSource.selectServiceTypes(
    providerId: providerId,
    serviceTypeIds: serviceTypeIds,
  );

  @override
  Future<Result<Null, Object>> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  }) async => await _providerAuthDataSource.addServiceItem(
    providerId: providerId,
    name: name,
    description: description,
    price: price,
  );

  @override
  Future<Result<String?, Object>> getProviderIdByAuthId() async =>
      await _providerAuthDataSource.getProviderIdByAuthId();
}
