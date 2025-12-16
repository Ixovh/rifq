
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