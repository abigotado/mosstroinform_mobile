import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';

/// Интерфейс репозитория для работы с объектами строительства
abstract class ConstructionObjectRepository {
  /// Получить список всех объектов пользователя
  Future<List<ConstructionObject>> getObjects();

  /// Получить объект по ID
  Future<ConstructionObject> getObjectById(String id);

  /// Получить запрошенные объекты (с хотя бы одним этапом inProgress)
  Future<List<ConstructionObject>> getRequestedObjects();

  /// Получить завершенные объекты (все этапы completed)
  Future<List<ConstructionObject>> getCompletedObjects();
}

