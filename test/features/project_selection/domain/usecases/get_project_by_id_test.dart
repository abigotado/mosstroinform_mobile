import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/usecases/get_project_by_id.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjectById useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = GetProjectById(mockRepository);
  });

  test('call возвращает проект по ID', () async {
    // Arrange
    const projectId = '1';
    final project = Project(
      id: projectId,
      name: 'Проект 1',
      description: 'Описание 1',
      area: 100.0,
      floors: 2,
      bedrooms: 3,
      bathrooms: 2,
      price: 1000000,
      imageUrl: 'https://example.com/image1.jpg',
    );

    when(
      () => mockRepository.getProjectById(projectId),
    ).thenAnswer((_) async => project);

    // Act
    final result = await useCase.call(projectId);

    // Assert
    expect(result, equals(project));
    expect(result.id, equals(projectId));
    verify(() => mockRepository.getProjectById(projectId)).called(1);
  });

  test('call обрабатывает Failure и выбрасывает UnknownFailure', () async {
    // Arrange
    const projectId = '1';
    final failure = ServerFailure('Ошибка сервера');
    when(
      () => mockRepository.getProjectById(projectId),
    ).thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(() => useCase.call(projectId), throwsA(isA<UnknownFailure>()));
    verify(() => mockRepository.getProjectById(projectId)).called(1);
  });

  test('call обрабатывает неизвестные исключения', () async {
    // Arrange
    const projectId = '1';
    when(
      () => mockRepository.getProjectById(projectId),
    ).thenAnswer((_) async => throw Exception('Неизвестная ошибка'));

    // Act & Assert
    expect(() => useCase.call(projectId), throwsA(isA<UnknownFailure>()));
    verify(() => mockRepository.getProjectById(projectId)).called(1);
  });
}
