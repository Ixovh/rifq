part of 'ai_chat_bloc.dart';

sealed class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object> get props => [];
}

final class AiChatInitial extends AiChatState {}

final class AILoading extends AiChatState {}

final class AILoaded extends AiChatState {
  final GeminiProvider provider;
  final String welcomeMessage;

  const AILoaded({required this.provider, required this.welcomeMessage});
}

final class AIError extends AiChatState {
  final String message;

  const AIError(this.message);
}
