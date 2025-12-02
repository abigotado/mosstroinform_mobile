import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/mock_state_providers.dart';
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

    test('getProjectById выбрасывает UnknownFailure для несуществующего ID', () async {
      expect(
        () => repository.getProjectById('non-existent-id'),
        throwsA(isA<UnknownFailure>()),
      );
    });

    test('requestConstruction обновляет статус первого этапа на inProgress', () async {
      // Находим проект с этапами
      final projects = await repository.getProjects();
      
      // Ищем проект с этапами в статусе pending
      Project? projectWithPendingStages;
      try {
        projectWithPendingStages = projects.firstWhere(
          (p) => p.stages.isNotEmpty &&
              p.stages.every((s) => s.status == StageStatus.pending),
        );
      } catch (e) {
        // Если нет проектов с pending этапами, пропускаем тест
        return;
      }

      await repository.requestConstruction(projectWithPendingStages.id);

      final updatedProject =
          await repository.getProjectById(projectWithPendingStages.id);

      expect(updatedProject.stages.first.status, equals(StageStatus.inProgress));
    });

    test('requestConstruction не изменяет проект, если этапы уже не в pending', () async {
      // Находим проект с этапами в статусе pending
      final projects = await repository.getProjects();
      
      Project? projectWithPendingStages;
      try {
        projectWithPendingStages = projects.firstWhere(
          (p) => p.stages.isNotEmpty &&
              p.stages.every((s) => s.status == StageStatus.pending),
        );
      } catch (e) {
        // Если нет проектов с pending этапами, пропускаем тест
        return;
      }

      // Сначала отправляем запрос
      await repository.requestConstruction(projectWithPendingStages.id);
      final projectAfterFirstRequest =
          await repository.getProjectById(projectWithPendingStages.id);

      // Пытаемся отправить запрос повторно
      await repository.requestConstruction(projectWithPendingStages.id);
      final projectAfterSecondRequest =
          await repository.getProjectById(projectWithPendingStages.id);

      // Статус не должен измениться (оба раза должен быть inProgress)
      expect(
        projectAfterSecondRequest.stages.first.status,
        equals(projectAfterFirstRequest.stages.first.status),
      );
    });
  });
}

