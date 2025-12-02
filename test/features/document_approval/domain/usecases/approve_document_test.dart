import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/usecases/approve_document.dart';

class MockDocumentRepository extends Mock implements DocumentRepository {}

void main() {
  late ApproveDocument useCase;
  late MockDocumentRepository mockRepository;

  setUp(() {
    mockRepository = MockDocumentRepository();
    useCase = ApproveDocument(mockRepository);
  });

  test('call успешно одобряет документ', () async {
    // Arrange
    const documentId = '1';
    when(
      () => mockRepository.approveDocument(documentId),
    ).thenAnswer((_) async {});

    // Act
    await useCase.call(documentId);

    // Assert
    verify(() => mockRepository.approveDocument(documentId)).called(1);
  });

  test('call пробрасывает исключения из репозитория', () async {
    // Arrange
    const documentId = '1';
    final failure = ServerFailure('Ошибка сервера');
    when(
      () => mockRepository.approveDocument(documentId),
    ).thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(() => useCase.call(documentId), throwsA(isA<ServerFailure>()));
    verify(() => mockRepository.approveDocument(documentId)).called(1);
  });
}
