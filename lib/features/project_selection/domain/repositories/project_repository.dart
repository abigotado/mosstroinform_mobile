import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

/// Интерфейс репозитория для работы с проектами
abstract class ProjectRepository {
  /// Получить список всех проектов
  Future<List<Project>> getProjects();

  /// Получить проект по ID
  Future<Project> getProjectById(String id);

  /// Отправить запрос на строительство проекта
  Future<void> requestConstruction(String projectId);
}

