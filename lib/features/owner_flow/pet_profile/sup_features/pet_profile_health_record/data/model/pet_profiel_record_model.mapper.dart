// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'pet_profiel_record_model.dart';

class PetProfileRecordModelMapper
    extends ClassMapperBase<PetProfileRecordModel> {
  PetProfileRecordModelMapper._();

  static PetProfileRecordModelMapper? _instance;
  static PetProfileRecordModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PetProfileRecordModelMapper._());
      HealthRecordModelMapper.ensureInitialized();
      ReservationModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PetProfileRecordModel';

  static String _$petId(PetProfileRecordModel v) => v.petId;
  static const Field<PetProfileRecordModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static String _$ownerId(PetProfileRecordModel v) => v.ownerId;
  static const Field<PetProfileRecordModel, String> _f$ownerId = Field(
    'ownerId',
    _$ownerId,
    key: r'owner_id',
  );
  static String _$ownerName(PetProfileRecordModel v) => v.ownerName;
  static const Field<PetProfileRecordModel, String> _f$ownerName = Field(
    'ownerName',
    _$ownerName,
    key: r'owner_name',
  );
  static String _$petName(PetProfileRecordModel v) => v.petName;
  static const Field<PetProfileRecordModel, String> _f$petName = Field(
    'petName',
    _$petName,
    key: r'pet_name',
  );
  static String _$petSpecies(PetProfileRecordModel v) => v.petSpecies;
  static const Field<PetProfileRecordModel, String> _f$petSpecies = Field(
    'petSpecies',
    _$petSpecies,
    key: r'pet_species',
  );
  static String _$petBreed(PetProfileRecordModel v) => v.petBreed;
  static const Field<PetProfileRecordModel, String> _f$petBreed = Field(
    'petBreed',
    _$petBreed,
    key: r'pet_breed',
  );
  static DateTime _$petBirthdate(PetProfileRecordModel v) => v.petBirthdate;
  static const Field<PetProfileRecordModel, DateTime> _f$petBirthdate = Field(
    'petBirthdate',
    _$petBirthdate,
    key: r'pet_birthdate',
  );
  static String _$petPhoto(PetProfileRecordModel v) => v.petPhoto;
  static const Field<PetProfileRecordModel, String> _f$petPhoto = Field(
    'petPhoto',
    _$petPhoto,
    key: r'pet_photo',
  );
  static String _$petGender(PetProfileRecordModel v) => v.petGender;
  static const Field<PetProfileRecordModel, String> _f$petGender = Field(
    'petGender',
    _$petGender,
    key: r'pet_gender',
  );
  static List<HealthRecordModel> _$healthRecords(PetProfileRecordModel v) =>
      v.healthRecords;
  static const Field<PetProfileRecordModel, List<HealthRecordModel>>
  _f$healthRecords = Field(
    'healthRecords',
    _$healthRecords,
    key: r'health_records',
  );
  static List<ReservationModel> _$reservations(PetProfileRecordModel v) =>
      v.reservations;
  static const Field<PetProfileRecordModel, List<ReservationModel>>
  _f$reservations = Field('reservations', _$reservations);

  @override
  final MappableFields<PetProfileRecordModel> fields = const {
    #petId: _f$petId,
    #ownerId: _f$ownerId,
    #ownerName: _f$ownerName,
    #petName: _f$petName,
    #petSpecies: _f$petSpecies,
    #petBreed: _f$petBreed,
    #petBirthdate: _f$petBirthdate,
    #petPhoto: _f$petPhoto,
    #petGender: _f$petGender,
    #healthRecords: _f$healthRecords,
    #reservations: _f$reservations,
  };

  static PetProfileRecordModel _instantiate(DecodingData data) {
    return PetProfileRecordModel(
      petId: data.dec(_f$petId),
      ownerId: data.dec(_f$ownerId),
      ownerName: data.dec(_f$ownerName),
      petName: data.dec(_f$petName),
      petSpecies: data.dec(_f$petSpecies),
      petBreed: data.dec(_f$petBreed),
      petBirthdate: data.dec(_f$petBirthdate),
      petPhoto: data.dec(_f$petPhoto),
      petGender: data.dec(_f$petGender),
      healthRecords: data.dec(_f$healthRecords),
      reservations: data.dec(_f$reservations),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PetProfileRecordModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PetProfileRecordModel>(map);
  }

  static PetProfileRecordModel fromJson(String json) {
    return ensureInitialized().decodeJson<PetProfileRecordModel>(json);
  }
}

