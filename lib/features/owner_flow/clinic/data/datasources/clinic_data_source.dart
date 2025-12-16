import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/models/provider_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class BaseClinicDataSource {
  Future<Result<List<ProviderModel>, String>> getClinics();

  Future<Result<List<ProviderModel>, String>> searchClinics(String query);

  Future<List<Map<String, dynamic>>> fetchUserPets(String ownerId);
}

@LazySingleton(as: BaseClinicDataSource)
class ClinicDataSource implements BaseClinicDataSource {
  final SupabaseClient supabase;

  ClinicDataSource(this.supabase);

  //!!---------------------GET CLINICS-----------------------------
  @override
  Future<Result<List<ProviderModel>, String>> getClinics() async {
    try {
      final response = await supabase
          .from('providers')
          .select('*, provider_services!inner(service_type_id)')
          .eq(
            'provider_services.service_type_id',
            1,
          ); //!!this query filters clinics only!!!

      final data = (response as List)
          .map((e) => ProviderModelMapper.fromMap(e))
          .toList();

      return Result.success(data);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  //!!---------------------SEARCH CLINICS-----------------------------
  @override
  Future<Result<List<ProviderModel>, String>> searchClinics(
    String query,
  ) async {
    try {
      final response = await supabase
          .from('providers')
          .select('*, provider_services!inner(service_type_id)')
          .eq('provider_services.service_type_id', 1)
          .ilike('name', "%$query%");

      final data = (response as List)
          .map((e) => ProviderModelMapper.fromMap(e))
          .toList();

      return Result.success(data);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  //!!---------------------GET CLINIC DETAILS-----------------------------


  //!!----------------FETCH PETS--------------------
  @override
  Future<List<Map<String, dynamic>>> fetchUserPets(String ownerId) async {
    return await supabase.from('pets').select().eq('owner_id', ownerId);
  }
}
