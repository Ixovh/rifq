import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rifq/features/owner_flow/ai/domain/usecases/ai_message_usecase.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  final AIConfigUsecase _useCase;
  AiChatBloc(this._useCase) : super(AiChatInitial()) {
    on<AIStarted>((event, emit) {
      emit(AILoading());
      try {
        print("-----here i am");
        final entity = _useCase();
           print("-----here i am m ${entity.model}");
              print("-----here i am k ${entity.apiKey}");
        GeminiProvider provider = GeminiProvider(
          model: GenerativeModel(
            model: entity.model,
            apiKey: entity.apiKey,
            systemInstruction: Content.system(entity.instructions),
          ),
        );

        emit(AILoaded(provider: provider, welcomeMessage: entity.welcomeMessage));
      }
    catch(e) {
              print("-----here i error");

      print(e.toString());
      emit(AIError("Failed to start chat: $e"));
    }
    });
  }
}
