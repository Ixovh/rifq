// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:injectable/injectable.dart';
// import 'package:rifq/core/shared/shared_in_owner_flow/shared/models/provider_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:multiple_result/multiple_result.dart';

// abstract class BaseAiChatDataSource {
//   Future<String> sendMessage(String message);
// }

// @lazySingleton(as: BaseAiChatDataSource)
// class AiChatDataSource implements BaseAiChatDataSource{
//   late final GenerativeModel _model;

//   AiChatDataSource() {
//     final apiKey = dotenv.env['GEMINI_API_KEY'];
//     if (apiKey == null) {
//       throw Exception('Gemini API key not found');
//     }

//     _model = GenerativeModel(
//       model: 'gemini-1.5-flash',
//       apiKey: apiKey,
//     );
//   }

//   Future<String> sendMessage(String message) async {
//     final response = await _model.generateContent([Content.text(message)]);
//     return response.text ?? 'No response';
//   }
// }
