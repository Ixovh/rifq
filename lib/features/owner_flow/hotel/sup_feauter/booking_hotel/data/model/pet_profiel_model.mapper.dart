// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_profiel_model.dart';

class PetProfileModelMapper extends ClassMapperBase<PetProfileModel> {
  PetProfileModelMapper._();

  static PetProfileModelMapper? _instance;
  static PetProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetProfileModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PetProfileModel';

  static String _$id(PetProfileModel v) => v.id;
  static const Field<PetProfileModel, String> _f$id = Field('id', _$id);
  static String _$name(PetProfileModel v) => v.name;
  static const Field<PetProfileModel, String> _f$name = Field('name', _$name);
  static String _$breed(PetProfileModel v) => v.breed;
  static const Field<PetProfileModel, String> _f$breed = Field(
    'breed',
    _$breed,
  );
  static String _$species(PetProfileModel v) => v.species;
  static const Field<PetProfileModel, String> _f$species = Field(
    'species',
    _$species,
  );
  static DateTime _$birthdate(PetProfileModel v) => v.birthdate;
  static const Field<PetProfileModel, DateTime> _f$birthdate = Field(
    'birthdate',
    _$birthdate,
  );
  static String _$photoUrl(PetProfileModel v) => v.photoUrl;
  static const Field<PetProfileModel, String> _f$photoUrl = Field(
    'photoUrl',
    _$photoUrl,
  );
  static String _$ownerId(PetProfileModel v) => v.ownerId;
  static const Field<PetProfileModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
  );
  static String _$gender(PetProfileModel v) => v.gender;
  static const Field<PetProfileModel, String> _f$gender = Field(
    'gender',
    _$gender,
  );
  static DateTime _$createdAt(PetProfileModel v) => v.createdAt;
  static const Field<PetProfileModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );
  static String? _$ownerAuthId(PetProfileModel v) => v.ownerAuthId;
  static const Field<PetProfileModel, String> _f$ownerAuthId = Field(
    'ownerAuthId',
    _$ownerAuthId,
    opt: true,
  );
  static String? _$ownerName(PetProfileModel v) => v.ownerName;
  static const Field<PetProfileModel, String> _f$ownerName = Field(
    'ownerName',
    _$ownerName,
    opt: true,
  );
  static String? _$ownerEmail(PetProfileModel v) => v.ownerEmail;
  static const Field<PetProfileModel, String> _f$ownerEmail = Field(
    'ownerEmail',
    _$ownerEmail,
    opt: true,
  );

  @override
  final MappableFields<PetProfileModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #breed: _f$breed,
    #species: _f$species,
    #birthdate: _f$birthdate,
    #photoUrl: _f$photoUrl,
    #ownerId: _f$ownerId,
    #gender: _f$gender,
    #createdAt: _f$createdAt,
    #ownerAuthId: _f$ownerAuthId,
    #ownerName: _f$ownerName,
    #ownerEmail: _f$ownerEmail,
  };

  static PetProfileModel _instantiate(DecodingData data) {
    return PetProfileModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      breed: data.dec(_f$breed),
      species: data.dec(_f$species),
      birthdate: data.dec(_f$birthdate),
      photoUrl: data.dec(_f$photoUrl),
      ownerId: data.dec(_f$ownerId),
      gender: data.dec(_f$gender),
      createdAt: data.dec(_f$createdAt),
      ownerAuthId: data.dec(_f$ownerAuthId),
      ownerName: data.dec(_f$ownerName),
      ownerEmail: data.dec(_f$ownerEmail),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetProfileModel>(map);
  }

  static PetProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetProfileModel>(json);
  }
}

mixin PetProfileModelMappable {
  String toJson() {
    return PetProfileModelMapper.ensureInitialized()
        .encodeJson<PetProfileModel>(this as PetProfileModel);
  }

  Map<String, dynamic> toMap() {
    return PetProfileModelMapper.ensureInitialized().encodeMap<PetProfileModel>(
      this as PetProfileModel,
    );
  }

  PetProfileModelCopyWith<PetProfileModel, PetProfileModel, PetProfileModel>
  get copyWith =>
      _PetProfileModelCopyWithImpl<PetProfileModel, PetProfileModel>(
        this as PetProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PetProfileModelMapper.ensureInitialized().stringifyValue(
      this as PetProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetProfileModelMapper.ensureInitialized().equalsValue(
      this as PetProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetProfileModelMapper.ensureInitialized().hashValue(
      this as PetProfileModel,
    );
  }
}

extension PetProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetProfileModel, $Out> {
  PetProfileModelCopyWith<$R, PetProfileModel, $Out> get $asPetProfileModel =>
      $base.as((v, t, t2) => _PetProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PetProfileModelCopyWith<$R, $In extends PetProfileModel, $Out>
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
    String? ownerAuthId,
    String? ownerName,
    String? ownerEmail,
  });
  PetProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PetProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetProfileModel, $Out>
    implements PetProfileModelCopyWith<$R, PetProfileModel, $Out> {
  _PetProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetProfileModel> $mapper =
      PetProfileModelMapper.ensureInitialized();
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
    Object? ownerAuthId = $none,
    Object? ownerName = $none,
    Object? ownerEmail = $none,
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
      if (ownerAuthId != $none) #ownerAuthId: ownerAuthId,
      if (ownerName != $none) #ownerName: ownerName,
      if (ownerEmail != $none) #ownerEmail: ownerEmail,
    }),
  );
  @override
  PetProfileModel $make(CopyWithData data) => PetProfileModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    breed: data.get(#breed, or: $value.breed),
    species: data.get(#species, or: $value.species),
    birthdate: data.get(#birthdate, or: $value.birthdate),
    photoUrl: data.get(#photoUrl, or: $value.photoUrl),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    gender: data.get(#gender, or: $value.gender),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    ownerAuthId: data.get(#ownerAuthId, or: $value.ownerAuthId),
    ownerName: data.get(#ownerName, or: $value.ownerName),
    ownerEmail: data.get(#ownerEmail, or: $value.ownerEmail),
  );

  @override
  PetProfileModelCopyWith<$R2, PetProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PetProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

