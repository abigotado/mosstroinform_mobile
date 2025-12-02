import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/usecases/get_documents.dart';

class MockDocumentRepository extends Mock implements DocumentRepository {}

void main() {
  late GetDocuments useCase;
  late MockDocumentRepository mockRepository;

  setUp(() {
    mockRepository = MockDocumentRepository();
    useCase = GetDocuments(mockRepository);
  });

  test('call возвращает список документов', () async {
    // Arrange
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

    when(
      () => mockRepository.getDocuments(),
    ).thenAnswer((_) async => documents);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, equals(documents));
    expect(result.length, equals(2));
    verify(() => mockRepository.getDocuments()).called(1);
  });

  test('call пробрасывает исключения из репозитория', () async {
    // Arrange
    final failure = NetworkFailure('Ошибка сети');
    when(
      () => mockRepository.getDocuments(),
    ).thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(() => useCase.call(), throwsA(isA<NetworkFailure>()));
    verify(() => mockRepository.getDocuments()).called(1);
  });
}
