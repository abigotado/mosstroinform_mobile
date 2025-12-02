import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/providers/document_repository_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/notifier/document_notifier.dart';

class MockDocumentRepository extends Mock implements DocumentRepository {}

void main() {
  late MockDocumentRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockDocumentRepository();
    container = ProviderContainer(
      overrides: [
        documentRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('DocumentsNotifier', () {
    test('build возвращает начальное состояние с пустым списком', () async {
      final state = await container.read(documentsNotifierProvider.future);

      expect(state, isEmpty);
    });

    test('loadDocuments успешно загружает документы', () async {
      final documents = [
        Document(
          id: '1',
          projectId: 'project1',
          title: 'Документ 1',
          description: 'Описание 1',
          status: DocumentStatus.pending,
        ),
        Document(
          id: '2',
          projectId: 'project1',
          title: 'Документ 2',
          description: 'Описание 2',
          status: DocumentStatus.approved,
        ),
      ];

      when(() => mockRepository.getDocuments()).thenAnswer((_) async => documents);

      final notifier = container.read(documentsNotifierProvider.notifier);
      await notifier.loadDocuments();

      final state = await container.read(documentsNotifierProvider.future);

      expect(state, equals(documents));
      verify(() => mockRepository.getDocuments()).called(1);
    });

    test('loadDocuments обрабатывает Failure', () async {
      final failure = NetworkFailure('Ошибка сети');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(() => mockRepository.getDocuments()).thenAnswer((_) async => throw failure);

      final notifier = container.read(documentsNotifierProvider.notifier);
      
      // Вызываем метод - он установит AsyncValue.error
      await notifier.loadDocuments();

      // Проверяем состояние - AsyncValue.error устанавливается синхронно внутри catch
      final state = container.read(documentsNotifierProvider);

      expect(state.hasError, true, reason: 'State should have error after Failure');
      expect(state.error, isA<NetworkFailure>());
      verify(() => mockRepository.getDocuments()).called(1);
    });
  });

  group('DocumentNotifier', () {
    test('build возвращает начальное состояние null', () async {
      final state = await container.read(documentNotifierProvider('1').future);

      expect(state, isNull);
    });

    test('loadDocument успешно загружает документ', () async {
      final document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Документ 1',
        description: 'Описание 1',
        status: DocumentStatus.pending,
      );

      when(() => mockRepository.getDocumentById('1')).thenAnswer((_) async => document);

      final notifier = container.read(documentNotifierProvider('1').notifier);
      await notifier.loadDocument('1');

      final state = await container.read(documentNotifierProvider('1').future);

      expect(state, equals(document));
      verify(() => mockRepository.getDocumentById('1')).called(1);
    });

    test('approveDocument успешно одобряет документ', () async {
      final document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Документ 1',
        description: 'Описание 1',
        status: DocumentStatus.approved,
      );

      when(() => mockRepository.approveDocument('1')).thenAnswer((_) async {});
      when(() => mockRepository.getDocumentById('1')).thenAnswer((_) async => document);

      final notifier = container.read(documentNotifierProvider('1').notifier);
      await notifier.approveDocument('1');

      verify(() => mockRepository.approveDocument('1')).called(1);
      verify(() => mockRepository.getDocumentById('1')).called(1);
    });

    test('rejectDocument успешно отклоняет документ', () async {
      final document = Document(
        id: '1',
        projectId: 'project1',
        title: 'Документ 1',
        description: 'Описание 1',
        status: DocumentStatus.rejected,
        rejectionReason: 'Причина отклонения',
      );

      when(() => mockRepository.rejectDocument('1', 'Причина отклонения'))
          .thenAnswer((_) async {});
      when(() => mockRepository.getDocumentById('1')).thenAnswer((_) async => document);

      final notifier = container.read(documentNotifierProvider('1').notifier);
      await notifier.rejectDocument('1', 'Причина отклонения');

      verify(() => mockRepository.rejectDocument('1', 'Причина отклонения')).called(1);
      verify(() => mockRepository.getDocumentById('1')).called(1);
    });

    test('approveDocument обрабатывает Failure', () async {
      final failure = ServerFailure('Ошибка сервера');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(() => mockRepository.approveDocument('1'))
          .thenAnswer((_) async => throw failure);

      final notifier = container.read(documentNotifierProvider('1').notifier);
      
      // Вызываем метод - он установит AsyncValue.error
      await notifier.approveDocument('1');

      // Проверяем состояние - AsyncValue.error устанавливается синхронно внутри catch
      final state = container.read(documentNotifierProvider('1'));

      expect(state.hasError, true, reason: 'State should have error after Failure');
      expect(state.error, isA<ServerFailure>());
      verify(() => mockRepository.approveDocument('1')).called(1);
      verifyNever(() => mockRepository.getDocumentById(any()));
    });
  });
}

