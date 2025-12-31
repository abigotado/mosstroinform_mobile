import 'dart:async';

import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/chat/data/providers/chat_websocket_provider.dart';
import 'package:mosstroinform_mobile/features/chat/domain/datasources/chat_websocket_data_source.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat_action.dart';
import 'package:mosstroinform_mobile/features/chat/domain/providers/chat_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_notifier.g.dart';

/// Состояние списка чатов
class ChatsState {
  final List<Chat> chats;
  final bool isLoading;
  final Failure? error;

  const ChatsState({required this.chats, this.isLoading = false, this.error});

  ChatsState copyWith({List<Chat>? chats, bool? isLoading, Failure? error}) {
    return ChatsState(chats: chats ?? this.chats, isLoading: isLoading ?? this.isLoading, error: error);
  }
}

/// Notifier для управления состоянием списка чатов
@riverpod
class ChatsNotifier extends _$ChatsNotifier {
  @override
  Future<ChatsState> build() async {
    return const ChatsState(chats: []);
  }

  /// Загрузить список чатов
  Future<void> loadChats() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(chatRepositoryProvider);
      final chats = await repository.getChats();
      state = AsyncValue.data(ChatsState(chats: chats, isLoading: false));
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }
}

/// Состояние сообщений чата
class MessagesState {
  final List<Message> messages;
  final bool isLoading;
  final Failure? error;
  final bool isSending;

  const MessagesState({required this.messages, this.isLoading = false, this.error, this.isSending = false});

  MessagesState copyWith({List<Message>? messages, bool? isLoading, Failure? error, bool? isSending}) {
    return MessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSending: isSending ?? this.isSending,
    );
  }
}

/// Notifier для управления состоянием сообщений чата
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние сообщений должно сохраняться при навигации
@Riverpod(keepAlive: true)
class MessagesNotifier extends _$MessagesNotifier {
  IChatWebSocketDataSource? _websocket;

  @override
  Future<MessagesState> build(String chatId) async {
    AppLogger.info('[MessagesNotifier] build: инициализация для чата $chatId');

    // Настраиваем отключение при dispose провайдера
    ref.onDispose(() {
      AppLogger.info('[MessagesNotifier] onDispose: отключение от WebSocket для чата $chatId');
      _websocket?.disconnect();
      AppLogger.info('[MessagesNotifier] onDispose: WebSocket отключен');
    });

    // Сразу загружаем сообщения при создании провайдера
    try {
      AppLogger.debug('[MessagesNotifier] build: загрузка сообщений из репозитория...');
      final repository = ref.read(chatRepositoryProvider);
      final messages = await repository.getMessages(chatId);
      AppLogger.info('[MessagesNotifier] build: загружено ${messages.length} сообщений из репозитория');

      // Подключаемся к WebSocket для получения новых сообщений
      _connectWebSocket(chatId);

      return MessagesState(messages: messages, isLoading: false);
    } on Failure catch (e) {
      AppLogger.error('[MessagesNotifier] build: ошибка Failure: $e');
      return MessagesState(messages: [], isLoading: false, error: e);
    } catch (e) {
      AppLogger.error('[MessagesNotifier] build: неизвестная ошибка: $e');
      return MessagesState(messages: [], isLoading: false, error: UnknownFailure('Неизвестная ошибка: $e'));
    }
  }