mixin PetProfileRecordModelMappable {
  String toJson() {
    return PetProfileRecordModelMapper.ensureInitialized()
        .encodeJson<PetProfileRecordModel>(this as PetProfileRecordModel);
  }

  Map<String, dynamic> toMap() {
    return PetProfileRecordModelMapper.ensureInitialized()
        .encodeMap<PetProfileRecordModel>(this as PetProfileRecordModel);
  }

  PetProfileRecordModelCopyWith<
    PetProfileRecordModel,
    PetProfileRecordModel,
    PetProfileRecordModel
  >
  get copyWith =>
      _PetProfileRecordModelCopyWithImpl<
        PetProfileRecordModel,
        PetProfileRecordModel
      >(this as PetProfileRecordModel, $identity, $identity);
  @override
  String toString() {
    return PetProfileRecordModelMapper.ensureInitialized().stringifyValue(
      this as PetProfileRecordModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return PetProfileRecordModelMapper.ensureInitialized().equalsValue(
      this as PetProfileRecordModel,
      other,
    );
  }

  @override
  int get hashCode {
    return PetProfileRecordModelMapper.ensureInitialized().hashValue(
      this as PetProfileRecordModel,
    );
  }
}

extension PetProfileRecordModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PetProfileRecordModel, $Out> {
  PetProfileRecordModelCopyWith<$R, PetProfileRecordModel, $Out>
  get $asPetProfileRecordModel => $base.as(
    (v, t, t2) => _PetProfileRecordModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PetProfileRecordModelCopyWith<
  $R,
  $In extends PetProfileRecordModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    HealthRecordModel,
    HealthRecordModelCopyWith<$R, HealthRecordModel, HealthRecordModel>
  >
  get healthRecords;
  ListCopyWith<
    $R,
    ReservationModel,
    ReservationModelCopyWith<$R, ReservationModel, ReservationModel>
  >
  get reservations;
  $R call({
    String? petId,
    String? ownerId,
    String? ownerName,
    String? petName,
    String? petSpecies,
    String? petBreed,
    DateTime? petBirthdate,
    String? petPhoto,
    String? petGender,
    List<HealthRecordModel>? healthRecords,
    List<ReservationModel>? reservations,
  });
  PetProfileRecordModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PetProfileRecordModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PetProfileRecordModel, $Out>
    implements PetProfileRecordModelCopyWith<$R, PetProfileRecordModel, $Out> {
  _PetProfileRecordModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PetProfileRecordModel> $mapper =
      PetProfileRecordModelMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    HealthRecordModel,
    HealthRecordModelCopyWith<$R, HealthRecordModel, HealthRecordModel>
  >
  get healthRecords => ListCopyWith(
    $value.healthRecords,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(healthRecords: v),
  );
  @override
  ListCopyWith<
    $R,
    ReservationModel,
    ReservationModelCopyWith<$R, ReservationModel, ReservationModel>
  >
  get reservations => ListCopyWith(
    $value.reservations,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(reservations: v),
  );
  @override
  $R call({
    String? petId,
    String? ownerId,
    String? ownerName,
    String? petName,
    String? petSpecies,
    String? petBreed,
    DateTime? petBirthdate,
    String? petPhoto,
    String? petGender,
    List<HealthRecordModel>? healthRecords,
    List<ReservationModel>? reservations,
  }) => $apply(
    FieldCopyWithData({
      if (petId != null) #petId: petId,
      if (ownerId != null) #ownerId: ownerId,
      if (ownerName != null) #ownerName: ownerName,
      if (petName != null) #petName: petName,
      if (petSpecies != null) #petSpecies: petSpecies,
      if (petBreed != null) #petBreed: petBreed,
      if (petBirthdate != null) #petBirthdate: petBirthdate,
      if (petPhoto != null) #petPhoto: petPhoto,
      if (petGender != null) #petGender: petGender,
      if (healthRecords != null) #healthRecords: healthRecords,
      if (reservations != null) #reservations: reservations,
    }),
  );
  @override
  PetProfileRecordModel $make(CopyWithData data) => PetProfileRecordModel(
    petId: data.get(#petId, or: $value.petId),
    ownerId: data.get(#ownerId, or: $value.ownerId),
    ownerName: data.get(#ownerName, or: $value.ownerName),
    petName: data.get(#petName, or: $value.petName),
    petSpecies: data.get(#petSpecies, or: $value.petSpecies),
    petBreed: data.get(#petBreed, or: $value.petBreed),
    petBirthdate: data.get(#petBirthdate, or: $value.petBirthdate),
    petPhoto: data.get(#petPhoto, or: $value.petPhoto),
    petGender: data.get(#petGender, or: $value.petGender),
    healthRecords: data.get(#healthRecords, or: $value.healthRecords),
    reservations: data.get(#reservations, or: $value.reservations),
  );

  @override
  PetProfileRecordModelCopyWith<$R2, PetProfileRecordModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PetProfileRecordModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

