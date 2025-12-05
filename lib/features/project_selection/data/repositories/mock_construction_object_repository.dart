import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
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
}
