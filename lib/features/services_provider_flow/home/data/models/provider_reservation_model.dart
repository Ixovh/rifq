import 'package:dart_mappable/dart_mappable.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';

part 'provider_reservation_model.mapper.dart';

@MappableClass()
class ProviderReservationModel extends ProviderReservationEntity with ProviderReservationModelMappable {
  @MappableField(key: 'user_id')
  @override
  final String userId;

  @MappableField(key: 'pet_id')
  @override
  final String petId;

  @MappableField(key: 'provider_id')
  @override
  final String providerId;

  @MappableField(key: 'service_item_id')
  @override
  final String serviceItemId;

  @MappableField(key: 'notes')
  @override
  final String? notes;

  @MappableField(key: 'status')
  @override
  final String status;

  @MappableField(key: 'start_date')
  @override
  final DateTime? startDate;

  @MappableField(key: 'end_date')
  @override
  final DateTime? endDate;

  @MappableField(key: 'time')
  @override
  final String? time;

  @MappableField(key: 'created_at')
  @override
  final DateTime? createdAt;

  // Pet is handled manually in fromMap since it's nested data
  @override
  final AddPetEntity? pet;

  const ProviderReservationModel({
    required super.id,
    required this.userId,
    required this.petId,
    required this.providerId,
    required this.serviceItemId,
    this.notes,
    required this.status,
    this.startDate,
    this.endDate,
    this.time,
    this.createdAt,
    this.pet,
  }) : super(
         userId: userId,
         petId: petId,
         providerId: providerId,
         serviceItemId: serviceItemId,
         notes: notes,
         status: status,
         startDate: startDate,
         endDate: endDate,
         time: time,
         createdAt: createdAt,
         pet: pet,
       );

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
