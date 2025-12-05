import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';
import 'package:mosstroinform_mobile/features/chat/domain/providers/chat_repository_provider.dart';
import 'package:mosstroinform_mobile/features/chat/notifier/chat_notifier.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockChatRepository();
    container = ProviderContainer(
      overrides: [chatRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ChatsNotifier', () {
    test('build возвращает начальное состояние с пустым списком', () async {
      final state = await container.read(chatsProvider.future);

      expect(state.chats, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadChats успешно загружает чаты', () async {
      final chats = [
        Chat(
          id: '1',
          projectId: 'project1',
          specialistName: 'Специалист 1',
          unreadCount: 2,
          isActive: true,
        ),
        Chat(
          id: '2',
          projectId: 'project2',
          specialistName: 'Специалист 2',
          unreadCount: 0,
          isActive: false,
        ),
      ];

      when(() => mockRepository.getChats()).thenAnswer((_) async => chats);

      final notifier = container.read(chatsProvider.notifier);
      await notifier.loadChats();

      final state = await container.read(chatsProvider.future);

      expect(state.chats, equals(chats));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      verify(() => mockRepository.getChats()).called(1);
    });

    test('loadChats обрабатывает Failure', () async {
      final failure = NetworkFailure('Ошибка сети');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(
        () => mockRepository.getChats(),
      ).thenAnswer((_) async => throw failure);

      final notifier = container.read(chatsProvider.notifier);

      // Вызываем метод - он установит AsyncValue.error
      await notifier.loadChats();

      // Проверяем состояние - AsyncValue.error устанавливается синхронно внутри catch
      final state = container.read(chatsProvider);

      expect(
        state.hasError,
        true,
        reason: 'State should have error after Failure',
      );
      expect(state.error, isA<NetworkFailure>());
      verify(() => mockRepository.getChats()).called(1);
    });
  });

  group('MessagesNotifier', () {
    const chatId = 'chat1';

    test('build загружает сообщения сразу', () async {
      final messages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: true,
        ),
      ];

      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => messages);

      final state = await container.read(messagesProvider(chatId).future);

      expect(state.messages, equals(messages));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.isSending, false);
      verify(() => mockRepository.getMessages(chatId)).called(1);
    });

    test('loadMessages успешно загружает сообщения', () async {
      final initialMessages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: true,
        ),
      ];

      final updatedMessages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: true,
        ),
        Message(
          id: '2',
          chatId: chatId,
          text: 'Как дела?',
          sentAt: DateTime(2024, 1, 2),
          isFromSpecialist: false,
          isRead: false,
        ),
      ];

      // build уже загрузил сообщения один раз
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => initialMessages);

      // Ждем завершения build
      await container.read(messagesProvider(chatId).future);

      // Теперь настраиваем для loadMessages
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => updatedMessages);

      final notifier = container.read(messagesProvider(chatId).notifier);
      await notifier.loadMessages();

      final state = await container.read(messagesProvider(chatId).future);

      expect(state.messages, equals(updatedMessages));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      // build вызвал getMessages один раз, loadMessages еще раз
      verify(() => mockRepository.getMessages(chatId)).called(greaterThanOrEqualTo(1));
    });

    test('sendMessage успешно отправляет сообщение', () async {
      final existingMessages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: true,
        ),
      ];

      final updatedMessages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: true,
        ),
        Message(
          id: '2',
          chatId: chatId,
          text: 'Новое сообщение',
          sentAt: DateTime(2024, 1, 2),
          isFromSpecialist: false,
          isRead: false,
        ),
      ];

      // build уже загрузил сообщения
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => existingMessages);
      
      // Ждем завершения build
      await container.read(messagesProvider(chatId).future);

      final notifier = container.read(messagesProvider(chatId).notifier);

      final newMessage = Message(
        id: '2',
        chatId: chatId,
        text: 'Новое сообщение',
        sentAt: DateTime(2024, 1, 2),
        isFromSpecialist: false,
        isRead: false,
      );

      when(
        () => mockRepository.sendMessage(chatId, 'Новое сообщение'),
      ).thenAnswer((_) async => newMessage);
      
      // После отправки сообщения вызывается loadMessages, который вернет обновленный список
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => updatedMessages);

      await notifier.sendMessage('Новое сообщение');

      final state = await container.read(messagesProvider(chatId).future);

      expect(state.messages.length, 2);
      expect(state.messages.last.text, equals('Новое сообщение'));
      expect(state.isSending, false);
      verify(
        () => mockRepository.sendMessage(chatId, 'Новое сообщение'),
      ).called(1);
    });

    test('sendMessage игнорирует пустые сообщения', () async {
      final notifier = container.read(messagesProvider(chatId).notifier);

      await notifier.sendMessage('');
      await notifier.sendMessage('   ');

      verifyNever(() => mockRepository.sendMessage(any(), any()));
    });

    test('markAsRead успешно отмечает сообщения как прочитанные', () async {
      final messages = [
        Message(
          id: '1',
          chatId: chatId,
          text: 'Привет',
          sentAt: DateTime(2024, 1, 1),
          isFromSpecialist: true,
          isRead: false,
        ),
      ];

      // build уже загрузил сообщения
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => messages);
      
      // Ждем завершения build
      await container.read(messagesProvider(chatId).future);

      when(
        () => mockRepository.markMessagesAsRead(chatId),
      ).thenAnswer((_) async {});
      
      // После markAsRead вызывается loadMessages
      when(
        () => mockRepository.getMessages(chatId),
      ).thenAnswer((_) async => messages);

      final notifier = container.read(messagesProvider(chatId).notifier);
      await notifier.markAsRead();

      verify(() => mockRepository.markMessagesAsRead(chatId)).called(1);
      // build вызвал getMessages один раз, markAsRead -> loadMessages еще раз
      verify(() => mockRepository.getMessages(chatId)).called(greaterThanOrEqualTo(1));
    });
  });
}
