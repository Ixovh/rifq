// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'status_booking_enum.dart';

class StatusBookingEnumMapper extends EnumMapper<StatusBookingEnum> {
  StatusBookingEnumMapper._();

  static StatusBookingEnumMapper? _instance;
  static StatusBookingEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StatusBookingEnumMapper._());
    }
    return _instance!;
  }

  static StatusBookingEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StatusBookingEnum decode(dynamic value) {
    switch (value) {
      case r'pending':
        return StatusBookingEnum.pending;
      case r'confirmed':
        return StatusBookingEnum.confirmed;
      case r'canceled':
        return StatusBookingEnum.canceled;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StatusBookingEnum self) {
    switch (self) {
      case StatusBookingEnum.pending:
        return r'pending';
      case StatusBookingEnum.confirmed:
        return r'confirmed';
      case StatusBookingEnum.canceled:
        return r'canceled';
    }
  }
}

extension StatusBookingEnumMapperExtension on StatusBookingEnum {
  String toValue() {
    StatusBookingEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StatusBookingEnum>(this) as String;
  }
}

