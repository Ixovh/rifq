// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:injectable/injectable.dart';

// abstract class BaseAiMessageDataSource {
//   Future<String> sendText(String message);

//   Future<String> sendImage(String message, List<int> imageBytes);
// }

// @LazySingleton(as: BaseAiMessageDataSource)
// class AiMessageDataSource implements BaseAiMessageDataSource {
//   late final GenerativeModel _model;

//   AiMessageDataSource() {
//     final apiKey = dotenv.env['GEMINI_API_KEY']!;

//     _model = GenerativeModel(model: 'models/gemini-1.0-pro', apiKey: apiKey);
//   }

//   @override
//   Future<String> sendText(String message) async {
//     try {
//       final response = await _model.generateContent([Content.text(message)]);

//       return response.text ?? 'No response from Gemini';
//     } catch (e, s) {
//       debugPrint('GEMINI ERROR: $e');
//       debugPrintStack(stackTrace: s);
//       rethrow;
//     }
//   }

//   @override
//   Future<String> sendImage(String message, List<int> imageBytes) async {
//     final response = await _model.generateContent([
//       Content.multi([
//         TextPart(message),
//         DataPart('image/jpeg', Uint8List.fromList(imageBytes)),
//       ]),
//     ]);
//     return response.text ?? 'No response';
//   }
// }
// //!!!!


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/ai/data/models/ai_model.dart';

abstract class AIDatasource {
  AIModel aiCongif();
}

@LazySingleton(as: AIDatasource)
class RemoteDataSource implements AIDatasource {
  @override
  AIModel aiCongif() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final modelName = dotenv.env['Gemini_Model'] ?? '';

    const instructions = "You're a professional AI Assitant. You should only answer questions related to animals and pets";
    const welcomeMessage = "Hello, I'm here to help you take care of your pets, feel free to ask.";

    return AIModel(
      apiKey: apiKey,
      model: modelName,
      instructions: instructions,
      welcomeMessage: welcomeMessage,
    );
  }

}