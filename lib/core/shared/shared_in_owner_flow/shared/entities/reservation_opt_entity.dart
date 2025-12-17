class ReservationOptEntity {
  final String id;
  final String userId;
  final String providerId;
  final String serviceItemId;
  final String petId;

  final DateTime startDate;
  final DateTime? endDate;
  final String? status;
  final String? notes;
  final DateTime createdAt;
  final String? time;

  const ReservationOptEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceItemId,
    required this.petId,
    required this.startDate,
    this.endDate,
    this.status,
    this.notes,
    required this.createdAt,
    this.time,
  });
}
