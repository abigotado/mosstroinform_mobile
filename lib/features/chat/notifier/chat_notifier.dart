import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/domain/providers/chat_repository_provider.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_notifier.g.dart';

/// Состояние списка чатов
class ChatsState {
  final List<Chat> chats;
  final bool isLoading;
  final Failure? error;

  const ChatsState({required this.chats, this.isLoading = false, this.error});

  ChatsState copyWith({List<Chat>? chats, bool? isLoading, Failure? error}) {
    return ChatsState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
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

  const MessagesState({
    required this.messages,
    this.isLoading = false,
    this.error,
    this.isSending = false,
  });

  MessagesState copyWith({
    List<Message>? messages,
    bool? isLoading,
    Failure? error,
    bool? isSending,
  }) {
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
  @override
  Future<MessagesState> build(String chatId) async {
    // Сразу загружаем сообщения при создании провайдера
    try {
      final repository = ref.read(chatRepositoryProvider);
      final messages = await repository.getMessages(chatId);
      return MessagesState(messages: messages, isLoading: false);
    } on Failure catch (e) {
      return MessagesState(messages: [], isLoading: false, error: e);
    } catch (e) {
      return MessagesState(
        messages: [],
        isLoading: false,
        error: UnknownFailure('Неизвестная ошибка: $e'),
      );
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
      state = AsyncValue.data(
        MessagesState(messages: messages, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(isLoading: false, error: e) ??
            MessagesState(messages: [], isLoading: false, error: e),
      );
    } catch (e, s) {
      state = AsyncValue.data(
        currentState?.copyWith(
              isLoading: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ) ??
            MessagesState(
              messages: [],
              isLoading: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ),
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
      final repository = ref.read(chatRepositoryProvider);
      await repository.sendMessage(chatId, text.trim());
      
      // Перезагружаем сообщения вместо добавления вручную,
      // чтобы избежать дублирования (репозиторий уже добавил сообщение)
      // Не показываем loading, так как данные уже есть
      await loadMessages(showLoading: false);
      
      // Обновляем состояние, убирая флаг отправки
      final updatedState = state.value;
      if (updatedState != null) {
        state = AsyncValue.data(updatedState.copyWith(isSending: false));
      }
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(isSending: false, error: e),
      );
    } catch (e, s) {
      state = AsyncValue.data(
        currentState.copyWith(
          isSending: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
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
