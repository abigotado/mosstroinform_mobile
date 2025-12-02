import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';

/// Моковая реализация репозитория чатов
class MockChatRepository implements ChatRepository {
  final List<Chat> _mockChats = [
    Chat(
      id: 'chat1',
      projectId: '1',
      specialistName: 'Иван Петров',
      specialistAvatarUrl: 'https://via.placeholder.com/64?text=ИП',
      lastMessage: 'Добрый день! Как дела со строительством?',
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 2)),
      unreadCount: 2,
      isActive: true,
    ),
    Chat(
      id: 'chat2',
      projectId: '2',
      specialistName: 'Мария Сидорова',
      specialistAvatarUrl: 'https://via.placeholder.com/64?text=МС',
      lastMessage: 'Все документы готовы к подписанию',
      lastMessageAt: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 0,
      isActive: true,
    ),
  ];

  final Map<String, List<Message>> _mockMessages = {
    'chat1': [
      Message(
        id: 'msg1',
        chatId: 'chat1',
        text: 'Добрый день! Как дела со строительством?',
        sentAt: DateTime.now().subtract(const Duration(hours: 3)),
        isFromSpecialist: true,
        isRead: true,
      ),
      Message(
        id: 'msg2',
        chatId: 'chat1',
        text: 'Всё отлично, спасибо!',
        sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        isFromSpecialist: false,
        isRead: true,
      ),
      Message(
        id: 'msg3',
        chatId: 'chat1',
        text: 'Отлично! Если будут вопросы, обращайтесь.',
        sentAt: DateTime.now().subtract(const Duration(hours: 2)),
        isFromSpecialist: true,
        isRead: false,
      ),
    ],
    'chat2': [
      Message(
        id: 'msg4',
        chatId: 'chat2',
        text: 'Все документы готовы к подписанию',
        sentAt: DateTime.now().subtract(const Duration(days: 1)),
        isFromSpecialist: true,
        isRead: true,
      ),
    ],
  };

  @override
  Future<List<Chat>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockChats;
  }

  @override
  Future<Chat> getChatById(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockChats.firstWhere((chat) => chat.id == chatId);
    } catch (e) {
      throw UnknownFailure('Моковый чат с ID $chatId не найден');
    }
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockMessages[chatId] ?? [];
  }

  @override
  Future<Message> sendMessage(String chatId, String text) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final messages = _mockMessages[chatId] ?? [];
    final newMessage = Message(
      id: 'msg${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      text: text,
      sentAt: DateTime.now(),
      isFromSpecialist: false,
      isRead: true,
    );
    messages.add(newMessage);
    _mockMessages[chatId] = messages;

    // Обновить последнее сообщение в чате
    final chatIndex = _mockChats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _mockChats[chatIndex] = Chat(
        id: _mockChats[chatIndex].id,
        projectId: _mockChats[chatIndex].projectId,
        specialistName: _mockChats[chatIndex].specialistName,
        specialistAvatarUrl: _mockChats[chatIndex].specialistAvatarUrl,
        lastMessage: text,
        lastMessageAt: DateTime.now(),
        unreadCount: _mockChats[chatIndex].unreadCount,
        isActive: _mockChats[chatIndex].isActive,
      );
    }

    return newMessage;
  }

  @override
  Future<void> markMessagesAsRead(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final messages = _mockMessages[chatId] ?? [];
    for (var i = 0; i < messages.length; i++) {
      if (!messages[i].isRead) {
        _mockMessages[chatId]![i] = Message(
          id: messages[i].id,
          chatId: messages[i].chatId,
          text: messages[i].text,
          sentAt: messages[i].sentAt,
          isFromSpecialist: messages[i].isFromSpecialist,
          isRead: true,
        );
      }
    }

    // Обновить количество непрочитанных в чате
    final chatIndex = _mockChats.indexWhere((chat) => chat.id == chatId);
    if (chatIndex != -1) {
      _mockChats[chatIndex] = Chat(
        id: _mockChats[chatIndex].id,
        projectId: _mockChats[chatIndex].projectId,
        specialistName: _mockChats[chatIndex].specialistName,
        specialistAvatarUrl: _mockChats[chatIndex].specialistAvatarUrl,
        lastMessage: _mockChats[chatIndex].lastMessage,
        lastMessageAt: _mockChats[chatIndex].lastMessageAt,
        unreadCount: 0,
        isActive: _mockChats[chatIndex].isActive,
      );
    }
  }
}
