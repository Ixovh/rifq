import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';

abstract class ClinicDetailsRepoDomain {
  Future<Result<ProviderItemsViewEntity, String>> getClinicDetails(String providerId);
}
