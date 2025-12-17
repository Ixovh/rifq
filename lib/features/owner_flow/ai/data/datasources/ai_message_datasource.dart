


import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/ai/data/models/ai_model.dart';

abstract class AIDatasource {
  AIModel aiCongif();
}

@LazySingleton(as: AIDatasource)
class RemoteDataSource implements AIDatasource {
  @override
  AIModel aiCongif() {
    final apiKey =  'your api key';
    final modelName =  'gemini-2.5-flash';

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
