import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../domain/entities/provider_profile_entity.dart';
import '../../domain/repositories/provider_profile_repo_domain.dart';
import '../datasources/provider_profile_datasource.dart';

@LazySingleton(as: ProviderProfileRepoDomain)
class ProviderProfileRepoData implements ProviderProfileRepoDomain {
  final BaseProviderProfileDataSource dataSource;
  ProviderProfileRepoData(this.dataSource);

  @override
  Future<Result<ProviderProfileEntity, String>> getProviderProfile(
    String authId,
  ) async {
    return await dataSource.getProviderProfile(authId);
  }

  @override
  Future<Result<ProviderProfileEntity, String>> updateProviderProfile(
    ProviderProfileEntity provider,
  ) async {
    return await dataSource.updateProviderProfile(provider);
  }

  @override
  Future<Result<String, String>> uploadImage(
    String providerId,
    File imageFile,
  ) async {
    return await dataSource.uploadImage(providerId, imageFile);
  }
}
