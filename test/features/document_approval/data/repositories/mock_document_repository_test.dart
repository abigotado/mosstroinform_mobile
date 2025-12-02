import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/repositories/mock_document_repository.dart';

// Тестовый провайдер для создания Ref
final _testRefProvider = Provider((ref) => ref);

void main() {
  late ProviderContainer container;
  late MockDocumentRepository repository;

  setUp(() {
    container = ProviderContainer();
    // Получаем Ref через тестовый провайдер
    final ref = container.read(_testRefProvider);
    repository = MockDocumentRepository(ref);
  });

  tearDown(() {
    container.dispose();
  });

  group('MockDocumentRepository', () {
    test('getDocuments возвращает список документов из состояния', () async {
      final documents = await repository.getDocuments();

      expect(documents, isNotEmpty);
      expect(documents.first, isA<Document>());
    });

    test('getDocumentById возвращает документ по ID', () async {
      final documents = await repository.getDocuments();
      final firstDocument = documents.first;

      final document = await repository.getDocumentById(firstDocument.id);

      expect(document.id, equals(firstDocument.id));
      expect(document.title, equals(firstDocument.title));
    });

    test('getDocumentById выбрасывает UnknownFailure для несуществующего ID', () async {
      expect(
        () => repository.getDocumentById('non-existent-id'),
        throwsA(isA<UnknownFailure>()),
      );
    });

    test('approveDocument обновляет статус документа на approved', () async {
      final documents = await repository.getDocuments();
      final documentToApprove = documents.firstWhere(
        (d) => d.status != DocumentStatus.approved,
      );

      await repository.approveDocument(documentToApprove.id);

      final updatedDocument =
          await repository.getDocumentById(documentToApprove.id);

      expect(updatedDocument.status, equals(DocumentStatus.approved));
      expect(updatedDocument.approvedAt, isNotNull);
      expect(updatedDocument.rejectionReason, isNull);
    });

    test('rejectDocument обновляет статус документа на rejected', () async {
      final documents = await repository.getDocuments();
      final documentToReject = documents.firstWhere(
        (d) => d.status != DocumentStatus.rejected,
      );
      const reason = 'Причина отклонения';

      await repository.rejectDocument(documentToReject.id, reason);

      final updatedDocument =
          await repository.getDocumentById(documentToReject.id);

      expect(updatedDocument.status, equals(DocumentStatus.rejected));
      expect(updatedDocument.rejectionReason, equals(reason));
      expect(updatedDocument.approvedAt, isNull);
    });
  });
}

