class ProviderEntity {
  final String id;
  final String name;
  final String? image;
  final String? location;
  final String? locationUrl;
  final String? phone;

  const ProviderEntity({
    required this.id,
    required this.name,
    this.image,
    this.location,
    this.locationUrl,
    this.phone,
  });
}
