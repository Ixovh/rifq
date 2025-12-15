import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/models/provider_items_view_model.dart';


abstract class BaseClinicDetailsDataSource {
  Future<ProviderItemsViewModel> getClinicDetails(String providerId);
}

@LazySingleton(as: BaseClinicDetailsDataSource)
class ClinicDetailsDataSource implements BaseClinicDetailsDataSource {
  final SupabaseClient supabase;

  ClinicDetailsDataSource(this.supabase);

  @override
  Future<ProviderItemsViewModel> getClinicDetails(String providerId) async {
    final response = await supabase
        .from('provider_items_view')
        .select()
        .eq('provider_id', providerId)
        .maybeSingle();

    if (response == null) throw "Clinic not found";

    return ProviderItemsViewModelMapper.fromMap(response);
  }
}
