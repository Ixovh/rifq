// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_profile_model.dart';

class UserProfileModelMapper extends ClassMapperBase<UserProfileModel> {
  UserProfileModelMapper._();

  static UserProfileModelMapper? _instance;
  static UserProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserProfileModel';

  static String _$id(UserProfileModel v) => v.id;
  static const Field<UserProfileModel, String> _f$id = Field('id', _$id);
  static String _$authId(UserProfileModel v) => v.authId;
  static const Field<UserProfileModel, String> _f$authId = Field(
    'authId',
    _$authId,
    key: r'auth_id',
  );
  static String _$name(UserProfileModel v) => v.name;
  static const Field<UserProfileModel, String> _f$name = Field('name', _$name);
  static String _$email(UserProfileModel v) => v.email;
  static const Field<UserProfileModel, String> _f$email = Field(
    'email',
    _$email,
  );
  static DateTime _$createdAt(UserProfileModel v) => v.createdAt;
  static const Field<UserProfileModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<UserProfileModel> fields = const {
    #id: _f$id,
    #authId: _f$authId,
    #name: _f$name,
    #email: _f$email,
    #createdAt: _f$createdAt,
  };

  static UserProfileModel _instantiate(DecodingData data) {
    return UserProfileModel(
      id: data.dec(_f$id),
      authId: data.dec(_f$authId),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UserProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserProfileModel>(map);
  }

  static UserProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<UserProfileModel>(json);
  }
}

mixin UserProfileModelMappable {
  String toJson() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeJson<UserProfileModel>(this as UserProfileModel);
  }

  Map<String, dynamic> toMap() {
    return UserProfileModelMapper.ensureInitialized()
        .encodeMap<UserProfileModel>(this as UserProfileModel);
  }

  UserProfileModelCopyWith<UserProfileModel, UserProfileModel, UserProfileModel>
  get copyWith =>
      _UserProfileModelCopyWithImpl<UserProfileModel, UserProfileModel>(
        this as UserProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return UserProfileModelMapper.ensureInitialized().stringifyValue(
      this as UserProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return UserProfileModelMapper.ensureInitialized().equalsValue(
      this as UserProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return UserProfileModelMapper.ensureInitialized().hashValue(
      this as UserProfileModel,
    );
  }
}

extension UserProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserProfileModel, $Out> {
  UserProfileModelCopyWith<$R, UserProfileModel, $Out>
  get $asUserProfileModel =>
      $base.as((v, t, t2) => _UserProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class UserProfileModelCopyWith<$R, $In extends UserProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? authId,
    String? name,
    String? email,
    DateTime? createdAt,
  });
  UserProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UserProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserProfileModel, $Out>
    implements UserProfileModelCopyWith<$R, UserProfileModel, $Out> {
  _UserProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserProfileModel> $mapper =
      UserProfileModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? authId,
    String? name,
    String? email,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (authId != null) #authId: authId,
      if (name != null) #name: name,
      if (email != null) #email: email,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  UserProfileModel $make(CopyWithData data) => UserProfileModel(
    id: data.get(#id, or: $value.id),
    authId: data.get(#authId, or: $value.authId),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  UserProfileModelCopyWith<$R2, UserProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

