import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

/// Интерфейс репозитория для работы с проектами
abstract class ProjectRepository {
  /// Получить список всех проектов
  /// [page] - номер страницы (начиная с 0)
  /// [limit] - количество элементов на странице
  Future<List<Project>> getProjects({int? page, int? limit});

  /// Получить проект по ID
  Future<Project> getProjectById(String id);

  /// Отправить запрос на строительство проекта
  Future<void> requestConstruction(String projectId);

  /// Начать строительство проекта с указанным адресом
  Future<void> startConstruction(String projectId, String address);

  /// Получить список запрошенных проектов
  Future<List<Project>> getRequestedProjects();

  /// Проверить, запрошен ли проект
  Future<bool> isProjectRequested(String projectId);
}
