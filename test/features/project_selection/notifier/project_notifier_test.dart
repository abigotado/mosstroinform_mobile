import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late MockProjectRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockProjectRepository();
    container = ProviderContainer(
      overrides: [projectRepositoryProvider.overrideWithValue(mockRepository)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ProjectsNotifier', () {
    test('build возвращает начальное состояние с пустым списком', () async {
      final state = await container.read(projectsProvider.future);

      expect(state.projects, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadProjects успешно загружает проекты', () async {
      final projects = [
        Project(
          id: '1',
          name: 'Проект 1',
          description: 'Описание 1',
          area: 100.0,
          floors: 2,
          bedrooms: 3,
          bathrooms: 2,
          price: 1000000,
        ),
        Project(
          id: '2',
          name: 'Проект 2',
          description: 'Описание 2',
          area: 150.0,
          floors: 3,
          bedrooms: 4,
          bathrooms: 3,
          price: 2000000,
        ),
      ];

      when(
        () => mockRepository.getProjects(),
      ).thenAnswer((_) async => projects);

      final notifier = container.read(projectsProvider.notifier);
      await notifier.loadProjects();

      final state = await container.read(projectsProvider.future);

      expect(state.projects, equals(projects));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      verify(() => mockRepository.getProjects()).called(1);
    });

    test('loadProjects обрабатывает Failure', () async {
      final failure = NetworkFailure('Ошибка сети');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(
        () => mockRepository.getProjects(),
      ).thenAnswer((_) async => throw failure);

      final notifier = container.read(projectsProvider.notifier);
      await notifier.loadProjects();

      // ProjectsNotifier обрабатывает ошибки через AsyncValue.data с ошибкой в состоянии
      // Состояние обновляется синхронно внутри метода
      final asyncValue = container.read(projectsProvider);
      expect(asyncValue.hasValue, true);
      final state = asyncValue.value!;
      expect(state.projects, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNotNull);
      expect(state.error, isA<NetworkFailure>());
      verify(() => mockRepository.getProjects()).called(1);
    });

    test('loadProjects обрабатывает неизвестные ошибки', () async {
      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(
        () => mockRepository.getProjects(),
      ).thenAnswer((_) async => throw Exception('Неизвестная ошибка'));

      final notifier = container.read(projectsProvider.notifier);
      await notifier.loadProjects();

      // ProjectsNotifier обрабатывает ошибки через AsyncValue.data с ошибкой в состоянии
      // Состояние обновляется синхронно внутри метода
      final asyncValue = container.read(projectsProvider);
      expect(asyncValue.hasValue, true);
      final state = asyncValue.value!;
      expect(state.projects, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNotNull);
      expect(state.error, isA<UnknownFailure>());
      expect(state.error?.message, contains('Неизвестная ошибка'));
      verify(() => mockRepository.getProjects()).called(1);
    });
  });

  group('ProjectNotifier', () {
    test('build возвращает начальное состояние', () async {
      final state = await container.read(projectProvider.future);

      expect(state.project, isNull);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadProject успешно загружает проект', () async {
      final project = Project(
        id: '1',
        name: 'Проект 1',
        description: 'Описание 1',
        area: 100.0,
        floors: 2,
        bedrooms: 3,
        bathrooms: 2,
        price: 1000000,
      );

      when(
        () => mockRepository.getProjectById('1'),
      ).thenAnswer((_) async => project);

      final notifier = container.read(projectProvider.notifier);
      await notifier.loadProject('1');

      final state = await container.read(projectProvider.future);

      expect(state.project, equals(project));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      verify(() => mockRepository.getProjectById('1')).called(1);
    });

    test('loadProject обрабатывает Failure', () async {
      final failure = ServerFailure('Ошибка сервера');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(
        () => mockRepository.getProjectById('1'),
      ).thenAnswer((_) async => throw failure);

      final notifier = container.read(projectProvider.notifier);
      await notifier.loadProject('1');

      // ProjectNotifier обрабатывает ошибки через AsyncValue.data с ошибкой в состоянии
      // Состояние обновляется синхронно внутри метода
      final asyncValue = container.read(projectProvider);
      expect(asyncValue.hasValue, true);
      final state = asyncValue.value!;
      expect(state.project, isNull);
      expect(state.isLoading, false);
      expect(state.error, isNotNull);
      expect(state.error, isA<ServerFailure>());
      verify(() => mockRepository.getProjectById('1')).called(1);
    });

    test('requestConstruction успешно отправляет запрос', () async {
      final projects = [
        Project(
          id: '1',
          name: 'Проект 1',
          description: 'Описание 1',
          area: 100.0,
          floors: 2,
          bedrooms: 3,
          bathrooms: 2,
          price: 1000000,
        ),
      ];

      when(
        () => mockRepository.requestConstruction('1'),
      ).thenAnswer((_) async {});
      
      // getProjects вызывается несколько раз из-за пагинации и обновления списков
      when(() => mockRepository.getProjects()).thenAnswer((_) async => projects);

      final notifier = container.read(projectProvider.notifier);
      await notifier.requestConstruction('1');

      verify(() => mockRepository.requestConstruction('1')).called(1);
      // getProjects может вызываться несколько раз из-за пагинации
      verify(() => mockRepository.getProjects()).called(greaterThanOrEqualTo(1));
    });

    test('requestConstruction обрабатывает Failure', () async {
      final failure = NetworkFailure('Ошибка сети');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(
        () => mockRepository.requestConstruction('1'),
      ).thenAnswer((_) async => throw failure);

      final notifier = container.read(projectProvider.notifier);
      await notifier.requestConstruction('1');

      // ProjectNotifier обрабатывает ошибки через AsyncValue.data с ошибкой в состоянии
      // Состояние обновляется синхронно внутри метода
      final asyncValue = container.read(projectProvider);
      expect(asyncValue.hasValue, true);
      final state = asyncValue.value!;
      expect(state.error, isNotNull);
      expect(state.error, isA<NetworkFailure>());
      verify(() => mockRepository.requestConstruction('1')).called(1);
      verifyNever(() => mockRepository.getProjectById(any()));
    });
  });
}
