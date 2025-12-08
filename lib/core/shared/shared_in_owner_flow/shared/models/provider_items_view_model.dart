import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';


part 'provider_items_view_model.mapper.dart';

@MappableClass()
class ProviderItemsViewModel extends ProviderItemsViewEntity
    with ProviderItemsViewModelMappable {
  const ProviderItemsViewModel({
    required super.itemId,
    required super.itemName,
    super.itemDescription,
    super.price,
    required super.providerId,
    required super.providerName,
    super.providerImage,
    super.phone,
    super.location,
    super.locationUrl,
  });
}
