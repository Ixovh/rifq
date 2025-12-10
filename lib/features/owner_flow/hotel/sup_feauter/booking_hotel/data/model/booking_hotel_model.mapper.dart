// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_hotel_model.dart';

class BookingHotelModelMapper extends ClassMapperBase<BookingHotelModel> {
  BookingHotelModelMapper._();

  static BookingHotelModelMapper? _instance;
  static BookingHotelModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingHotelModelMapper._());
      StatusBookingEnumMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookingHotelModel';

  static String _$id(BookingHotelModel v) => v.id;
  static const Field<BookingHotelModel, String> _f$id = Field('id', _$id);
  static String _$userId(BookingHotelModel v) => v.userId;
  static const Field<BookingHotelModel, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
  );
  static String _$providerId(BookingHotelModel v) => v.providerId;
  static const Field<BookingHotelModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    key: r'provider_id',
  );
  static String _$serviceTypeId(BookingHotelModel v) => v.serviceTypeId;
  static const Field<BookingHotelModel, String> _f$serviceTypeId = Field(
    'serviceTypeId',
    _$serviceTypeId,
    key: r'service_type_id',
  );
  static String _$serviceItemId(BookingHotelModel v) => v.serviceItemId;
  static const Field<BookingHotelModel, String> _f$serviceItemId = Field(
    'serviceItemId',
    _$serviceItemId,
    key: r'service_item_id',
  );
  static String _$petId(BookingHotelModel v) => v.petId;
  static const Field<BookingHotelModel, String> _f$petId = Field(
    'petId',
    _$petId,
    key: r'pet_id',
  );
  static DateTime _$startDate(BookingHotelModel v) => v.startDate;
  static const Field<BookingHotelModel, DateTime> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
  );
  static DateTime _$endDate(BookingHotelModel v) => v.endDate;
  static const Field<BookingHotelModel, DateTime> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
  );
  static StatusBookingEnum _$status(BookingHotelModel v) => v.status;
  static const Field<BookingHotelModel, StatusBookingEnum> _f$status = Field(
    'status',
    _$status,
  );
  static String _$notes(BookingHotelModel v) => v.notes;
  static const Field<BookingHotelModel, String> _f$notes = Field(
    'notes',
    _$notes,
  );
  static DateTime _$createdAt(BookingHotelModel v) => v.createdAt;
  static const Field<BookingHotelModel, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    key: r'created_at',
  );

  @override
  final MappableFields<BookingHotelModel> fields = const {
    #id: _f$id,
    #userId: _f$userId,
    #providerId: _f$providerId,
    #serviceTypeId: _f$serviceTypeId,
    #serviceItemId: _f$serviceItemId,
    #petId: _f$petId,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #status: _f$status,
    #notes: _f$notes,
    #createdAt: _f$createdAt,
  };

  static BookingHotelModel _instantiate(DecodingData data) {
    return BookingHotelModel(
      id: data.dec(_f$id),
      userId: data.dec(_f$userId),
      providerId: data.dec(_f$providerId),
      serviceTypeId: data.dec(_f$serviceTypeId),
      serviceItemId: data.dec(_f$serviceItemId),
      petId: data.dec(_f$petId),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      status: data.dec(_f$status),
      notes: data.dec(_f$notes),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingHotelModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingHotelModel>(map);
  }

  static BookingHotelModel fromJson(String json) {
    return ensureInitialized().decodeJson<BookingHotelModel>(json);
  }
}

mixin BookingHotelModelMappable {
  String toJson() {
    return BookingHotelModelMapper.ensureInitialized()
        .encodeJson<BookingHotelModel>(this as BookingHotelModel);
  }

  Map<String, dynamic> toMap() {
    return BookingHotelModelMapper.ensureInitialized()
        .encodeMap<BookingHotelModel>(this as BookingHotelModel);
  }

  BookingHotelModelCopyWith<
    BookingHotelModel,
    BookingHotelModel,
    BookingHotelModel
  >
  get copyWith =>
      _BookingHotelModelCopyWithImpl<BookingHotelModel, BookingHotelModel>(
        this as BookingHotelModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookingHotelModelMapper.ensureInitialized().stringifyValue(
      this as BookingHotelModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingHotelModelMapper.ensureInitialized().equalsValue(
      this as BookingHotelModel,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingHotelModelMapper.ensureInitialized().hashValue(
      this as BookingHotelModel,
    );
  }
}

extension BookingHotelModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingHotelModel, $Out> {
  BookingHotelModelCopyWith<$R, BookingHotelModel, $Out>
  get $asBookingHotelModel => $base.as(
    (v, t, t2) => _BookingHotelModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BookingHotelModelCopyWith<
  $R,
  $In extends BookingHotelModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? userId,
    String? providerId,
    String? serviceTypeId,
    String? serviceItemId,
    String? petId,
    DateTime? startDate,
    DateTime? endDate,
    StatusBookingEnum? status,
    String? notes,
    DateTime? createdAt,
  });
  BookingHotelModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BookingHotelModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingHotelModel, $Out>
    implements BookingHotelModelCopyWith<$R, BookingHotelModel, $Out> {
  _BookingHotelModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingHotelModel> $mapper =
      BookingHotelModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? userId,
    String? providerId,
    String? serviceTypeId,
    String? serviceItemId,
    String? petId,
    DateTime? startDate,
    DateTime? endDate,
    StatusBookingEnum? status,
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
      if (startDate != null) #startDate: startDate,
      if (endDate != null) #endDate: endDate,
      if (status != null) #status: status,
      if (notes != null) #notes: notes,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  BookingHotelModel $make(CopyWithData data) => BookingHotelModel(
    id: data.get(#id, or: $value.id),
    userId: data.get(#userId, or: $value.userId),
    providerId: data.get(#providerId, or: $value.providerId),
    serviceTypeId: data.get(#serviceTypeId, or: $value.serviceTypeId),
    serviceItemId: data.get(#serviceItemId, or: $value.serviceItemId),
    petId: data.get(#petId, or: $value.petId),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    status: data.get(#status, or: $value.status),
    notes: data.get(#notes, or: $value.notes),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  BookingHotelModelCopyWith<$R2, BookingHotelModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookingHotelModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

