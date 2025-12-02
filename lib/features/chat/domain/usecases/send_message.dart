import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';

/// Use case для отправки сообщения
class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<Message> call(String chatId, String text) async {
    try {
      return await repository.sendMessage(chatId, text);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отправке сообщения: $e');
    }
  }
}
