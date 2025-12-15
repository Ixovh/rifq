import 'package:multiple_result/multiple_result.dart';

abstract class ProviderAuthRepoDomain {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required int commercialRegister,
    required String location,
    required String phoneNumber,
    required String locationUrl,
  });

  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  Future<Result<Null, Object>> verifyAccount({
    required String email,
    required String otp,
  });

  Future<Result<Null, Object>> logOut();

  Future<Result<Null, Object>> resetPassword({required String newPassword});

  Future<Result<Null, Object>> sendPasswordResetEmail({required String email});

  Future<Result<Null, Object>> selectServiceTypes({
    required String providerId,
    required List<int> serviceTypeIds,
  });

  Future<Result<Null, Object>> addServiceItem({
    required String providerId,
    required String name,
    required String description,
    required double price,
  });

  Future<Result<String?, Object>> getProviderIdByAuthId();
}
