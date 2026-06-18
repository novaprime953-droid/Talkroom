enum ChatMessageType { text, gift, system, entry }

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.userName,
    required this.content,
    required this.type,
    required this.timestamp,
    this.vipTier = 0,
    this.giftEmoji,
  });

  final String id;
  final String userName;
  final String content;
  final ChatMessageType type;
  final DateTime timestamp;
  final int vipTier;
  final String? giftEmoji;
}
