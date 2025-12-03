class BookingHotelEntity {
  final String id;
  final String userId;
  final String providerId;
  final String serviceTypeId;//نوع الخدمة
  final String serviceItemId;
  final String petId;
  final String startDate;
  final String endDate;
  final String status;
  final String notes;
  final String createdAt;

  BookingHotelEntity({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.serviceTypeId,
    required this.serviceItemId,
    required this.petId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.notes,
    required this.createdAt,
});



}