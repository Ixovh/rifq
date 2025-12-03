// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'hotel_model.dart';

class HotelModelMapper extends ClassMapperBase<HotelModel> {
  HotelModelMapper._();

  static HotelModelMapper? _instance;
  static HotelModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HotelModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HotelModel';

  static String _$itemId(HotelModel v) => v.itemId;
  static const Field<HotelModel, String> _f$itemId = Field(
    'itemId',
    _$itemId,
    key: r'item_id',
  );
  static String _$itemName(HotelModel v) => v.itemName;
  static const Field<HotelModel, String> _f$itemName = Field(
    'itemName',
    _$itemName,
    key: r'item_name',
  );
  static String _$itemDescription(HotelModel v) => v.itemDescription;
  static const Field<HotelModel, String> _f$itemDescription = Field(
    'itemDescription',
    _$itemDescription,
    key: r'item_description',
  );
  static double _$price(HotelModel v) => v.price;
  static const Field<HotelModel, double> _f$price = Field('price', _$price);
  static String _$image(HotelModel v) => v.image;
  static const Field<HotelModel, String> _f$image = Field('image', _$image);
  static DateTime _$itemCreatedAt(HotelModel v) => v.itemCreatedAt;
  static const Field<HotelModel, DateTime> _f$itemCreatedAt = Field(
    'itemCreatedAt',
    _$itemCreatedAt,
    key: r'item_created_at',
  );
  static String _$providerId(HotelModel v) => v.providerId;
  static const Field<HotelModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    key: r'provider_id',
  );
  static String _$authId(HotelModel v) => v.authId;
  static const Field<HotelModel, String> _f$authId = Field(
    'authId',
    _$authId,
    key: r'auth_id',
  );
  static String _$providerName(HotelModel v) => v.providerName;
  static const Field<HotelModel, String> _f$providerName = Field(
    'providerName',
    _$providerName,
    key: r'provider_name',
  );
  static String _$email(HotelModel v) => v.email;
  static const Field<HotelModel, String> _f$email = Field('email', _$email);
  static String _$phone(HotelModel v) => v.phone;
  static const Field<HotelModel, String> _f$phone = Field('phone', _$phone);
  static String _$location(HotelModel v) => v.location;
  static const Field<HotelModel, String> _f$location = Field(
    'location',
    _$location,
  );
  static String _$commercialRegister(HotelModel v) => v.commercialRegister;
  static const Field<HotelModel, String> _f$commercialRegister = Field(
    'commercialRegister',
    _$commercialRegister,
    key: r'commercial_register',
  );
  static DateTime _$providerCreatedAt(HotelModel v) => v.providerCreatedAt;
  static const Field<HotelModel, DateTime> _f$providerCreatedAt = Field(
    'providerCreatedAt',
    _$providerCreatedAt,
    key: r'provider_created_at',
  );
  static String _$serviceTypeId(HotelModel v) => v.serviceTypeId;
  static const Field<HotelModel, String> _f$serviceTypeId = Field(
    'serviceTypeId',
    _$serviceTypeId,
    key: r'service_type_id',
  );
  static String? _$locationUrl(HotelModel v) => v.locationUrl;
  static const Field<HotelModel, String> _f$locationUrl = Field(
    'locationUrl',
    _$locationUrl,
    key: r'location_url',
    opt: true,
  );

  @override
  final MappableFields<HotelModel> fields = const {
    #itemId: _f$itemId,
    #itemName: _f$itemName,
    #itemDescription: _f$itemDescription,
    #price: _f$price,
    #image: _f$image,
    #itemCreatedAt: _f$itemCreatedAt,
    #providerId: _f$providerId,
    #authId: _f$authId,
    #providerName: _f$providerName,
    #email: _f$email,
    #phone: _f$phone,
    #location: _f$location,
    #commercialRegister: _f$commercialRegister,
    #providerCreatedAt: _f$providerCreatedAt,
    #serviceTypeId: _f$serviceTypeId,
    #locationUrl: _f$locationUrl,
  };

  static HotelModel _instantiate(DecodingData data) {
    return HotelModel(
      itemId: data.dec(_f$itemId),
      itemName: data.dec(_f$itemName),
      itemDescription: data.dec(_f$itemDescription),
      price: data.dec(_f$price),
      image: data.dec(_f$image),
      itemCreatedAt: data.dec(_f$itemCreatedAt),
      providerId: data.dec(_f$providerId),
      authId: data.dec(_f$authId),
      providerName: data.dec(_f$providerName),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      location: data.dec(_f$location),
      commercialRegister: data.dec(_f$commercialRegister),
      providerCreatedAt: data.dec(_f$providerCreatedAt),
      serviceTypeId: data.dec(_f$serviceTypeId),
      locationUrl: data.dec(_f$locationUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HotelModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HotelModel>(map);
  }

  static HotelModel fromJson(String json) {
    return ensureInitialized().decodeJson<HotelModel>(json);
  }
}

mixin HotelModelMappable {
  String toJson() {
    return HotelModelMapper.ensureInitialized().encodeJson<HotelModel>(
      this as HotelModel,
    );
  }

  Map<String, dynamic> toMap() {
    return HotelModelMapper.ensureInitialized().encodeMap<HotelModel>(
      this as HotelModel,
    );
  }

  HotelModelCopyWith<HotelModel, HotelModel, HotelModel> get copyWith =>
      _HotelModelCopyWithImpl<HotelModel, HotelModel>(
        this as HotelModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HotelModelMapper.ensureInitialized().stringifyValue(
      this as HotelModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return HotelModelMapper.ensureInitialized().equalsValue(
      this as HotelModel,
      other,
    );
  }

  @override
  int get hashCode {
    return HotelModelMapper.ensureInitialized().hashValue(this as HotelModel);
  }
}

extension HotelModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HotelModel, $Out> {
  HotelModelCopyWith<$R, HotelModel, $Out> get $asHotelModel =>
      $base.as((v, t, t2) => _HotelModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HotelModelCopyWith<$R, $In extends HotelModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? itemId,
    String? itemName,
    String? itemDescription,
    double? price,
    String? image,
    DateTime? itemCreatedAt,
    String? providerId,
    String? authId,
    String? providerName,
    String? email,
    String? phone,
    String? location,
    String? commercialRegister,
    DateTime? providerCreatedAt,
    String? serviceTypeId,
    String? locationUrl,
  });
  HotelModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HotelModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HotelModel, $Out>
    implements HotelModelCopyWith<$R, HotelModel, $Out> {
  _HotelModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HotelModel> $mapper =
      HotelModelMapper.ensureInitialized();
  @override
  $R call({
    String? itemId,
    String? itemName,
    String? itemDescription,
    double? price,
    String? image,
    DateTime? itemCreatedAt,
    String? providerId,
    String? authId,
    String? providerName,
    String? email,
    String? phone,
    String? location,
    String? commercialRegister,
    DateTime? providerCreatedAt,
    String? serviceTypeId,
    Object? locationUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (itemId != null) #itemId: itemId,
      if (itemName != null) #itemName: itemName,
      if (itemDescription != null) #itemDescription: itemDescription,
      if (price != null) #price: price,
      if (image != null) #image: image,
      if (itemCreatedAt != null) #itemCreatedAt: itemCreatedAt,
      if (providerId != null) #providerId: providerId,
      if (authId != null) #authId: authId,
      if (providerName != null) #providerName: providerName,
      if (email != null) #email: email,
      if (phone != null) #phone: phone,
      if (location != null) #location: location,
      if (commercialRegister != null) #commercialRegister: commercialRegister,
      if (providerCreatedAt != null) #providerCreatedAt: providerCreatedAt,
      if (serviceTypeId != null) #serviceTypeId: serviceTypeId,
      if (locationUrl != $none) #locationUrl: locationUrl,
    }),
  );
  @override
  HotelModel $make(CopyWithData data) => HotelModel(
    itemId: data.get(#itemId, or: $value.itemId),
    itemName: data.get(#itemName, or: $value.itemName),
    itemDescription: data.get(#itemDescription, or: $value.itemDescription),
    price: data.get(#price, or: $value.price),
    image: data.get(#image, or: $value.image),
    itemCreatedAt: data.get(#itemCreatedAt, or: $value.itemCreatedAt),
    providerId: data.get(#providerId, or: $value.providerId),
    authId: data.get(#authId, or: $value.authId),
    providerName: data.get(#providerName, or: $value.providerName),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    location: data.get(#location, or: $value.location),
    commercialRegister: data.get(
      #commercialRegister,
      or: $value.commercialRegister,
    ),
    providerCreatedAt: data.get(
      #providerCreatedAt,
      or: $value.providerCreatedAt,
    ),
    serviceTypeId: data.get(#serviceTypeId, or: $value.serviceTypeId),
    locationUrl: data.get(#locationUrl, or: $value.locationUrl),
  );

  @override
  HotelModelCopyWith<$R2, HotelModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HotelModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

