// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'health_record_model.dart';

class HealthRecordModelMapper extends ClassMapperBase<HealthRecordModel> {
  HealthRecordModelMapper._();

  static HealthRecordModelMapper? _instance;
  static HealthRecordModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HealthRecordModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HealthRecordModel';

  static String _$id(HealthRecordModel v) => v.id;
  static const Field<HealthRecordModel, String> _f$id = Field('id', _$id);
  static String _$petId(HealthRecordModel v) => v.petId;
  static const Field<HealthRecordModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static String _$type(HealthRecordModel v) => v.type;
  static const Field<HealthRecordModel, String> _f$type = Field('type', _$type);
  static String? _$title(HealthRecordModel v) => v.title;
  static const Field<HealthRecordModel, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$description(HealthRecordModel v) => v.description;
  static const Field<HealthRecordModel, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static DateTime? _$date(HealthRecordModel v) => v.date;
  static const Field<HealthRecordModel, DateTime> _f$date = Field(
    'date',
    _$date,
    opt: true,
  );
  static String? _$clinicName(HealthRecordModel v) => v.clinicName;
  static const Field<HealthRecordModel, String> _f$clinicName = Field(
    'clinicName',
    _$clinicName,
    key: r'clinic_name',
    opt: true,
  );

  @override
  final MappableFields<HealthRecordModel> fields = const {
    #id: _f$id,
    #petId: _f$petId,
    #type: _f$type,
    #title: _f$title,
    #description: _f$description,
    #date: _f$date,
    #clinicName: _f$clinicName,
  };

  static HealthRecordModel _instantiate(DecodingData data) {
    return HealthRecordModel(
      id: data.dec(_f$id),
      petId: data.dec(_f$petId),
      type: data.dec(_f$type),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      date: data.dec(_f$date),
      clinicName: data.dec(_f$clinicName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HealthRecordModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HealthRecordModel>(map);
  }

  static HealthRecordModel fromJson(String json) {
    return ensureInitialized().decodeJson<HealthRecordModel>(json);
  }
}

mixin HealthRecordModelMappable {
  String toJson() {
    return HealthRecordModelMapper.ensureInitialized()
        .encodeJson<HealthRecordModel>(this as HealthRecordModel);
  }

  Map<String, dynamic> toMap() {
    return HealthRecordModelMapper.ensureInitialized()
        .encodeMap<HealthRecordModel>(this as HealthRecordModel);
  }

  HealthRecordModelCopyWith<
    HealthRecordModel,
    HealthRecordModel,
    HealthRecordModel
  >
  get copyWith =>
      _HealthRecordModelCopyWithImpl<HealthRecordModel, HealthRecordModel>(
        this as HealthRecordModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HealthRecordModelMapper.ensureInitialized().stringifyValue(
      this as HealthRecordModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HealthRecordModelMapper.ensureInitialized().equalsValue(
      this as HealthRecordModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HealthRecordModelMapper.ensureInitialized().hashValue(
      this as HealthRecordModel,
    );
  }
}

extension HealthRecordModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HealthRecordModel, $Out> {
  HealthRecordModelCopyWith<$R, HealthRecordModel, $Out>
  get $asHealthRecordModel => $base.as(
    (v, t, t2) => _HealthRecordModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class HealthRecordModelCopyWith<
  $R,
  $In extends HealthRecordModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? petId,
    String? type,
    String? title,
    String? description,
    DateTime? date,
    String? clinicName,
  });
  HealthRecordModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _HealthRecordModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HealthRecordModel, $Out>
    implements HealthRecordModelCopyWith<$R, HealthRecordModel, $Out> {
  _HealthRecordModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HealthRecordModel> $mapper =
      HealthRecordModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? petId,
    String? type,
    Object? title = $none,
    Object? description = $none,
    Object? date = $none,
    Object? clinicName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (petId != null) #petId: petId,
      if (type != null) #type: type,
      if (title != $none) #title: title,
      if (description != $none) #description: description,
      if (date != $none) #date: date,
      if (clinicName != $none) #clinicName: clinicName,
    }),
  );
  @override
  HealthRecordModel $make(CopyWithData data) => HealthRecordModel(
    id: data.get(#id, or: $value.id),
    petId: data.get(#petId, or: $value.petId),
    type: data.get(#type, or: $value.type),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    date: data.get(#date, or: $value.date),
    clinicName: data.get(#clinicName, or: $value.clinicName),
  );

  @override
  HealthRecordModelCopyWith<$R2, HealthRecordModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HealthRecordModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

