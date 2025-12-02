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

  const ChatsState({
    required this.chats,
    this.isLoading = false,
    this.error,
  });

  ChatsState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    Failure? error,
  }) {
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
      state = AsyncValue.data(
        ChatsState(chats: chats, isLoading: false),
      );
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
@riverpod
class MessagesNotifier extends _$MessagesNotifier {
  @override
  Future<MessagesState> build(String chatId) async {
    return const MessagesState(messages: []);
  }

  /// Загрузить сообщения чата
  Future<void> loadMessages() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(chatRepositoryProvider);
      final messages = await repository.getMessages(chatId);
      state = AsyncValue.data(
        MessagesState(messages: messages, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
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
      final newMessage = await repository.sendMessage(chatId, text.trim());
      
      final updatedMessages = [...currentState.messages, newMessage];
      state = AsyncValue.data(
        MessagesState(
          messages: updatedMessages,
          isLoading: false,
          isSending: false,
        ),
      );
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }

  /// Отметить сообщения как прочитанные
  Future<void> markAsRead() async {
    try {
      final repository = ref.read(chatRepositoryProvider);
      await repository.markMessagesAsRead(chatId);
      await loadMessages(); // Перезагрузить сообщения
    } on Failure catch (_) {
      // Игнорируем ошибки при отметке как прочитанные
    } catch (_) {
      // Игнорируем ошибки при отметке как прочитанные
    }
  }
}
