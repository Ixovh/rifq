// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'payment_model.dart';

class PaymentModelMapper extends ClassMapperBase<PaymentModel> {
  PaymentModelMapper._();

  static PaymentModelMapper? _instance;
  static PaymentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaymentModelMapper._());
      StatusPaymentEnumMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PaymentModel';

  static String _$id(PaymentModel v) => v.id;
  static const Field<PaymentModel, String> _f$id = Field('id', _$id);
  static String _$userId(PaymentModel v) => v.userId;
  static const Field<PaymentModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
  );
  static String _$context(PaymentModel v) => v.context;
  static const Field<PaymentModel, String> _f$context = Field(
    'context',
    _$context,
  );
  static String _$contextId(PaymentModel v) => v.contextId;
  static const Field<PaymentModel, String> _f$contextId = Field(
    'contextId',
    _$contextId,
    key: r'context_id',
  );
  static num _$amount(PaymentModel v) => v.amount;
  static const Field<PaymentModel, num> _f$amount = Field('amount', _$amount);
  static StatusPaymentEnum _$status(PaymentModel v) => v.status;
  static const Field<PaymentModel, StatusPaymentEnum> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime _$createdAt(PaymentModel v) => v.createdAt;
  static const Field<PaymentModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<PaymentModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #context: _f$context,
    #contextId: _f$contextId,
    #amount: _f$amount,
    #status: _f$status,
    #createdAt: _f$createdAt,
  };

  static PaymentModel _instantiate(DecodingData data) {
    return PaymentModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      context: data.dec(_f$context),
      contextId: data.dec(_f$contextId),
      amount: data.dec(_f$amount),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PaymentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaymentModel>(map);
  }

  static PaymentModel fromJson(String json) {
    return ensureInitialized().decodeJson<PaymentModel>(json);
  }
}

mixin PaymentModelMappable {
  String toJson() {
    return PaymentModelMapper.ensureInitialized().encodeJson<PaymentModel>(
      this as PaymentModel,
    );
  }

  Map<String, dynamic> toMap() {
    return PaymentModelMapper.ensureInitialized().encodeMap<PaymentModel>(
      this as PaymentModel,
    );
  }

  PaymentModelCopyWith<PaymentModel, PaymentModel, PaymentModel> get copyWith =>
      _PaymentModelCopyWithImpl<PaymentModel, PaymentModel>(
        this as PaymentModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PaymentModelMapper.ensureInitialized().stringifyValue(
      this as PaymentModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaymentModelMapper.ensureInitialized().equalsValue(
      this as PaymentModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PaymentModelMapper.ensureInitialized().hashValue(
      this as PaymentModel,
    );
  }
}

extension PaymentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PaymentModel, $Out> {
  PaymentModelCopyWith<$R, PaymentModel, $Out> get $asPaymentModel =>
      $base.as((v, t, t2) => _PaymentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PaymentModelCopyWith<$R, $In extends PaymentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? context,
    String? contextId,
    num? amount,
    StatusPaymentEnum? status,
    DateTime? createdAt,
  });
  PaymentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PaymentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PaymentModel, $Out>
    implements PaymentModelCopyWith<$R, PaymentModel, $Out> {
  _PaymentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaymentModel> $mapper =
      PaymentModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? context,
    String? contextId,
    num? amount,
    StatusPaymentEnum? status,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (context != null) #context: context,
      if (contextId != null) #contextId: contextId,
      if (amount != null) #amount: amount,
      if (status != null) #status: status,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  PaymentModel $make(CopyWithData data) => PaymentModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    context: data.get(#context, or: $value.context),
    contextId: data.get(#contextId, or: $value.contextId),
    amount: data.get(#amount, or: $value.amount),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  PaymentModelCopyWith<$R2, PaymentModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PaymentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

