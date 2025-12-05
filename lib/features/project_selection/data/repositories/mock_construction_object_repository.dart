import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/database/adapters/construction_object_adapter.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/construction_object_repository.dart';

/// Интерактивная моковая реализация репозитория объектов строительства
/// Использует локальную базу данных Hive для имитации реальной работы приложения
/// Данные сохраняются между перезапусками приложения
class MockConstructionObjectRepository implements ConstructionObjectRepository {
  @override
  Future<List<ConstructionObject>> getObjects() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем все объекты из базы
    final objectsBox = HiveService.constructionObjectsBox;
    final objects = objectsBox.values.map((adapter) => adapter.toObject()).toList();

    AppLogger.info(
      'MockConstructionObjectRepository.getObjects: получено ${objects.length} объектов',
    );
    return objects;
  }

  @override
  Future<ConstructionObject> getObjectById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Получаем объект из базы
    final objectsBox = HiveService.constructionObjectsBox;
    final objectAdapter = objectsBox.get(id);

    if (objectAdapter == null) {
      throw UnknownFailure('Объект с ID $id не найден');
    }

    return objectAdapter.toObject();
  }

  @override
  Future<List<ConstructionObject>> getRequestedObjects() async {
    final allObjects = await getObjects();
    return allObjects.where((obj) {
      // Запрошенные объекты - это те, у которых хотя бы один этап inProgress
      return obj.stages.any((stage) => stage.status == StageStatus.inProgress);
    }).toList();
  }

  @override
  Future<List<ConstructionObject>> getCompletedObjects() async {
    final allObjects = await getObjects();
    return allObjects.where((obj) {
      // Завершенные объекты - это те, у которых все этапы completed
      return obj.stages.isNotEmpty &&
          obj.stages.every((stage) => stage.status == StageStatus.completed);
    }).toList();
  }

  @override
  Future<void> completeConstruction(String objectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем объект из базы
    final objectsBox = HiveService.constructionObjectsBox;
    final objectAdapter = objectsBox.get(objectId);

    if (objectAdapter == null) {
      throw UnknownFailure('Объект с ID $objectId не найден');
    }

    // Помечаем все этапы как completed
    final completedStages = objectAdapter.stages.map((stageAdapter) {
      return ConstructionStageAdapter(
        id: stageAdapter.id,
        name: stageAdapter.name,
        statusString: 'completed',
      );
    }).toList();

    // Создаем обновленный адаптер
    final updatedAdapter = ConstructionObjectAdapter(
      id: objectAdapter.id,
      projectId: objectAdapter.projectId,
      name: objectAdapter.name,
      address: objectAdapter.address,
      description: objectAdapter.description,
      area: objectAdapter.area,
      floors: objectAdapter.floors,
      bedrooms: objectAdapter.bedrooms,
      bathrooms: objectAdapter.bathrooms,
      price: objectAdapter.price,
      imageUrl: objectAdapter.imageUrl,
      stages: completedStages,
      chatId: objectAdapter.chatId,
      allDocumentsSigned: objectAdapter.allDocumentsSigned, // Сохраняем статус документов
      isCompleted: true, // Устанавливаем true при завершении строительства
    );

    // Сохраняем обновленный объект
    await objectsBox.put(objectId, updatedAdapter);

    AppLogger.info(
      'MockConstructionObjectRepository.completeConstruction: строительство объекта $objectId завершено',
    );
  }

  @override
  Future<void> updateDocumentsSignedStatus(
    String projectId,
    bool allDocumentsSigned,
  ) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Находим объект по projectId
    final objectsBox = HiveService.constructionObjectsBox;
    final objectAdapter = objectsBox.values.firstWhere(
      (adapter) => adapter.projectId == projectId,
      orElse: () => throw UnknownFailure(
        'Объект строительства для проекта $projectId не найден',
      ),
    );

    // Создаем обновленный адаптер с новым статусом документов
    final updatedAdapter = ConstructionObjectAdapter(
      id: objectAdapter.id,
      projectId: objectAdapter.projectId,
      name: objectAdapter.name,
      address: objectAdapter.address,
      description: objectAdapter.description,
      area: objectAdapter.area,
      floors: objectAdapter.floors,
      bedrooms: objectAdapter.bedrooms,
      bathrooms: objectAdapter.bathrooms,
      price: objectAdapter.price,
      imageUrl: objectAdapter.imageUrl,
      stages: objectAdapter.stages,
      chatId: objectAdapter.chatId,
      allDocumentsSigned: allDocumentsSigned,
    );

    // Сохраняем обновленный объект
    await objectsBox.put(objectAdapter.id, updatedAdapter);

    AppLogger.info(
      'MockConstructionObjectRepository.updateDocumentsSignedStatus: статус документов для проекта $projectId обновлен: $allDocumentsSigned',
    );
  }
}
