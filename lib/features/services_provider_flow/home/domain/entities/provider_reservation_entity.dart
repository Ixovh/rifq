import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

class ProviderReservationEntity {
  final String id;
  final String userId;
  final String petId;
  final String providerId;
  final String serviceItemId;
  final String? notes;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? time;
  final DateTime? createdAt;
  final AddPetEntity? pet;

  const ProviderReservationEntity({
    required this.id,
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
  });
}
