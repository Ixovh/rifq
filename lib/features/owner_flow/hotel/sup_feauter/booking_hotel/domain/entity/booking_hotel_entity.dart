import '../../../../../../../core/shared/enum/status_booking_enum.dart';

class BookingHotelEntity {
  final String id;
  final String userId;
  final String providerId;
  final String serviceTypeId;//نوع الخدمة
  final String serviceItemId;
  final String petId;
  final DateTime startDate;
  final DateTime endDate;
  final StatusBookingEnum status;
  final String notes;
  final DateTime createdAt;

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