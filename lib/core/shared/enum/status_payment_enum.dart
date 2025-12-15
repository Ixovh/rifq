import 'package:dart_mappable/dart_mappable.dart';

part 'status_payment_enum.mapper.dart';

@MappableEnum()
enum StatusPaymentEnum{
  initiated,
  paid,
  failed,
  authorized,
  captured,
  refunded,
  voided,
  verified
}
