class ReservationEntity {
  final String id;
  final String userId;
  final String providerId;
  final String serviceItemId;
  final String petId;
  final String? time;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String? notes;
  final DateTime createdAt;

  ReservationEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceItemId,
    required this.petId,
     this.time,
    required this.startDate,
    required this.endDate,
    required this.status,
     this.notes,
    required this.createdAt,
  });
}
