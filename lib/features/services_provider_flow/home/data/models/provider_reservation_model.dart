import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';

part 'provider_reservation_model.mapper.dart';

@MappableClass()
class ProviderReservationModel extends ProviderReservationEntity
    with ProviderReservationModelMappable {
  const ProviderReservationModel({
    required super.id,
    @MappableField(key: 'user_id') required super.userId,
    @MappableField(key: 'pet_id') required super.petId,
    @MappableField(key: 'provider_id') required super.providerId,
    @MappableField(key: 'service_item_id') required super.serviceItemId,
    @MappableField(key: 'notes') super.notes,
    @MappableField(key: 'status') required super.status,
    @MappableField(key: 'start_date') super.startDate,
    @MappableField(key: 'end_date') super.endDate,
    @MappableField(key: 'time') super.time,
    @MappableField(key: 'created_at') super.createdAt,
    super.pet,
  });

  static ProviderReservationModel fromMap(Map<String, dynamic> map) {
    // Extract and parse pet data first
    AddPetEntity? pet;
    if (map['pet'] != null) {
      final petData = map['pet'];
      if (petData is Map<String, dynamic>) {
        pet = PetModelMapper.fromMap(petData);
      }
    }

    // Create a clean map without pet for the mapper
    final cleanMap = Map<String, dynamic>.from(map);
    cleanMap.remove('pet');

    // Use mapper to create base model
    ProviderReservationModel model;
    try {
      model = ProviderReservationModelMapper.fromMap(cleanMap);
    } catch (e) {
      // Fallback: manually create if mapper fails
      return ProviderReservationModel(
        id: map['id'] as String,
        userId: map['user_id'] as String,
        petId: map['pet_id'] as String,
        providerId: map['provider_id'] as String,
        serviceItemId: map['service_item_id'] as String,
        notes: map['notes'] as String?,
        status: map['status'] as String? ?? 'pending',
        startDate: _parseDateTime(map['start_date']),
        endDate: _parseDateTime(map['end_date']),
        time: map['time']?.toString(),
        createdAt: _parseDateTime(map['created_at']),
        pet: pet,
      );
    }

    // Replace with manually parsed pet if available
    if (pet != null) {
      return ProviderReservationModel(
        id: model.id,
        userId: model.userId,
        petId: model.petId,
        providerId: model.providerId,
        serviceItemId: model.serviceItemId,
        notes: model.notes,
        status: model.status,
        startDate: model.startDate,
        endDate: model.endDate,
        time: model.time,
        createdAt: model.createdAt,
        pet: pet,
      );
    }

    return model;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        // Try parsing date only (YYYY-MM-DD)
        final dateOnly = value.split(' ')[0].split('T')[0];
        return DateTime.tryParse(dateOnly);
      }
    }
    return null;
  }
}
