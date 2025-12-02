import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/usecases/reject_document.dart';

class MockDocumentRepository extends Mock implements DocumentRepository {}

void main() {
  late RejectDocument useCase;
  late MockDocumentRepository mockRepository;

  setUp(() {
    mockRepository = MockDocumentRepository();
    useCase = RejectDocument(mockRepository);
  });

  test('call успешно отклоняет документ', () async {
    // Arrange
    const documentId = '1';
    const reason = 'Причина отклонения';
    when(() => mockRepository.rejectDocument(documentId, reason))
        .thenAnswer((_) async {});

    // Act
    await useCase.call(documentId, reason);

    // Assert
    verify(() => mockRepository.rejectDocument(documentId, reason)).called(1);
  });

  test('call пробрасывает исключения из репозитория', () async {
    // Arrange
    const documentId = '1';
    const reason = 'Причина отклонения';
    final failure = ServerFailure('Ошибка сервера');
    when(() => mockRepository.rejectDocument(documentId, reason))
        .thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(
      () => useCase.call(documentId, reason),
      throwsA(isA<ServerFailure>()),
    );
    verify(() => mockRepository.rejectDocument(documentId, reason)).called(1);
  });
}

