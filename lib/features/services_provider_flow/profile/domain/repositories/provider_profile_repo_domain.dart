import 'dart:io';
import 'package:multiple_result/multiple_result.dart';
import '../entities/provider_profile_entity.dart';

abstract class ProviderProfileRepoDomain {
  Future<Result<ProviderProfileEntity, String>> getProviderProfile(
    String authId,
  );
  Future<Result<ProviderProfileEntity, String>> updateProviderProfile(
    ProviderProfileEntity provider,
  );
  Future<Result<String, String>> uploadImage(String providerId, File imageFile);
}
