// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'provider_items_view_model.dart';

class ProviderItemsViewModelMapper
    extends ClassMapperBase<ProviderItemsViewModel> {
  ProviderItemsViewModelMapper._();

  static ProviderItemsViewModelMapper? _instance;
  static ProviderItemsViewModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProviderItemsViewModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProviderItemsViewModel';

  static String _$itemId(ProviderItemsViewModel v) => v.itemId;
  static const Field<ProviderItemsViewModel, String> _f$itemId = Field(
    'itemId',
    _$itemId,
    key: r'item_id',
  );
  static String _$itemName(ProviderItemsViewModel v) => v.itemName;
  static const Field<ProviderItemsViewModel, String> _f$itemName = Field(
    'itemName',
    _$itemName,
    key: r'item_name',
  );
  static String? _$itemDescription(ProviderItemsViewModel v) =>
      v.itemDescription;
  static const Field<ProviderItemsViewModel, String> _f$itemDescription = Field(
    'itemDescription',
    _$itemDescription,
    key: r'item_description',
    opt: true,
  );
  static num? _$price(ProviderItemsViewModel v) => v.price;
  static const Field<ProviderItemsViewModel, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String _$providerId(ProviderItemsViewModel v) => v.providerId;
  static const Field<ProviderItemsViewModel, String> _f$providerId = Field(
    'providerId',
    _$providerId,
    key: r'provider_id',
  );
  static String _$providerName(ProviderItemsViewModel v) => v.providerName;
  static const Field<ProviderItemsViewModel, String> _f$providerName = Field(
    'providerName',
    _$providerName,
    key: r'provider_name',
  );
  static String? _$providerImage(ProviderItemsViewModel v) => v.providerImage;
  static const Field<ProviderItemsViewModel, String> _f$providerImage = Field(
    'providerImage',
    _$providerImage,
    key: r'provider_image',
    opt: true,
  );
  static String? _$phone(ProviderItemsViewModel v) => v.phone;
  static const Field<ProviderItemsViewModel, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$location(ProviderItemsViewModel v) => v.location;
  static const Field<ProviderItemsViewModel, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$locationUrl(ProviderItemsViewModel v) => v.locationUrl;
  static const Field<ProviderItemsViewModel, String> _f$locationUrl = Field(
    'locationUrl',
    _$locationUrl,
    key: r'location_url',
    opt: true,
  );

  @override
  final MappableFields<ProviderItemsViewModel> fields = const {
    #itemId: _f$itemId,
    #itemName: _f$itemName,
    #itemDescription: _f$itemDescription,
    #price: _f$price,
    #providerId: _f$providerId,
    #providerName: _f$providerName,
    #providerImage: _f$providerImage,
    #phone: _f$phone,
    #location: _f$location,
    #locationUrl: _f$locationUrl,
  };

  static ProviderItemsViewModel _instantiate(DecodingData data) {
    return ProviderItemsViewModel(
      itemId: data.dec(_f$itemId),
      itemName: data.dec(_f$itemName),
      itemDescription: data.dec(_f$itemDescription),
      price: data.dec(_f$price),
      providerId: data.dec(_f$providerId),
      providerName: data.dec(_f$providerName),
      providerImage: data.dec(_f$providerImage),
      phone: data.dec(_f$phone),
      location: data.dec(_f$location),
      locationUrl: data.dec(_f$locationUrl),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProviderItemsViewModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProviderItemsViewModel>(map);
  }

  static ProviderItemsViewModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProviderItemsViewModel>(json);
  }
}

mixin ProviderItemsViewModelMappable {
  String toJson() {
    return ProviderItemsViewModelMapper.ensureInitialized()
        .encodeJson<ProviderItemsViewModel>(this as ProviderItemsViewModel);
  }

  Map<String, dynamic> toMap() {
    return ProviderItemsViewModelMapper.ensureInitialized()
        .encodeMap<ProviderItemsViewModel>(this as ProviderItemsViewModel);
  }

  ProviderItemsViewModelCopyWith<
    ProviderItemsViewModel,
    ProviderItemsViewModel,
    ProviderItemsViewModel
  >
  get copyWith =>
      _ProviderItemsViewModelCopyWithImpl<
        ProviderItemsViewModel,
        ProviderItemsViewModel
      >(this as ProviderItemsViewModel, $identity, $identity);
  @override
  String toString() {
    return ProviderItemsViewModelMapper.ensureInitialized().stringifyValue(
      this as ProviderItemsViewModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProviderItemsViewModelMapper.ensureInitialized().equalsValue(
      this as ProviderItemsViewModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProviderItemsViewModelMapper.ensureInitialized().hashValue(
      this as ProviderItemsViewModel,
    );
  }
}

extension ProviderItemsViewModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProviderItemsViewModel, $Out> {
  ProviderItemsViewModelCopyWith<$R, ProviderItemsViewModel, $Out>
  get $asProviderItemsViewModel => $base.as(
    (v, t, t2) => _ProviderItemsViewModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProviderItemsViewModelCopyWith<
  $R,
  $In extends ProviderItemsViewModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? itemId,
    String? itemName,
    String? itemDescription,
    num? price,
    String? providerId,
    String? providerName,
    String? providerImage,
    String? phone,
    String? location,
    String? locationUrl,
  });
  ProviderItemsViewModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProviderItemsViewModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProviderItemsViewModel, $Out>
    implements
        ProviderItemsViewModelCopyWith<$R, ProviderItemsViewModel, $Out> {
  _ProviderItemsViewModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProviderItemsViewModel> $mapper =
      ProviderItemsViewModelMapper.ensureInitialized();
  @override
  $R call({
    String? itemId,
    String? itemName,
    Object? itemDescription = $none,
    Object? price = $none,
    String? providerId,
    String? providerName,
    Object? providerImage = $none,
    Object? phone = $none,
    Object? location = $none,
    Object? locationUrl = $none,
  }) => $apply(
    FieldCopyWithData({
      if (itemId != null) #itemId: itemId,
      if (itemName != null) #itemName: itemName,
      if (itemDescription != $none) #itemDescription: itemDescription,
      if (price != $none) #price: price,
      if (providerId != null) #providerId: providerId,
      if (providerName != null) #providerName: providerName,
      if (providerImage != $none) #providerImage: providerImage,
      if (phone != $none) #phone: phone,
      if (location != $none) #location: location,
      if (locationUrl != $none) #locationUrl: locationUrl,
    }),
  );
  @override
  ProviderItemsViewModel $make(CopyWithData data) => ProviderItemsViewModel(
    itemId: data.get(#itemId, or: $value.itemId),
    itemName: data.get(#itemName, or: $value.itemName),
    itemDescription: data.get(#itemDescription, or: $value.itemDescription),
    price: data.get(#price, or: $value.price),
    providerId: data.get(#providerId, or: $value.providerId),
    providerName: data.get(#providerName, or: $value.providerName),
    providerImage: data.get(#providerImage, or: $value.providerImage),
    phone: data.get(#phone, or: $value.phone),
    location: data.get(#location, or: $value.location),
    locationUrl: data.get(#locationUrl, or: $value.locationUrl),
  );

  @override
  ProviderItemsViewModelCopyWith<$R2, ProviderItemsViewModel, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProviderItemsViewModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

