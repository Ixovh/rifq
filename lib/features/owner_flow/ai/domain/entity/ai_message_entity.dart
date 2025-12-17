// class AiMessageEntity {
//   final String text;
//   final bool isUser;
//   final String? imagePath;

//   AiMessageEntity({
//     required this.text,
//     required this.isUser,
//     this.imagePath,
//   });
// }
// //!!!!!!

class AIEntity {
  final String apiKey;
  final String model;
  final String instructions;
  final String welcomeMessage;

  AIEntity({required this.apiKey, required this.model, required this.instructions, required this.welcomeMessage});
}