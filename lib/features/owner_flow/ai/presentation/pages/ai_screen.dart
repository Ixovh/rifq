import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/ai/domain/usecases/ai_message_usecase.dart';
import 'package:rifq/features/owner_flow/ai/presentation/bloc/ai_chat_bloc.dart';
import 'package:rifq/features/owner_flow/ai/presentation/widgets/chat_widget.dart';
class ChatScreen extends StatelessWidget {
  final AIConfigUsecase _useCase;
  const ChatScreen({super.key, required AIConfigUsecase useCase}): _useCase = useCase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AiChatBloc>(
      create: (context) => AiChatBloc(_useCase)..add(AIStarted()),
      child: Scaffold(
        appBar: AppBar(title: Text("AI Chatbot"),
        ),

        body: BlocBuilder<AiChatBloc, AiChatState>(
          builder: (context, state) {
          if(state is AILoading) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is AILoaded) {
            return ChatHeader(provider: state.provider, welcomeMessage: state.welcomeMessage,);
          }
          else if (state is AIError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        })
      ),
    );
  }
}