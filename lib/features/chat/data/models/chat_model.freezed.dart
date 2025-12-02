// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatModel {
  String get id => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError;
  String get specialistName => throw _privateConstructorUsedError;
  String? get specialistAvatarUrl => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call({
    String id,
    String projectId,
    String specialistName,
    String? specialistAvatarUrl,
    String? lastMessage,
    DateTime? lastMessageAt,
    int unreadCount,
    bool isActive,
  });
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? specialistName = null,
    Object? specialistAvatarUrl = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            specialistName: null == specialistName
                ? _value.specialistName
                : specialistName // ignore: cast_nullable_to_non_nullable
                      as String,
            specialistAvatarUrl: freezed == specialistAvatarUrl
                ? _value.specialistAvatarUrl
                : specialistAvatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMessageAt: freezed == lastMessageAt
                ? _value.lastMessageAt
                : lastMessageAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
    _$ChatModelImpl value,
    $Res Function(_$ChatModelImpl) then,
  ) = __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String projectId,
    String specialistName,
    String? specialistAvatarUrl,
    String? lastMessage,
    DateTime? lastMessageAt,
    int unreadCount,
    bool isActive,
  });
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
    _$ChatModelImpl _value,
    $Res Function(_$ChatModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? projectId = null,
    Object? specialistName = null,
    Object? specialistAvatarUrl = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ChatModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        specialistName: null == specialistName
            ? _value.specialistName
            : specialistName // ignore: cast_nullable_to_non_nullable
                  as String,
        specialistAvatarUrl: freezed == specialistAvatarUrl
            ? _value.specialistAvatarUrl
            : specialistAvatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMessageAt: freezed == lastMessageAt
            ? _value.lastMessageAt
            : lastMessageAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ChatModelImpl implements _ChatModel {
  const _$ChatModelImpl({
    required this.id,
    required this.projectId,
    required this.specialistName,
    this.specialistAvatarUrl,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isActive = true,
  });

  @override
  final String id;
  @override
  final String projectId;
  @override
  final String specialistName;
  @override
  final String? specialistAvatarUrl;
  @override
  final String? lastMessage;
  @override
  final DateTime? lastMessageAt;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'ChatModel(id: $id, projectId: $projectId, specialistName: $specialistName, specialistAvatarUrl: $specialistAvatarUrl, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.specialistName, specialistName) ||
                other.specialistName == specialistName) &&
            (identical(other.specialistAvatarUrl, specialistAvatarUrl) ||
                other.specialistAvatarUrl == specialistAvatarUrl) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    projectId,
    specialistName,
    specialistAvatarUrl,
    lastMessage,
    lastMessageAt,
    unreadCount,
    isActive,
  );

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);
}

abstract class _ChatModel implements ChatModel {
  const factory _ChatModel({
    required final String id,
    required final String projectId,
    required final String specialistName,
    final String? specialistAvatarUrl,
    final String? lastMessage,
    final DateTime? lastMessageAt,
    final int unreadCount,
    final bool isActive,
  }) = _$ChatModelImpl;

  @override
  String get id;
  @override
  String get projectId;
  @override
  String get specialistName;
  @override
  String? get specialistAvatarUrl;
  @override
  String? get lastMessage;
  @override
  DateTime? get lastMessageAt;
  @override
  int get unreadCount;
  @override
  bool get isActive;

  /// Create a copy of ChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageModel {
  String get id => throw _privateConstructorUsedError;
  String get chatId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  DateTime get sentAt => throw _privateConstructorUsedError;
  bool get isFromSpecialist => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageModelCopyWith<MessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageModelCopyWith<$Res> {
  factory $MessageModelCopyWith(
    MessageModel value,
    $Res Function(MessageModel) then,
  ) = _$MessageModelCopyWithImpl<$Res, MessageModel>;
  @useResult
  $Res call({
    String id,
    String chatId,
    String text,
    DateTime sentAt,
    bool isFromSpecialist,
    bool isRead,
  });
}

/// @nodoc
class _$MessageModelCopyWithImpl<$Res, $Val extends MessageModel>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? text = null,
    Object? sentAt = null,
    Object? isFromSpecialist = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            chatId: null == chatId
                ? _value.chatId
                : chatId // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isFromSpecialist: null == isFromSpecialist
                ? _value.isFromSpecialist
                : isFromSpecialist // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageModelImplCopyWith<$Res>
    implements $MessageModelCopyWith<$Res> {
  factory _$$MessageModelImplCopyWith(
    _$MessageModelImpl value,
    $Res Function(_$MessageModelImpl) then,
  ) = __$$MessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String chatId,
    String text,
    DateTime sentAt,
    bool isFromSpecialist,
    bool isRead,
  });
}

/// @nodoc
class __$$MessageModelImplCopyWithImpl<$Res>
    extends _$MessageModelCopyWithImpl<$Res, _$MessageModelImpl>
    implements _$$MessageModelImplCopyWith<$Res> {
  __$$MessageModelImplCopyWithImpl(
    _$MessageModelImpl _value,
    $Res Function(_$MessageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? text = null,
    Object? sentAt = null,
    Object? isFromSpecialist = null,
    Object? isRead = null,
  }) {
    return _then(
      _$MessageModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        chatId: null == chatId
            ? _value.chatId
            : chatId // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isFromSpecialist: null == isFromSpecialist
            ? _value.isFromSpecialist
            : isFromSpecialist // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MessageModelImpl implements _MessageModel {
  const _$MessageModelImpl({
    required this.id,
    required this.chatId,
    required this.text,
    required this.sentAt,
    this.isFromSpecialist = false,
    this.isRead = false,
  });

  @override
  final String id;
  @override
  final String chatId;
  @override
  final String text;
  @override
  final DateTime sentAt;
  @override
  @JsonKey()
  final bool isFromSpecialist;
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'MessageModel(id: $id, chatId: $chatId, text: $text, sentAt: $sentAt, isFromSpecialist: $isFromSpecialist, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.isFromSpecialist, isFromSpecialist) ||
                other.isFromSpecialist == isFromSpecialist) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    chatId,
    text,
    sentAt,
    isFromSpecialist,
    isRead,
  );

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      __$$MessageModelImplCopyWithImpl<_$MessageModelImpl>(this, _$identity);
}

abstract class _MessageModel implements MessageModel {
  const factory _MessageModel({
    required final String id,
    required final String chatId,
    required final String text,
    required final DateTime sentAt,
    final bool isFromSpecialist,
    final bool isRead,
  }) = _$MessageModelImpl;

  @override
  String get id;
  @override
  String get chatId;
  @override
  String get text;
  @override
  DateTime get sentAt;
  @override
  bool get isFromSpecialist;
  @override
  bool get isRead;

  /// Create a copy of MessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageModelImplCopyWith<_$MessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
