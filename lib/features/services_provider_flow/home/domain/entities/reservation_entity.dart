import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

class ReservationEntity {
  final String id;
  final String userId;
  final String petId;
  final String providerId;
  final String serviceItemId; // Changed from serviceId to serviceItemId
  final String? notes; // Changed from note to notes
  final String status; // Changed from ReservationStatus enum to String
  final DateTime? startDate; // Used for boarding
  final DateTime? endDate; // Used for boarding
  final String? time; // Time field from schema
  final DateTime? createdAt; // Created at timestamp
  final AddPetEntity? pet; // Pet details

  const ReservationEntity({
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
