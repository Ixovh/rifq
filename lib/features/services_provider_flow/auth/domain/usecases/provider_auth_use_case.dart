import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/services_provider_flow/auth/domain/repositories/provider_auth_repo_domain.dart';

@lazySingleton
class ProviderAuthUseCase {
  final ProviderAuthRepoDomain _providerAuthRepo;
  ProviderAuthUseCase(this._providerAuthRepo);

  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  }) async => await _providerAuthRepo.signUp(
    name: name,
    email: email,
    password: password,
    commercialRegister: commercialRegister,
    location: location,
    phoneNumber: phoneNumber,
    locationUrl: locationUrl,
  );

  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async => await _providerAuthRepo.login(email: email, password: password);

  Future<Result<Null, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async => await _providerAuthRepo.verifyAccount(email: email, otp: otp);

  Future<Result<Null, Object>> logOut() async =>
      await _providerAuthRepo.logOut();

  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async => await _providerAuthRepo.resetPassword(newPassword: newPassword);

  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async => await _providerAuthRepo.sendPasswordResetEmail(email: email);

  Future<Result<Null, Object>> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  }) async => await _providerAuthRepo.selectServiceTypes(
    providerId: providerId,
    serviceTypeIds: serviceTypeIds,
  );

  Future<Result<Null, Object>> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  }) async => await _providerAuthRepo.addServiceItem(
    providerId: providerId,
    name: name,
    description: description,
    price: price,
  );

  Future<Result<String?, Object>> getProviderIdByAuthId() async =>
      await _providerAuthRepo.getProviderIdByAuthId();
}
