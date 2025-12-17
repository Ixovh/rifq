import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';

part 'adoption_model.mapper.dart';

@MappableClass()
class AdoptionModel extends AdoptionRequestEntity with AdoptionModelMappable {
  AdoptionModel({
    required super.id,
    @MappableField(key: 'pet_id') required super.petId,
    @MappableField(key: 'owner_id') required super.ownerId,
    required super.title,
    required super.description,
    required super.status,
    @MappableField(key: 'created_at') DateTime? createdAt,
  }) : super(createdAt: createdAt ?? DateTime.now());
}
