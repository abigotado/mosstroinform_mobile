import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/projects_mock_data.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/requested_projects_state.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Интерактивная моковая реализация репозитория проектов
/// Использует состояние через Riverpod для имитации реальной работы приложения
/// Состояние сбрасывается при перезапуске приложения
class MockProjectRepository implements ProjectRepository {
  final Ref ref;

  MockProjectRepository(this.ref);

  @override
  Future<List<Project>> getProjects() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем список запрошенных проектов
    final requestedProjects = ref.read(requestedProjectsStateProvider);
    
    // Всегда используем данные напрямую из мок-данных
    // Не используем провайдер здесь, так как он может быть disposed к моменту асинхронного вызова
    // Используем данные из ProjectsMockData
    final mockData = ProjectsMockData.projects;

    // Создаем проекты напрямую из мок-данных
    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    final allProjects = models.map((model) => model.toEntity()).toList();
    
    // Фильтруем проекты: исключаем запрошенные
    final availableProjects = allProjects
        .where((project) => !requestedProjects.contains(project.id))
        .toList();
    
    AppLogger.info(
      'MockProjectRepository.getProjects: создано ${allProjects.length} проектов, '
      'запрошено ${requestedProjects.length}, доступно ${availableProjects.length}',
    );
    return Future.value(availableProjects);
  }

  @override
  Future<Project> getProjectById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    final projects = await getProjects();
    try {
      final project = projects.firstWhere((p) => p.id == id);
      return project;
    } catch (e) {
      throw UnknownFailure('Проект с ID $id не найден');
    }
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Добавляем проект в список запрошенных
    if (ref.mounted) {
      ref.read(requestedProjectsStateProvider.notifier).addRequestedProject(projectId);
      AppLogger.info(
        'MockProjectRepository.requestConstruction: проект $projectId добавлен в запрошенные',
      );
    }
    
    // TODO: Реализовать создание объекта строительства через ConstructionObjectRepository
    // При запросе проекта должен создаваться объект с начальными этапами
  }
}
