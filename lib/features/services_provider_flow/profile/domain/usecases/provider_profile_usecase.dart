import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart' show Result;
import '../entities/provider_profile_entity.dart';
import '../repositories/provider_profile_repo_domain.dart';

@lazySingleton
class ProviderProfileUsecase {
  final ProviderProfileRepoDomain providerProfileRepo;
  ProviderProfileUsecase({required this.providerProfileRepo});

  Future<Result<ProviderProfileEntity, String>> getProviderProfile(
    String authId,
  ) async {
    return await providerProfileRepo.getProviderProfile(authId);
  }

  Future<Result<ProviderProfileEntity, String>> updateProviderProfile(
    ProviderProfileEntity provider,
  ) async {
    return await providerProfileRepo.updateProviderProfile(provider);
  }

  Future<Result<String, String>> uploadImage(
    String providerId,
    File imageFile,
  ) async {
    return await providerProfileRepo.uploadImage(providerId, imageFile);
  }
}
