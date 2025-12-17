import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';

part 'provider_model.mapper.dart';

@MappableClass()
class ProviderModel extends ProviderEntity with ProviderModelMappable {
  const ProviderModel({
    required super.id,
    required super.name,
    super.image,
    super.location,
    @MappableField(key: 'location_url') super.locationUrl,
    super.phone,
  });
}
