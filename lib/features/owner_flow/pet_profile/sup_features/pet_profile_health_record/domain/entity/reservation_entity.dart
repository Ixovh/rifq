class ReservationEntity {
  final String id;
  final String userId;
  final String providerId;
  final int serviceTypeId;
  final String serviceItemId;
  final String petId;
  final DateTime date;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String notes;
  final DateTime createdAt;

  ReservationEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceTypeId,
    required this.serviceItemId,
    required this.petId,
    required this.date,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.notes,
    required this.createdAt,
  });
}
