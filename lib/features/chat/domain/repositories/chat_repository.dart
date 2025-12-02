import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';

/// Интерфейс репозитория для работы с чатами
abstract class ChatRepository {
  /// Получить список всех чатов пользователя
  Future<List<Chat>> getChats();

  /// Получить чат по ID
  Future<Chat> getChatById(String chatId);

  /// Получить сообщения чата
  Future<List<Message>> getMessages(String chatId);

  /// Отправить сообщение в чат
  Future<Message> sendMessage(String chatId, String text);

  /// Отметить сообщения как прочитанные
  Future<void> markMessagesAsRead(String chatId);
}

