import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

/// Модель чата для работы с API
@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String id,
    required String projectId,
    required String specialistName,
    String? specialistAvatarUrl,
    String? lastMessage,
    DateTime? lastMessageAt,
    @Default(0) int unreadCount,
    @Default(true) bool isActive,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

/// Модель сообщения для работы с API
@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String chatId,
    required String text,
    required DateTime sentAt,
    @Default(false) bool isFromSpecialist,
    @Default(false) bool isRead,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

/// Расширение для конвертации модели чата в сущность
extension ChatModelExtension on ChatModel {
  Chat toEntity() {
    return Chat(
      id: id,
      projectId: projectId,
      specialistName: specialistName,
      specialistAvatarUrl: specialistAvatarUrl,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      isActive: isActive,
    );
  }
}

/// Расширение для конвертации модели сообщения в сущность
extension MessageModelExtension on MessageModel {
  Message toEntity() {
    return Message(
      id: id,
      chatId: chatId,
      text: text,
      sentAt: sentAt,
      isFromSpecialist: isFromSpecialist,
      isRead: isRead,
    );
  }
}
