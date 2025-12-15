enum MessageSender { user, ai }

class ChatMessageEntity {
  final String message;
  final MessageSender sender;

  ChatMessageEntity({
    required this.message,
    required this.sender,
  });
}
