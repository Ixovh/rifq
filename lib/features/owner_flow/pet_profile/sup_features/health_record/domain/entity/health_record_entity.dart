class HealthRecordEntity {
  final String id;
  final String petId;
  final String type;
  final String title;
  final String description;
  final DateTime date;
  final String clinicName;

  HealthRecordEntity({
    required this.id,
    required this.petId,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.clinicName,
  });
}
