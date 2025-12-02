/// Сущность чата
class Chat {
  final String id;
  final String projectId;
  final String specialistName;
  final String? specialistAvatarUrl;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isActive;

  const Chat({
    required this.id,
    required this.projectId,
    required this.specialistName,
    this.specialistAvatarUrl,
    this.lastMessage,
    this.lastMessageAt,
    required this.unreadCount,
    required this.isActive,
  });
}

/// Сущность сообщения
class Message {
  final String id;
  final String chatId;
  final String text;
  final DateTime sentAt;
  final bool isFromSpecialist;
  final bool isRead;

  const Message({
    required this.id,
    required this.chatId,
    required this.text,
    required this.sentAt,
    required this.isFromSpecialist,
    required this.isRead,
  });
}
