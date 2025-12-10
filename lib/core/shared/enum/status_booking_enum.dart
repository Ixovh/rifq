import 'package:dart_mappable/dart_mappable.dart';
part 'status_booking_enum.mapper.dart';

@MappableEnum()
enum StatusBookingEnum{
  pending,
  confirmed,
  canceled
}

