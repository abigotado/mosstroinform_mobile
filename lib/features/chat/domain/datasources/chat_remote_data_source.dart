import 'package:mosstroinform_mobile/features/chat/data/models/chat_model.dart';

/// Интерфейс удалённого источника данных для чатов
abstract class IChatRemoteDataSource {
  /// Получить список всех чатов пользователя
  Future<List<ChatModel>> getChats();

  /// Получить чат по ID
  Future<ChatModel> getChatById(String chatId);

  /// Получить сообщения чата
  Future<List<MessageModel>> getMessages(String chatId);

  /// Отправить сообщение в чат
  Future<MessageModel> sendMessage(String chatId, Map<String, dynamic> body);

  /// Отметить сообщения как прочитанные
  Future<void> markMessagesAsRead(String chatId);
}
