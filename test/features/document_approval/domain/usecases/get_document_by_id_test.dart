import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/usecases/get_document_by_id.dart';

class MockDocumentRepository extends Mock implements DocumentRepository {}

void main() {
  late GetDocumentById useCase;
  late MockDocumentRepository mockRepository;

  setUp(() {
    mockRepository = MockDocumentRepository();
    useCase = GetDocumentById(mockRepository);
  });

  test('call возвращает документ по ID', () async {
    // Arrange
    const documentId = '1';
    final document = Document(
      id: documentId,
      projectId: 'project1',
      title: 'Документ 1',
      description: 'Описание 1',
      status: DocumentStatus.pending,
    );

    when(
      () => mockRepository.getDocumentById(documentId),
    ).thenAnswer((_) async => document);

    // Act
    final result = await useCase.call(documentId);

    // Assert
    expect(result, equals(document));
    expect(result.id, equals(documentId));
    verify(() => mockRepository.getDocumentById(documentId)).called(1);
  });

  test('call пробрасывает исключения из репозитория', () async {
    // Arrange
    const documentId = '1';
    final failure = ServerFailure('Ошибка сервера');
    when(
      () => mockRepository.getDocumentById(documentId),
    ).thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(() => useCase.call(documentId), throwsA(isA<ServerFailure>()));
    verify(() => mockRepository.getDocumentById(documentId)).called(1);
  });
}
