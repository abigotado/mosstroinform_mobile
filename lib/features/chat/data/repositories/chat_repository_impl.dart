import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/data/models/chat_model.dart';
import 'package:mosstroinform_mobile/features/chat/domain/datasources/chat_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';

/// Реализация репозитория чатов
class ChatRepositoryImpl implements ChatRepository {
  final IChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Chat>> getChats() async {
    try {
      final models = await remoteDataSource.getChats();
      return models.map((model) => model.toEntity()).toList();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении списка чатов: $e');
    }
  }

  @override
  Future<Chat> getChatById(String chatId) async {
    try {
      final model = await remoteDataSource.getChatById(chatId);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении чата: $e');
    }
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    try {
      final models = await remoteDataSource.getMessages(chatId);
      return models.map((model) => model.toEntity()).toList();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении сообщений: $e');
    }
  }

  @override
  Future<Message> sendMessage(String chatId, String text) async {
    try {
      final model = await remoteDataSource.sendMessage(chatId, {'text': text});
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отправке сообщения: $e');
    }
  }

  @override
  Future<void> markMessagesAsRead(String chatId) async {
    try {
      await remoteDataSource.markMessagesAsRead(chatId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отметке сообщений как прочитанных: $e');
    }
  }
}
