// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'provider_reservation_model.dart';

class ProviderReservationModelMapper
    extends ClassMapperBase<ProviderReservationModel> {
  ProviderReservationModelMapper._();

  static ProviderReservationModelMapper? _instance;
  static ProviderReservationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ProviderReservationModelMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'ProviderReservationModel';

  static String _$id(ProviderReservationModel v) => v.id;
  static const Field<ProviderReservationModel, String> _f$id = Field(
    'id',
    _$id,
  );
  static String _$userId(ProviderReservationModel v) => v.userId;
  static const Field<ProviderReservationModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
  );
  static String _$petId(ProviderReservationModel v) => v.petId;
  static const Field<ProviderReservationModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static String _$providerId(ProviderReservationModel v) => v.providerId;
  static const Field<ProviderReservationModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    key: r'provider_id',
  );
  static String _$serviceItemId(ProviderReservationModel v) => v.serviceItemId;
  static const Field<ProviderReservationModel, String> _f$serviceItemId = Field(
    'serviceItemId',
    _$serviceItemId,
    key: r'service_item_id',
  );
  static String? _$notes(ProviderReservationModel v) => v.notes;
  static const Field<ProviderReservationModel, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static String _$status(ProviderReservationModel v) => v.status;
  static const Field<ProviderReservationModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime? _$startDate(ProviderReservationModel v) => v.startDate;
  static const Field<ProviderReservationModel, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
    opt: true,
  );
  static DateTime? _$endDate(ProviderReservationModel v) => v.endDate;
  static const Field<ProviderReservationModel, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
    opt: true,
  );
  static String? _$time(ProviderReservationModel v) => v.time;
  static const Field<ProviderReservationModel, String> _f$time = Field(
    'time',
    _$time,
    opt: true,
  );
  static DateTime? _$createdAt(ProviderReservationModel v) => v.createdAt;
  static const Field<ProviderReservationModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
  );
  static AddPetEntity? _$pet(ProviderReservationModel v) => v.pet;
  static const Field<ProviderReservationModel, AddPetEntity> _f$pet = Field(
    'pet',
    _$pet,
    opt: true,
  );

  @override
  final MappableFields<ProviderReservationModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #petId: _f$petId,
    #providerId: _f$providerId,
    #serviceItemId: _f$serviceItemId,
    #notes: _f$notes,
    #status: _f$status,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #time: _f$time,
    #createdAt: _f$createdAt,
    #pet: _f$pet,
  };

  static ProviderReservationModel _instantiate(DecodingData data) {
    return ProviderReservationModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      petId: data.dec(_f$petId),
      providerId: data.dec(_f$providerId),
      serviceItemId: data.dec(_f$serviceItemId),
      notes: data.dec(_f$notes),
      status: data.dec(_f$status),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      time: data.dec(_f$time),
      createdAt: data.dec(_f$createdAt),
      pet: data.dec(_f$pet),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProviderReservationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProviderReservationModel>(map);
  }

  static ProviderReservationModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProviderReservationModel>(json);
  }
}

mixin ProviderReservationModelMappable {
  String toJson() {
    return ProviderReservationModelMapper.ensureInitialized()
        .encodeJson<ProviderReservationModel>(this as ProviderReservationModel);
  }

  Map<String, dynamic> toMap() {
    return ProviderReservationModelMapper.ensureInitialized()
        .encodeMap<ProviderReservationModel>(this as ProviderReservationModel);
  }

  ProviderReservationModelCopyWith<
    ProviderReservationModel,
    ProviderReservationModel,
    ProviderReservationModel
  >
  get copyWith =>
      _ProviderReservationModelCopyWithImpl<
        ProviderReservationModel,
        ProviderReservationModel
      >(this as ProviderReservationModel, $identity, $identity);
  @override
  String toString() {
    return ProviderReservationModelMapper.ensureInitialized().stringifyValue(
      this as ProviderReservationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProviderReservationModelMapper.ensureInitialized().equalsValue(
      this as ProviderReservationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProviderReservationModelMapper.ensureInitialized().hashValue(
      this as ProviderReservationModel,
    );
  }
}

extension ProviderReservationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProviderReservationModel, $Out> {
  ProviderReservationModelCopyWith<$R, ProviderReservationModel, $Out>
  get $asProviderReservationModel => $base.as(
    (v, t, t2) => _ProviderReservationModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProviderReservationModelCopyWith<
  $R,
  $In extends ProviderReservationModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? petId,
    String? providerId,
    String? serviceItemId,
    String? notes,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? time,
    DateTime? createdAt,
    AddPetEntity? pet,
  });
  ProviderReservationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProviderReservationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProviderReservationModel, $Out>
    implements
        ProviderReservationModelCopyWith<$R, ProviderReservationModel, $Out> {
  _ProviderReservationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProviderReservationModel> $mapper =
      ProviderReservationModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? petId,
    String? providerId,
    String? serviceItemId,
    Object? notes = $none,
    String? status,
    Object? startDate = $none,
    Object? endDate = $none,
    Object? time = $none,
    Object? createdAt = $none,
    Object? pet = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (petId != null) #petId: petId,
      if (providerId != null) #providerId: providerId,
      if (serviceItemId != null) #serviceItemId: serviceItemId,
      if (notes != $none) #notes: notes,
      if (status != null) #status: status,
      if (startDate != $none) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (time != $none) #time: time,
      if (createdAt != $none) #createdAt: createdAt,
      if (pet != $none) #pet: pet,
    }),
  );
  @override
  ProviderReservationModel $make(CopyWithData data) => ProviderReservationModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    petId: data.get(#petId, or: $value.petId),
    providerId: data.get(#providerId, or: $value.providerId),
    serviceItemId: data.get(#serviceItemId, or: $value.serviceItemId),
    notes: data.get(#notes, or: $value.notes),
    status: data.get(#status, or: $value.status),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    time: data.get(#time, or: $value.time),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    pet: data.get(#pet, or: $value.pet),
  );

  @override
  ProviderReservationModelCopyWith<$R2, ProviderReservationModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProviderReservationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

