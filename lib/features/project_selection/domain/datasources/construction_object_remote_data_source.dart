import 'package:mosstroinform_mobile/features/project_selection/data/models/construction_object_model.dart';

/// Интерфейс удалённого источника данных для объектов строительства
/// Используется в domain слое для абстракции от реализации
abstract class IConstructionObjectRemoteDataSource {
  /// Получить список всех объектов пользователя
  /// GET /construction-objects
  Future<List<ConstructionObjectModel>> getObjects();

  /// Получить объект по ID
  /// GET /construction-objects/{objectId}
  Future<ConstructionObjectModel> getObjectById(String objectId);

  /// Завершить строительство объекта
  /// POST /construction-objects/{objectId}/complete
  Future<void> completeConstruction(String objectId);

  /// Обновить статус подписания документов для объекта
  /// PATCH /construction-objects/by-project/{projectId}/documents-status
  /// Body: {"allDocumentsSigned": true}
  Future<void> updateDocumentsSignedStatus(String projectId, Map<String, dynamic> body);
}