  /// Подключиться к WebSocket для получения новых сообщений
  void _connectWebSocket(String chatId) {
    AppLogger.info('[MessagesNotifier] _connectWebSocket: начало подключения к WebSocket для чата $chatId');
    try {
      final websocket = ref.read(chatWebSocketDataSourceProvider);
      _websocket = websocket;
      AppLogger.debug('[MessagesNotifier] _connectWebSocket: WebSocket провайдер получен');

      websocket.connect(
        chatId,
        (Message message) {
          // Получено новое сообщение через WebSocket
          AppLogger.info('[MessagesNotifier] ← получено новое сообщение через WebSocket: id=${message.id}');
          AppLogger.debug(
            '[MessagesNotifier] ← текст: ${message.text.substring(0, message.text.length > 50 ? 50 : message.text.length)}${message.text.length > 50 ? '...' : ''}',
          );

          if (!ref.mounted) {
            AppLogger.warning('[MessagesNotifier] ← провайдер disposed, игнорируем сообщение');
            return;
          }

          final currentState = state.value;
          if (currentState != null) {
            // Проверяем, нет ли уже такого сообщения (избегаем дубликатов)
            final messageId = message.id;
            final existingMessage = currentState.messages.any((m) => m.id == messageId);
            if (!existingMessage) {
              AppLogger.info(
                '[MessagesNotifier] ← добавляем новое сообщение в список (всего было: ${currentState.messages.length})',
              );
              // Добавляем новое сообщение в список
              final updatedMessages = <Message>[...currentState.messages, message];
              state = AsyncValue.data(currentState.copyWith(messages: updatedMessages));
              AppLogger.info('[MessagesNotifier] ← сообщение добавлено (всего стало: ${updatedMessages.length})');
            } else {
              AppLogger.debug('[MessagesNotifier] ← сообщение уже существует, пропускаем (id=$messageId)');
            }
          } else {
            AppLogger.warning('[MessagesNotifier] ← состояние null, не можем добавить сообщение');
          }
        },
        (error) {
          // Ошибка WebSocket - логируем, но не прерываем работу
          AppLogger.error('[MessagesNotifier] ✗ ошибка WebSocket: $error');
          AppLogger.error('[MessagesNotifier] ✗ тип ошибки: ${error.runtimeType}');
        },
      );
      AppLogger.info('[MessagesNotifier] ✓ WebSocket подключение инициировано для чата $chatId');
    } catch (e, stackTrace) {
      AppLogger.error('[MessagesNotifier] ✗ ошибка подключения к WebSocket: $e', stackTrace);
      AppLogger.error('[MessagesNotifier] ✗ chatId: $chatId');
      AppLogger.error('[MessagesNotifier] ✗ stackTrace: $stackTrace');
    }
  }

  /// Загрузить сообщения чата
  Future<void> loadMessages({bool showLoading = true}) async {
    // Если showLoading = false и есть данные, обновляем без показа loading
    final currentState = state.value;
    if (showLoading || currentState == null || currentState.messages.isEmpty) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(chatRepositoryProvider);
      final messages = await repository.getMessages(chatId);
      state = AsyncValue.data(MessagesState(messages: messages, isLoading: false));
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(isLoading: false, error: e) ??
            MessagesState(messages: [], isLoading: false, error: e),
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(isLoading: false, error: UnknownFailure('Неизвестная ошибка: $e')) ??
            MessagesState(messages: [], isLoading: false, error: UnknownFailure('Неизвестная ошибка: $e')),
      );
    }
  }

  /// Отправить сообщение
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(isSending: true));

    try {
      // Отправляем сообщение только через WebSocket
      if (_websocket == null || !_websocket!.isConnected) {
        AppLogger.error('[MessagesNotifier] sendMessage: WebSocket не подключен');
        state = AsyncValue.data(
          currentState.copyWith(
            isSending: false,
            error: UnknownFailure('WebSocket не подключен. Не удалось отправить сообщение.'),
          ),
        );
        return;
      }

      AppLogger.info('[MessagesNotifier] sendMessage: отправка CREATE action через WebSocket');
      final createAction = CreateMessageAction(
        text: text.trim(),
        fromSpecialist: false, // В мобильном приложении пользователь не является специалистом
      );
      await _websocket!.sendAction(createAction);
      AppLogger.info('[MessagesNotifier] sendMessage: CREATE action успешно отправлен через WebSocket');

      // Сообщение будет добавлено в состояние через WebSocket callback, когда придет ответ от сервера
      // Обновляем состояние, убирая флаг отправки
      final finalState = state.value;
      if (finalState != null) {
        state = AsyncValue.data(finalState.copyWith(isSending: false));
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        '[MessagesNotifier] sendMessage: ошибка отправки CREATE action через WebSocket: $e',
        stackTrace,
      );
      state = AsyncValue.data(
        currentState.copyWith(isSending: false, error: UnknownFailure('Ошибка отправки сообщения: $e')),
      );
    }
  }

  /// Отметить сообщения как прочитанные
  Future<void> markAsRead() async {
    try {
      final repository = ref.read(chatRepositoryProvider);
      await repository.markMessagesAsRead(chatId);
      // Перезагружаем сообщения без показа loading
      await loadMessages(showLoading: false);
    } on Failure catch (_) {
      // Игнорируем ошибки при отметке как прочитанные
    } catch (_) {
      // Игнорируем ошибки при отметке как прочитанные
    }
  }
}
