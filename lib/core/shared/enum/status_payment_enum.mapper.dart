// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'status_payment_enum.dart';

class StatusPaymentEnumMapper extends EnumMapper<StatusPaymentEnum> {
  StatusPaymentEnumMapper._();

  static StatusPaymentEnumMapper? _instance;
  static StatusPaymentEnumMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StatusPaymentEnumMapper._());
    }
    return _instance!;
  }

  static StatusPaymentEnum fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  StatusPaymentEnum decode(dynamic value) {
    switch (value) {
      case r'initiated':
        return StatusPaymentEnum.initiated;
      case r'paid':
        return StatusPaymentEnum.paid;
      case r'failed':
        return StatusPaymentEnum.failed;
      case r'authorized':
        return StatusPaymentEnum.authorized;
      case r'captured':
        return StatusPaymentEnum.captured;
      case r'refunded':
        return StatusPaymentEnum.refunded;
      case r'voided':
        return StatusPaymentEnum.voided;
      case r'verified':
        return StatusPaymentEnum.verified;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(StatusPaymentEnum self) {
    switch (self) {
      case StatusPaymentEnum.initiated:
        return r'initiated';
      case StatusPaymentEnum.paid:
        return r'paid';
      case StatusPaymentEnum.failed:
        return r'failed';
      case StatusPaymentEnum.authorized:
        return r'authorized';
      case StatusPaymentEnum.captured:
        return r'captured';
      case StatusPaymentEnum.refunded:
        return r'refunded';
      case StatusPaymentEnum.voided:
        return r'voided';
      case StatusPaymentEnum.verified:
        return r'verified';
    }
  }
}

extension StatusPaymentEnumMapperExtension on StatusPaymentEnum {
  String toValue() {
    StatusPaymentEnumMapper.ensureInitialized();
    return MapperContainer.globals.toValue<StatusPaymentEnum>(this) as String;
  }
}

