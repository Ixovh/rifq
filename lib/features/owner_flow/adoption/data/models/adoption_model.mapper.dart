// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'adoption_model.dart';

class AdoptionModelMapper extends ClassMapperBase<AdoptionModel> {
  AdoptionModelMapper._();

  static AdoptionModelMapper? _instance;
  static AdoptionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdoptionModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AdoptionModel';

  static String _$id(AdoptionModel v) => v.id;
  static const Field<AdoptionModel, String> _f$id = Field('id', _$id);
  static String _$petId(AdoptionModel v) => v.petId;
  static const Field<AdoptionModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static String _$ownerId(AdoptionModel v) => v.ownerId;
  static const Field<AdoptionModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
    key: r'owner_id',
  );
  static String _$title(AdoptionModel v) => v.title;
  static const Field<AdoptionModel, String> _f$title = Field('title', _$title);
  static String _$description(AdoptionModel v) => v.description;
  static const Field<AdoptionModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static String _$status(AdoptionModel v) => v.status;
  static const Field<AdoptionModel, String> _f$status = Field(
    'status',
    _$status,
  );
  static DateTime _$createdAt(AdoptionModel v) => v.createdAt;
  static const Field<AdoptionModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
    opt: true,
  );

  @override
  final MappableFields<AdoptionModel> fields = const {
    #id: _f$id,
    #petId: _f$petId,
    #ownerId: _f$ownerId,
    #title: _f$title,
    #description: _f$description,
    #status: _f$status,
    #createdAt: _f$createdAt,
  };

  static AdoptionModel _instantiate(DecodingData data) {
    return AdoptionModel(
      id: data.dec(_f$id),
      petId: data.dec(_f$petId),
      ownerId: data.dec(_f$ownerId),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AdoptionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AdoptionModel>(map);
  }

  static AdoptionModel fromJson(String json) {
    return ensureInitialized().decodeJson<AdoptionModel>(json);
  }
}

mixin AdoptionModelMappable {
  String toJson() {
    return AdoptionModelMapper.ensureInitialized().encodeJson<AdoptionModel>(
      this as AdoptionModel,
    );
  }

  Map<String, dynamic> toMap() {
    return AdoptionModelMapper.ensureInitialized().encodeMap<AdoptionModel>(
      this as AdoptionModel,
    );
  }

  AdoptionModelCopyWith<AdoptionModel, AdoptionModel, AdoptionModel>
  get copyWith => _AdoptionModelCopyWithImpl<AdoptionModel, AdoptionModel>(
    this as AdoptionModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AdoptionModelMapper.ensureInitialized().stringifyValue(
      this as AdoptionModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AdoptionModelMapper.ensureInitialized().equalsValue(
      this as AdoptionModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AdoptionModelMapper.ensureInitialized().hashValue(
      this as AdoptionModel,
    );
  }
}

extension AdoptionModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AdoptionModel, $Out> {
  AdoptionModelCopyWith<$R, AdoptionModel, $Out> get $asAdoptionModel =>
      $base.as((v, t, t2) => _AdoptionModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdoptionModelCopyWith<$R, $In extends AdoptionModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? petId,
    String? ownerId,
    String? title,
    String? description,
    String? status,
    DateTime? createdAt,
  });
  AdoptionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdoptionModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AdoptionModel, $Out>
    implements AdoptionModelCopyWith<$R, AdoptionModel, $Out> {
  _AdoptionModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AdoptionModel> $mapper =
      AdoptionModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? petId,
    String? ownerId,
    String? title,
    String? description,
    String? status,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (petId != null) #petId: petId,
      if (ownerId != null) #ownerId: ownerId,
      if (title != null) #title: title,
      if (description != null) #description: description,
      if (status != null) #status: status,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  AdoptionModel $make(CopyWithData data) => AdoptionModel(
    id: data.get(#id, or: $value.id),
    petId: data.get(#petId, or: $value.petId),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  AdoptionModelCopyWith<$R2, AdoptionModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AdoptionModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

