class UserProfileEntity {
  final String id;
  final String authId;
  final String name;
  final String email;
  final DateTime createdAt;

  UserProfileEntity({ required this.id, required this.authId,required this.name,required this.email,required this.createdAt});
}