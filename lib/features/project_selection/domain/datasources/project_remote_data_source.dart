import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';

/// Интерфейс удалённого источника данных для проектов
/// Используется в domain слое для абстракции от реализации
abstract class IProjectRemoteDataSource {
  /// Получить список всех проектов
  Future<List<ProjectModel>> getProjects();

  /// Получить проект по ID
  Future<ProjectModel> getProjectById(String id);

  /// Отправить запрос на строительство проекта
  Future<void> requestConstruction(String projectId);
}

