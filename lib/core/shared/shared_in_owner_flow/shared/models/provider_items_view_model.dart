import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';


part 'provider_items_view_model.mapper.dart';

@MappableClass()
class ProviderItemsViewModel extends ProviderItemsViewEntity
    with ProviderItemsViewModelMappable {
  const ProviderItemsViewModel({
    @MappableField(key: 'item_id') required super.itemId,
    @MappableField(key: 'item_name') required super.itemName,
    @MappableField(key: 'item_description') super.itemDescription,
    super.price,
    @MappableField(key: 'provider_id') required super.providerId,
    @MappableField(key: 'provider_name') required super.providerName,
    @MappableField(key: 'provider_image') super.providerImage,
    super.phone,
    super.location,
    @MappableField(key: 'location_url') super.locationUrl,
  });
}
