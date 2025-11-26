// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'reservation_model.dart';

class ReservationModelMapper extends ClassMapperBase<ReservationModel> {
  ReservationModelMapper._();

  static ReservationModelMapper? _instance;
  static ReservationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReservationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReservationModel';

  static String _$id(ReservationModel v) => v.id;
  static const Field<ReservationModel, String> _f$id = Field('id', _$id);
  static String _$userId(ReservationModel v) => v.userId;
  static const Field<ReservationModel, String> _f$userId = Field(
    'userId',
    _$userId,
  );
  static String _$providerId(ReservationModel v) => v.providerId;
  static const Field<ReservationModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
  );
  static int _$serviceTypeId(ReservationModel v) => v.serviceTypeId;
  static const Field<ReservationModel, int> _f$serviceTypeId = Field(
    'serviceTypeId',
    _$serviceTypeId,
  );
  static String _$serviceItemId(ReservationModel v) => v.serviceItemId;
  static const Field<ReservationModel, String> _f$serviceItemId = Field(
    'serviceItemId',
    _$serviceItemId,
  );
  static String _$petId(ReservationModel v) => v.petId;
  static const Field<ReservationModel, String> _f$petId = Field(
    'petId',
    _$petId,
  );
  static DateTime _$date(ReservationModel v) => v.date;
  static const Field<ReservationModel, DateTime> _f$date = Field(
    'date',
    _$date,
  );
  static DateTime _$startDate(ReservationModel v) => v.startDate;
  static const Field<ReservationModel, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static DateTime _$endDate(ReservationModel v) => v.endDate;
  static const Field<ReservationModel, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
  );
  static String _$status(ReservationModel v) => v.status;
  static const Field<ReservationModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static String _$notes(ReservationModel v) => v.notes;
  static const Field<ReservationModel, String> _f$notes = Field(
    'notes',
    _$notes,
  );
  static DateTime _$createdAt(ReservationModel v) => v.createdAt;
  static const Field<ReservationModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<ReservationModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #providerId: _f$providerId,
    #serviceTypeId: _f$serviceTypeId,
    #serviceItemId: _f$serviceItemId,
    #petId: _f$petId,
    #date: _f$date,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #status: _f$status,
    #notes: _f$notes,
    #createdAt: _f$createdAt,
  };

  static ReservationModel _instantiate(DecodingData data) {
    return ReservationModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      providerId: data.dec(_f$providerId),
      serviceTypeId: data.dec(_f$serviceTypeId),
      serviceItemId: data.dec(_f$serviceItemId),
      petId: data.dec(_f$petId),
      date: data.dec(_f$date),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      status: data.dec(_f$status),
      notes: data.dec(_f$notes),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ReservationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReservationModel>(map);
  }

  static ReservationModel fromJson(String json) {
    return ensureInitialized().decodeJson<ReservationModel>(json);
  }
}

mixin ReservationModelMappable {
  String toJson() {
    return ReservationModelMapper.ensureInitialized()
        .encodeJson<ReservationModel>(this as ReservationModel);
  }

  Map<String, dynamic> toMap() {
    return ReservationModelMapper.ensureInitialized()
        .encodeMap<ReservationModel>(this as ReservationModel);
  }

  ReservationModelCopyWith<ReservationModel, ReservationModel, ReservationModel>
  get copyWith =>
      _ReservationModelCopyWithImpl<ReservationModel, ReservationModel>(
        this as ReservationModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ReservationModelMapper.ensureInitialized().stringifyValue(
      this as ReservationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ReservationModelMapper.ensureInitialized().equalsValue(
      this as ReservationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ReservationModelMapper.ensureInitialized().hashValue(
      this as ReservationModel,
    );
  }
}

extension ReservationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReservationModel, $Out> {
  ReservationModelCopyWith<$R, ReservationModel, $Out>
  get $asReservationModel =>
      $base.as((v, t, t2) => _ReservationModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ReservationModelCopyWith<$R, $In extends ReservationModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? providerId,
    int? serviceTypeId,
    String? serviceItemId,
    String? petId,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? notes,
    DateTime? createdAt,
  });
  ReservationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ReservationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReservationModel, $Out>
    implements ReservationModelCopyWith<$R, ReservationModel, $Out> {
  _ReservationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReservationModel> $mapper =
      ReservationModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? providerId,
    int? serviceTypeId,
    String? serviceItemId,
    String? petId,
    DateTime? date,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? notes,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (userId != null) #userId: userId,
      if (providerId != null) #providerId: providerId,
      if (serviceTypeId != null) #serviceTypeId: serviceTypeId,
      if (serviceItemId != null) #serviceItemId: serviceItemId,
      if (petId != null) #petId: petId,
      if (date != null) #date: date,
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (status != null) #status: status,
      if (notes != null) #notes: notes,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  ReservationModel $make(CopyWithData data) => ReservationModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    providerId: data.get(#providerId, or: $value.providerId),
    serviceTypeId: data.get(#serviceTypeId, or: $value.serviceTypeId),
    serviceItemId: data.get(#serviceItemId, or: $value.serviceItemId),
    petId: data.get(#petId, or: $value.petId),
    date: data.get(#date, or: $value.date),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    status: data.get(#status, or: $value.status),
    notes: data.get(#notes, or: $value.notes),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ReservationModelCopyWith<$R2, ReservationModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ReservationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

