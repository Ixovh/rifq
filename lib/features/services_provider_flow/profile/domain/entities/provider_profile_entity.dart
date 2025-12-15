class ProviderProfileEntity {
  final String id;
  final String authId;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String commercialRegister;
  final String locationUrl;
  final String? image;
  final DateTime createdAt;

  ProviderProfileEntity({
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.commercialRegister,
    required this.locationUrl,
    this.image,
    required this.createdAt,
  });
}
