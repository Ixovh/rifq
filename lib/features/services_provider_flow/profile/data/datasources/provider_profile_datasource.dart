import 'dart:io';
import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/services_provider_flow/profile/data/models/provider_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/provider_profile_entity.dart';

abstract class BaseProviderProfileDataSource {
  Future<Result<ProviderProfileModel, String>> getProviderProfile(
    String authId,
  );
  Future<Result<ProviderProfileModel, String>> updateProviderProfile(
    ProviderProfileEntity provider,
  );
  Future<Result<String, String>> uploadImage(String providerId, File imageFile);
}

@LazySingleton(as: BaseProviderProfileDataSource)
class ProviderProfileDataSource implements BaseProviderProfileDataSource {
  final SupabaseClient supabase;
  ProviderProfileDataSource(this.supabase);

  @override
  Future<Result<ProviderProfileModel, String>> getProviderProfile(
    String authId,
  ) async {
    try {
      final response = await supabase
          .from('providers')
          .select()
          .eq('auth_id', authId)
          .maybeSingle();
      if (response == null) return Result.error("Provider not found");
      final provider = ProviderProfileModelMapper.fromMap(response);
      return Result.success(provider);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<ProviderProfileModel, String>> updateProviderProfile(
    ProviderProfileEntity provider,
  ) async {
    try {
      final response = await supabase
          .from('providers')
          .update({
            'name': provider.name,
            'email': provider.email,
            'phone': provider.phone,
            'location': provider.location,
            'commercial_register': provider.commercialRegister,
            'location_url': provider.locationUrl,
            'image': provider.image,
          })
          .eq('id', provider.id)
          .select()
          .maybeSingle();
      if (response == null) return Result.error("Failed to update provider");
      final updatedProvider = ProviderProfileModelMapper.fromMap(response);
      return Result.success(updatedProvider);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<String, String>> uploadImage(
    String providerId,
    File imageFile,
  ) async {
    try {
      final Uint8List fileBytes = await imageFile.readAsBytes();
      final fileName =
          'providers/${providerId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage
          .from('providers')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = supabase.storage
          .from('providers')
          .getPublicUrl(fileName);
      return Result.success(publicUrl);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
