// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'provider_model.dart';

class ProviderModelMapper extends ClassMapperBase<ProviderModel> {
  ProviderModelMapper._();

  static ProviderModelMapper? _instance;
  static ProviderModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProviderModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProviderModel';

  static String _$id(ProviderModel v) => v.id;
  static const Field<ProviderModel, String> _f$id = Field('id', _$id);
  static String _$name(ProviderModel v) => v.name;
  static const Field<ProviderModel, String> _f$name = Field('name', _$name);
  static String? _$image(ProviderModel v) => v.image;
  static const Field<ProviderModel, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static String _$location(ProviderModel v) => v.location;
  static const Field<ProviderModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static String? _$locationUrl(ProviderModel v) => v.locationUrl;
  static const Field<ProviderModel, String> _f$locationUrl = Field(
    'locationUrl',
    _$locationUrl,
    key: r'location_url',
    opt: true,
  );
  static String? _$phone(ProviderModel v) => v.phone;
  static const Field<ProviderModel, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );

  @override
  final MappableFields<ProviderModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #location: _f$location,
    #locationUrl: _f$locationUrl,
    #phone: _f$phone,
  };

  static ProviderModel _instantiate(DecodingData data) {
    return ProviderModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      location: data.dec(_f$location),
      locationUrl: data.dec(_f$locationUrl),
      phone: data.dec(_f$phone),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProviderModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProviderModel>(map);
  }

  static ProviderModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProviderModel>(json);
  }
}

mixin ProviderModelMappable {
  String toJson() {
    return ProviderModelMapper.ensureInitialized().encodeJson<ProviderModel>(
      this as ProviderModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ProviderModelMapper.ensureInitialized().encodeMap<ProviderModel>(
      this as ProviderModel,
    );
  }

  ProviderModelCopyWith<ProviderModel, ProviderModel, ProviderModel>
  get copyWith => _ProviderModelCopyWithImpl<ProviderModel, ProviderModel>(
    this as ProviderModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ProviderModelMapper.ensureInitialized().stringifyValue(
      this as ProviderModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProviderModelMapper.ensureInitialized().equalsValue(
      this as ProviderModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProviderModelMapper.ensureInitialized().hashValue(
      this as ProviderModel,
    );
  }
}

extension ProviderModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProviderModel, $Out> {
  ProviderModelCopyWith<$R, ProviderModel, $Out> get $asProviderModel =>
      $base.as((v, t, t2) => _ProviderModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProviderModelCopyWith<$R, $In extends ProviderModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? image,
    String? location,
    String? locationUrl,
    String? phone,
  });
  ProviderModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProviderModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProviderModel, $Out>
    implements ProviderModelCopyWith<$R, ProviderModel, $Out> {
  _ProviderModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProviderModel> $mapper =
      ProviderModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    Object? image = $none,
    String? location,
    Object? locationUrl = $none,
    Object? phone = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (image != $none) #image: image,
      if (location != null) #location: location,
      if (locationUrl != $none) #locationUrl: locationUrl,
      if (phone != $none) #phone: phone,
    }),
  );
  @override
  ProviderModel $make(CopyWithData data) => ProviderModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    location: data.get(#location, or: $value.location),
    locationUrl: data.get(#locationUrl, or: $value.locationUrl),
    phone: data.get(#phone, or: $value.phone),
  );

  @override
  ProviderModelCopyWith<$R2, ProviderModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProviderModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

