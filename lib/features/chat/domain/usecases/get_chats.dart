import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';

/// Use case для получения списка чатов
class GetChats {
  final ChatRepository repository;

  GetChats(this.repository);

  Future<List<Chat>> call() async {
    try {
      return await repository.getChats();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении списка чатов: $e');
    }
  }
}
