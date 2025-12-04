import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/mock_state_providers.dart';
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
    // Получаем список запрошенных проектов ДО await, чтобы избежать disposed ошибок
    if (!ref.mounted) {
      AppLogger.warning('MockProjectRepository.getProjects: ref disposed, возвращаем пустой список');
      return [];
    }
    final requestedProjects = ref.read(requestedProjectsStateProvider);
    
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Проверяем, что ref все еще mounted после await
    if (!ref.mounted) {
      AppLogger.warning('MockProjectRepository.getProjects: ref disposed после await, возвращаем пустой список');
      return [];
    }
    
    // Всегда используем данные напрямую из мок-данных
    final mockData = ProjectsMockData.projects;

    // Создаем проекты напрямую из мок-данных
    // НЕ фильтруем запрошенные - они остаются в списке со статусом
    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    final allProjects = models.map((model) => model.toEntity()).toList();
    
    AppLogger.info(
      'MockProjectRepository.getProjects: создано ${allProjects.length} проектов, '
      'запрошено ${requestedProjects.length}',
    );
    return allProjects;
  }

  @override
  Future<Project> getProjectById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    // Получаем проект напрямую из мок-данных, не через getProjects()
    // чтобы избежать проблем с фильтрацией
    final mockData = ProjectsMockData.projects;
    final projectData = mockData.firstWhere(
      (json) => json['id'] == id,
      orElse: () => throw UnknownFailure('Проект с ID $id не найден'),
    );
    
    final model = ProjectModel.fromJson(projectData);
    return model.toEntity();
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    // Проверяем mounted ДО await
    if (!ref.mounted) {
      AppLogger.warning('MockProjectRepository.requestConstruction: ref disposed, пропускаем запрос');
      return;
    }
    
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Добавляем проект в список запрошенных
    if (ref.mounted) {
      ref.read(requestedProjectsStateProvider.notifier).addRequestedProject(projectId);
      AppLogger.info(
        'MockProjectRepository.requestConstruction: проект $projectId добавлен в запрошенные',
      );

      // Создаем документы для проекта
      ref.read(mockDocumentsStateProvider.notifier).createDocumentsForProject(projectId);
      AppLogger.info(
        'MockProjectRepository.requestConstruction: созданы документы для проекта $projectId',
      );
    } else {
      AppLogger.warning('MockProjectRepository.requestConstruction: ref disposed после await, пропускаем добавление');
    }
    
    // Объект строительства будет создан после подписания всех документов
  }
}
