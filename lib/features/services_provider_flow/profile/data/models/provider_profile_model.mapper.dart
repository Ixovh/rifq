// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'provider_profile_model.dart';

class ProviderProfileModelMapper extends ClassMapperBase<ProviderProfileModel> {
  ProviderProfileModelMapper._();

  static ProviderProfileModelMapper? _instance;
  static ProviderProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProviderProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProviderProfileModel';

  static String _$id(ProviderProfileModel v) => v.id;
  static const Field<ProviderProfileModel, String> _f$id = Field('id', _$id);
  static String _$authId(ProviderProfileModel v) => v.authId;
  static const Field<ProviderProfileModel, String> _f$authId = Field(
    'authId',
    _$authId,
    key: r'auth_id',
  );
  static String _$name(ProviderProfileModel v) => v.name;
  static const Field<ProviderProfileModel, String> _f$name = Field(
    'name',
    _$name,
  );
  static String _$email(ProviderProfileModel v) => v.email;
  static const Field<ProviderProfileModel, String> _f$email = Field(
    'email',
    _$email,
  );
  static String _$phone(ProviderProfileModel v) => v.phone;
  static const Field<ProviderProfileModel, String> _f$phone = Field(
    'phone',
    _$phone,
  );
  static String _$location(ProviderProfileModel v) => v.location;
  static const Field<ProviderProfileModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static String _$commercialRegister(ProviderProfileModel v) =>
      v.commercialRegister;
  static const Field<ProviderProfileModel, String> _f$commercialRegister =
      Field(
        'commercialRegister',
        _$commercialRegister,
        key: r'commercial_register',
      );
  static String _$locationUrl(ProviderProfileModel v) => v.locationUrl;
  static const Field<ProviderProfileModel, String> _f$locationUrl = Field(
    'locationUrl',
    _$locationUrl,
    key: r'location_url',
  );
  static String? _$image(ProviderProfileModel v) => v.image;
  static const Field<ProviderProfileModel, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static DateTime _$createdAt(ProviderProfileModel v) => v.createdAt;
  static const Field<ProviderProfileModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<ProviderProfileModel> fields = const {
    #id: _f$id,
    #authId: _f$authId,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #location: _f$location,
    #commercialRegister: _f$commercialRegister,
    #locationUrl: _f$locationUrl,
    #image: _f$image,
    #createdAt: _f$createdAt,
  };

  static ProviderProfileModel _instantiate(DecodingData data) {
    return ProviderProfileModel(
      id: data.dec(_f$id),
      authId: data.dec(_f$authId),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      location: data.dec(_f$location),
      commercialRegister: data.dec(_f$commercialRegister),
      locationUrl: data.dec(_f$locationUrl),
      image: data.dec(_f$image),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProviderProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProviderProfileModel>(map);
  }

  static ProviderProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProviderProfileModel>(json);
  }
}

mixin ProviderProfileModelMappable {
  String toJson() {
    return ProviderProfileModelMapper.ensureInitialized()
        .encodeJson<ProviderProfileModel>(this as ProviderProfileModel);
  }

  Map<String, dynamic> toMap() {
    return ProviderProfileModelMapper.ensureInitialized()
        .encodeMap<ProviderProfileModel>(this as ProviderProfileModel);
  }

  ProviderProfileModelCopyWith<
    ProviderProfileModel,
    ProviderProfileModel,
    ProviderProfileModel
  >
  get copyWith =>
      _ProviderProfileModelCopyWithImpl<
        ProviderProfileModel,
        ProviderProfileModel
      >(this as ProviderProfileModel, $identity, $identity);
  @override
  String toString() {
    return ProviderProfileModelMapper.ensureInitialized().stringifyValue(
      this as ProviderProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProviderProfileModelMapper.ensureInitialized().equalsValue(
      this as ProviderProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProviderProfileModelMapper.ensureInitialized().hashValue(
      this as ProviderProfileModel,
    );
  }
}

extension ProviderProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProviderProfileModel, $Out> {
  ProviderProfileModelCopyWith<$R, ProviderProfileModel, $Out>
  get $asProviderProfileModel => $base.as(
    (v, t, t2) => _ProviderProfileModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProviderProfileModelCopyWith<
  $R,
  $In extends ProviderProfileModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? authId,
    String? name,
    String? email,
    String? phone,
    String? location,
    String? commercialRegister,
    String? locationUrl,
    String? image,
    DateTime? createdAt,
  });
  ProviderProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProviderProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProviderProfileModel, $Out>
    implements ProviderProfileModelCopyWith<$R, ProviderProfileModel, $Out> {
  _ProviderProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProviderProfileModel> $mapper =
      ProviderProfileModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? authId,
    String? name,
    String? email,
    String? phone,
    String? location,
    String? commercialRegister,
    String? locationUrl,
    Object? image = $none,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (authId != null) #authId: authId,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (location != null) #location: location,
      if (commercialRegister != null) #commercialRegister: commercialRegister,
      if (locationUrl != null) #locationUrl: locationUrl,
      if (image != $none) #image: image,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  ProviderProfileModel $make(CopyWithData data) => ProviderProfileModel(
    id: data.get(#id, or: $value.id),
    authId: data.get(#authId, or: $value.authId),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    location: data.get(#location, or: $value.location),
    commercialRegister: data.get(
      #commercialRegister,
      or: $value.commercialRegister,
    ),
    locationUrl: data.get(#locationUrl, or: $value.locationUrl),
    image: data.get(#image, or: $value.image),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ProviderProfileModelCopyWith<$R2, ProviderProfileModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProviderProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

