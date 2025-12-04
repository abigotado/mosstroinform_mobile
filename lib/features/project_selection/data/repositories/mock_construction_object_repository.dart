import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/mock_state_providers.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/construction_object_repository.dart';

/// Интерактивная моковая реализация репозитория объектов строительства
/// Использует состояние через Riverpod для имитации реальной работы приложения
/// Состояние сбрасывается при перезапуске приложения
class MockConstructionObjectRepository implements ConstructionObjectRepository {
  final Ref ref;

  MockConstructionObjectRepository(this.ref);

  @override
  Future<List<ConstructionObject>> getObjects() async {
    if (!ref.mounted) {
      AppLogger.warning(
        'MockConstructionObjectRepository.getObjects: ref disposed, возвращаем пустой список',
      );
      return [];
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (!ref.mounted) {
      AppLogger.warning(
        'MockConstructionObjectRepository.getObjects: ref disposed после await, возвращаем пустой список',
      );
      return [];
    }

    // Получаем объекты из состояния
    final objects = ref.read(mockConstructionObjectsStateProvider);
    AppLogger.info(
      'MockConstructionObjectRepository.getObjects: получено ${objects.length} объектов',
    );
    return objects;
  }

  @override
  Future<ConstructionObject> getObjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    final objects = await getObjects();
    try {
      final object = objects.firstWhere((obj) => obj.id == id);
      return object;
    } catch (e) {
      throw UnknownFailure('Объект с ID $id не найден');
    }
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

  /// Создать объект из проекта
  /// Используется после подписания всех документов проекта
  Future<void> createObjectFromProject(
    String projectId,
    Project project,
  ) async {
    if (!ref.mounted) {
      AppLogger.warning(
        'MockConstructionObjectRepository.createObjectFromProject: ref disposed, пропускаем создание',
      );
      return;
    }

    await Future.delayed(const Duration(milliseconds: 500));

    if (!ref.mounted) {
      AppLogger.warning(
        'MockConstructionObjectRepository.createObjectFromProject: ref disposed после await, пропускаем создание',
      );
      return;
    }

    // Проверяем, не существует ли уже объект для этого проекта
    final existingObjects = ref.read(mockConstructionObjectsStateProvider);
    if (existingObjects.any((obj) => obj.projectId == projectId)) {
      AppLogger.info(
        'MockConstructionObjectRepository.createObjectFromProject: объект для проекта $projectId уже существует',
      );
      return;
    }

    // Создаем начальные этапы строительства
    final initialStages = [
      const ConstructionStage(
        id: '1',
        name: 'Подготовительные работы',
        status: StageStatus.pending,
      ),
      const ConstructionStage(
        id: '2',
        name: 'Фундамент',
        status: StageStatus.pending,
      ),
      const ConstructionStage(
        id: '3',
        name: 'Возведение стен',
        status: StageStatus.pending,
      ),
      const ConstructionStage(
        id: '4',
        name: 'Кровля',
        status: StageStatus.pending,
      ),
      const ConstructionStage(
        id: '5',
        name: 'Отделочные работы',
        status: StageStatus.pending,
      ),
    ];

    // Создаем объект из проекта
    final object = ConstructionObject.fromProject(
      project,
      'object_$projectId', // ID объекта формируется из projectId
      initialStages,
    );

    // Добавляем объект в состояние
    ref.read(mockConstructionObjectsStateProvider.notifier).addObject(object);

    AppLogger.info(
      'MockConstructionObjectRepository.createObjectFromProject: создан объект ${object.id} для проекта $projectId',
    );
  }
}

