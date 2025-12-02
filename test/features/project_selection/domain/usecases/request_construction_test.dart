import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/usecases/request_construction.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late RequestConstruction useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = RequestConstruction(mockRepository);
  });

  test('call успешно отправляет запрос на строительство', () async {
    // Arrange
    const projectId = '1';
    when(() => mockRepository.requestConstruction(projectId))
        .thenAnswer((_) async {});

    // Act
    await useCase.call(projectId);

    // Assert
    verify(() => mockRepository.requestConstruction(projectId)).called(1);
  });

  test('call обрабатывает Failure и выбрасывает UnknownFailure', () async {
    // Arrange
    const projectId = '1';
    final failure = NetworkFailure('Ошибка сети');
    when(() => mockRepository.requestConstruction(projectId))
        .thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(
      () => useCase.call(projectId),
      throwsA(isA<UnknownFailure>()),
    );
    verify(() => mockRepository.requestConstruction(projectId)).called(1);
  });

  test('call обрабатывает неизвестные исключения', () async {
    // Arrange
    const projectId = '1';
    when(() => mockRepository.requestConstruction(projectId))
        .thenAnswer((_) async => throw Exception('Неизвестная ошибка'));

    // Act & Assert
    expect(
      () => useCase.call(projectId),
      throwsA(isA<UnknownFailure>()),
    );
    verify(() => mockRepository.requestConstruction(projectId)).called(1);
  });
}

