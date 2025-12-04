import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/mock_project_repository.dart';

// Тестовый провайдер для создания Ref
final _testRefProvider = Provider((ref) => ref);

void main() {
  late ProviderContainer container;
  late MockProjectRepository repository;

  setUp(() {
    container = ProviderContainer();
    // Получаем Ref через тестовый провайдер
    final ref = container.read(_testRefProvider);
    repository = MockProjectRepository(ref);
  });

  tearDown(() {
    container.dispose();
  });

  group('MockProjectRepository', () {
    test('getProjects возвращает список проектов из состояния', () async {
      final projects = await repository.getProjects();

      expect(projects, isNotEmpty);
      expect(projects.first, isA<Project>());
    });

    test('getProjectById возвращает проект по ID', () async {
      final projects = await repository.getProjects();
      final firstProject = projects.first;

      final project = await repository.getProjectById(firstProject.id);

      expect(project.id, equals(firstProject.id));
      expect(project.name, equals(firstProject.name));
    });

    test(
      'getProjectById выбрасывает UnknownFailure для несуществующего ID',
      () async {
        expect(
          () => repository.getProjectById('non-existent-id'),
          throwsA(isA<UnknownFailure>()),
        );
      },
    );

    test(
      'requestConstruction успешно отправляет запрос на строительство',
      () async {
        // Получаем список проектов
        final projects = await repository.getProjects();
        expect(projects, isNotEmpty);

        final projectId = projects.first.id;

        // Отправляем запрос на строительство
        await repository.requestConstruction(projectId);

        // Проверяем, что запрос выполнен без ошибок
        // (в реальной реализации здесь можно проверить, что проект помечен как запрошенный)
        expect(() => repository.requestConstruction(projectId), returnsNormally);
      },
    );

    test(
      'requestConstruction можно вызывать несколько раз для одного проекта',
      () async {
        // Получаем список проектов
        final projects = await repository.getProjects();
        expect(projects, isNotEmpty);

        final projectId = projects.first.id;

        // Отправляем запрос первый раз
        await repository.requestConstruction(projectId);

        // Отправляем запрос второй раз
        await repository.requestConstruction(projectId);

        // Оба запроса должны выполниться без ошибок
        expect(() => repository.requestConstruction(projectId), returnsNormally);
      },
    );
  });
}
