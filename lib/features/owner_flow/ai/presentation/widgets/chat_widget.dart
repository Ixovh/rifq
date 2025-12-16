import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ChatHeader extends StatelessWidget {
  final LlmProvider provider;
  final String welcomeMessage;

  const ChatHeader({super.key, required this.provider, required this.welcomeMessage});

  @override
  Widget build(BuildContext context) {
    return LlmChatView(
      suggestions: const [
        "Why does my cat sleep a lot?",
        "What to do if my dog is coughing?",
      ],
      style: LlmChatViewStyle(
        backgroundColor: Colors.white,
        chatInputStyle: ChatInputStyle(
          hintText: "Enter your message",
          decoration: BoxDecoration().copyWith(borderRadius: BorderRadius.circular(50),),
        ),
      ),
      provider: provider,
      welcomeMessage: welcomeMessage,
    );
  }
}