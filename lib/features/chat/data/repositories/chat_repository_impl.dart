import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
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
    return guard(() async {
      final models = await remoteDataSource.getChats();
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getChats');
  }

  @override
  Future<Chat> getChatById(String chatId) async {
    return guard(() async {
      final model = await remoteDataSource.getChatById(chatId);
      return model.toEntity();
    }, methodName: 'getChatById');
  }

  @override
  Future<List<Message>> getMessages(String chatId) async {
    return guard(() async {
      final models = await remoteDataSource.getMessages(chatId);
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getMessages');
  }

  @override
  Future<Message> sendMessage(String chatId, String text) async {
    return guard(() async {
      final model = await remoteDataSource.sendMessage(chatId, {'text': text});
      return model.toEntity();
    }, methodName: 'sendMessage');
  }

  @override
  Future<void> markMessagesAsRead(String chatId) async {
    return guard(() async {
      await remoteDataSource.markMessagesAsRead(chatId);
    }, methodName: 'markMessagesAsRead');
  }
}
