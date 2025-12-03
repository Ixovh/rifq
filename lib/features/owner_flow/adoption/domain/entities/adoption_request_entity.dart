class AdoptionRequestEntity {
  final String id;
  final String petId;
  final String ownerId; 
  final String title;
  final String description;
  final String status; // 'pending', 'accepted', 'rejected', 'cancelled'
  final DateTime createdAt;

  const AdoptionRequestEntity({
    required this.id,
    required this.petId,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });
}
