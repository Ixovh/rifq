import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:rifq/core/theme/app_theme.dart';

class ChatHeader extends StatelessWidget {
  final GeminiProvider provider;
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
        progressIndicatorColor:context.primary50,
        llmMessageStyle:LlmMessageStyle(iconColor:context.primary50,iconDecoration:BoxDecoration(color: context.background) ) ,
        menuColor:context.primary50,
        chatInputStyle: ChatInputStyle(
          hintText: "Enter your message",
          decoration: BoxDecoration().copyWith(borderRadius: BorderRadius.circular(50),),
        ),

        addButtonStyle:ActionButtonStyle(iconColor:context.primary50, iconDecoration:BoxDecoration(color: context.background) ),
        recordButtonStyle:ActionButtonStyle(iconColor:context.primary50,iconDecoration:BoxDecoration(color: context.background) ),
        userMessageStyle:UserMessageStyle(textStyle: context.body3.copyWith(color: context.background), decoration:BoxDecoration(color: context.primary, borderRadius:BorderRadius.circular(20))),
submitButtonStyle:ActionButtonStyle(iconColor:context.primary50,iconDecoration:BoxDecoration(color: context.background) ),

// actionButtonBarDecoration:BoxDecoration(color: context.red10)
      ),
      provider: provider,
      welcomeMessage: welcomeMessage,
    );
  }
}