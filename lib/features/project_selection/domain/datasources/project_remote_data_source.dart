import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';

/// Интерфейс удалённого источника данных для проектов
/// Используется в domain слое для абстракции от реализации
abstract class IProjectRemoteDataSource {
  /// Получить список всех проектов
  Future<List<ProjectModel>> getProjects();

  /// Получить проект по ID
  Future<ProjectModel> getProjectById(String id);

  /// Отправить запрос на строительство проекта
  /// POST /projects/{projectId}/request
  Future<void> requestConstruction(String projectId);

  /// Начать строительство проекта
  /// POST /projects/{projectId}/start
  /// Body: {"address": "string"}
  /// Возвращает обновленный проект с objectId и chatId
  Future<ProjectModel> startConstruction(String projectId, Map<String, dynamic> body);
}
