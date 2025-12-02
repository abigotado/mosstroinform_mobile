import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/usecases/get_projects.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjects useCase;
  late MockProjectRepository mockRepository;

  setUp(() {
    mockRepository = MockProjectRepository();
    useCase = GetProjects(mockRepository);
  });

  test('call возвращает список проектов', () async {
    // Arrange
    final projects = [
      Project(
        id: '1',
        name: 'Проект 1',
        address: 'Адрес 1',
        description: 'Описание 1',
        area: 100.0,
        floors: 2,
        price: 1000000,
        imageUrl: 'https://example.com/image1.jpg',
        stages: [],
      ),
      Project(
        id: '2',
        name: 'Проект 2',
        address: 'Адрес 2',
        description: 'Описание 2',
        area: 150.0,
        floors: 3,
        price: 2000000,
        imageUrl: 'https://example.com/image2.jpg',
        stages: [],
      ),
    ];

    when(() => mockRepository.getProjects()).thenAnswer((_) async => projects);

    // Act
    final result = await useCase.call();

    // Assert
    expect(result, equals(projects));
    expect(result.length, equals(2));
    verify(() => mockRepository.getProjects()).called(1);
  });

  test('call обрабатывает Failure и выбрасывает UnknownFailure', () async {
    // Arrange
    final failure = NetworkFailure('Ошибка сети');
    when(
      () => mockRepository.getProjects(),
    ).thenAnswer((_) async => throw failure);

    // Act & Assert
    expect(() => useCase.call(), throwsA(isA<UnknownFailure>()));
    verify(() => mockRepository.getProjects()).called(1);
  });

  test('call обрабатывает неизвестные исключения', () async {
    // Arrange
    when(
      () => mockRepository.getProjects(),
    ).thenAnswer((_) async => throw Exception('Неизвестная ошибка'));

    // Act & Assert
    expect(() => useCase.call(), throwsA(isA<UnknownFailure>()));
    verify(() => mockRepository.getProjects()).called(1);
  });
}
