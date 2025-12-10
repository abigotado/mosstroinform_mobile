// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  id: json['id'] as String,
  projectId: json['project_id'] as String,
  specialistName: json['specialist_name'] as String,
  specialistAvatarUrl: json['specialist_avatar_url'] as String?,
  lastMessage: json['last_message'] as String?,
  lastMessageAt: json['last_message_at'] == null
      ? null
      : DateTime.parse(json['last_message_at'] as String),
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'specialist_name': instance.specialistName,
      'specialist_avatar_url': ?instance.specialistAvatarUrl,
      'last_message': ?instance.lastMessage,
      'last_message_at': ?instance.lastMessageAt?.toIso8601String(),
      'unread_count': instance.unreadCount,
      'is_active': instance.isActive,
    };

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      text: json['text'] as String,
      sentAt: DateTime.parse(json['sent_at'] as String),
      isFromSpecialist: json['is_from_specialist'] as bool? ?? false,
      isRead: json['is_read'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'text': instance.text,
      'sent_at': instance.sentAt.toIso8601String(),
      'is_from_specialist': instance.isFromSpecialist,
      'is_read': instance.isRead,
    };
