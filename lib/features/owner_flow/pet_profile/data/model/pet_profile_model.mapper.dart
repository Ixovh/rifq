// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_profile_model.dart';

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
  static String _$name(UserProfileModel v) => v.name;
  static const Field<UserProfileModel, String> _f$name = Field('name', _$name);
  static String _$breed(UserProfileModel v) => v.breed;
  static const Field<UserProfileModel, String> _f$breed = Field(
    'breed',
    _$breed,
  );
  static String _$species(UserProfileModel v) => v.species;
  static const Field<UserProfileModel, String> _f$species = Field(
    'species',
    _$species,
  );
  static DateTime _$birthdate(UserProfileModel v) => v.birthdate;
  static const Field<UserProfileModel, DateTime> _f$birthdate = Field(
    'birthdate',
    _$birthdate,
  );
  static String _$photoUrl(UserProfileModel v) => v.photoUrl;
  static const Field<UserProfileModel, String> _f$photoUrl = Field(
    'photoUrl',
    _$photoUrl,
  );
  static String _$ownerId(UserProfileModel v) => v.ownerId;
  static const Field<UserProfileModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
  );
  static String _$gender(UserProfileModel v) => v.gender;
  static const Field<UserProfileModel, String> _f$gender = Field(
    'gender',
    _$gender,
  );
  static DateTime _$createdAt(UserProfileModel v) => v.createdAt;
  static const Field<UserProfileModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<UserProfileModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breed: _f$breed,
    #species: _f$species,
    #birthdate: _f$birthdate,
    #photoUrl: _f$photoUrl,
    #ownerId: _f$ownerId,
    #gender: _f$gender,
    #createdAt: _f$createdAt,
  };

  static UserProfileModel _instantiate(DecodingData data) {
    return UserProfileModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breed: data.dec(_f$breed),
      species: data.dec(_f$species),
      birthdate: data.dec(_f$birthdate),
      photoUrl: data.dec(_f$photoUrl),
      ownerId: data.dec(_f$ownerId),
      gender: data.dec(_f$gender),
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
    String? name,
    String? breed,
    String? species,
    DateTime? birthdate,
    String? photoUrl,
    String? ownerId,
    String? gender,
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
    String? name,
    String? breed,
    String? species,
    DateTime? birthdate,
    String? photoUrl,
    String? ownerId,
    String? gender,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (breed != null) #breed: breed,
      if (species != null) #species: species,
      if (birthdate != null) #birthdate: birthdate,
      if (photoUrl != null) #photoUrl: photoUrl,
      if (ownerId != null) #ownerId: ownerId,
      if (gender != null) #gender: gender,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  UserProfileModel $make(CopyWithData data) => UserProfileModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breed: data.get(#breed, or: $value.breed),
    species: data.get(#species, or: $value.species),
    birthdate: data.get(#birthdate, or: $value.birthdate),
    photoUrl: data.get(#photoUrl, or: $value.photoUrl),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    gender: data.get(#gender, or: $value.gender),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  UserProfileModelCopyWith<$R2, UserProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _UserProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

