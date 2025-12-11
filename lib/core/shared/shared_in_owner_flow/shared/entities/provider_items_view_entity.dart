class ProviderItemsViewEntity {
  final String itemId;
  final String itemName;
  final String? itemDescription;
  final num? price;
  final String providerId;
  final String providerName;
  final String? providerImage;
  final String? phone;
  final String? location;
  final String? locationUrl;

  const ProviderItemsViewEntity({
    required this.itemId,
    required this.itemName,
    this.itemDescription,
    this.price,
    required this.providerId,
    required this.providerName,
    this.providerImage,
    this.phone,
    this.location,
    this.locationUrl,
  });
}
