import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/models/provider_items_view_model.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/models/provider_model.dart';

abstract class BaseHotelDataSourc {
  Future<Result<List<ProviderModel>, String>> getAllHotel();
  // تفاصيل فندق معين
  Future<Result<List<ProviderItemsViewModel>, String>> getHotelById(String id);
  Future<Result<List<ProviderModel>, String>> searchHotels(String query);
}

@LazySingleton(as: BaseHotelDataSourc)
class HotelDataBase implements BaseHotelDataSourc {
  final SupabaseClient supabase;
  HotelDataBase(this.supabase);

  @override
  Future<Result<List<ProviderModel>, String>> getAllHotel() async {
    try {
      final response = await supabase
          .from('providers')
          .select('*, provider_services!inner(service_type_id)')
          .eq('provider_services.service_type_id', 4);
      final data = (response as List)
          .map((e) => ProviderModelMapper.fromMap(e))
          .toList();
      return Result.success(data);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
  //
  //

  @override
  Future<Result<List<ProviderItemsViewModel>, String>> getHotelById(
    String id,
  ) async {
    try {
      final response = await supabase
          .from('provider_items_view')
          .select()
          .eq('provider_id', id);

      if (response.isEmpty) {
        return Result.error("Hotel not found");
      }

      final data = (response as List)
          .map((e) => ProviderItemsViewModelMapper.fromMap(e))
          .toList();

      return Result.success(data);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<List<ProviderModel>, String>> searchHotels(String query) async {
    try {
      final response = await supabase
          .from('providers')
          .select('*, provider_services!inner(service_type_id)')
          .eq('provider_services.service_type_id', 4)
          .ilike('name', "%$query%");
      final data = (response as List)
          .map((e) => ProviderModelMapper.fromMap(e))
          .toList();

      return Result.success(data);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}
