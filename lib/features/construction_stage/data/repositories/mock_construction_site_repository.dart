import 'package:flutter/foundation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/models/construction_site_model.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/construction_object_repository.dart';

/// Моковая реализация репозитория строительной площадки
class MockConstructionSiteRepository implements ConstructionSiteRepository {
  final ConstructionObjectRepository _constructionObjectRepository;

  MockConstructionSiteRepository({
    required ConstructionObjectRepository constructionObjectRepository,
  }) : _constructionObjectRepository = constructionObjectRepository;

  @override
  Future<ConstructionSite> getConstructionSiteByObjectId(
    String objectId,
  ) async {
    debugPrint(
      '=== MockConstructionSiteRepository.getConstructionSiteByObjectId ===',
    );
    debugPrint('objectId: $objectId');
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем объект строительства по objectId
    final object = await _constructionObjectRepository.getObjectById(objectId);

    // Вычисляем прогресс на основе этапов (все этапы должны быть completed для 100%)
    final completedStages = object.stages.where(
      (stage) => stage.status == StageStatus.completed,
    ).length;
    final progress = object.stages.isEmpty
        ? 0.0
        : completedStages / object.stages.length;

    // Создаем камеры для объекта (моковые данные)
    final cameras = [
      {
        'id': 'cam1_$objectId',
        'name': 'Камера 1 - Главный вход',
        'description': 'Обзор главного входа и фасада',
        'streamUrl': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        'isActive': true,
        'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+1',
      },
      {
        'id': 'cam2_$objectId',
        'name': 'Камера 2 - Стройплощадка',
        'description': 'Обзор строительной площадки',
        'streamUrl':
            'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
        'isActive': true,
        'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+2',
      },
      {
        'id': 'cam3_$objectId',
        'name': 'Камера 3 - Задний двор',
        'description': 'Обзор заднего двора',
        'streamUrl':
            'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
        'isActive': false,
        'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+3',
      },
    ];

    final mockData = {
      'id': objectId,
      'projectId': object.projectId,
      'projectName': object.name,
      'address': object.address,
      'cameras': cameras,
      'startDate': '2024-01-15T00:00:00Z',
      'expectedCompletionDate': '2024-12-31T00:00:00Z',
      'progress': progress,
    };

    final site = ConstructionSiteModel.fromJson(mockData).toEntity();
    debugPrint('=== MockConstructionSiteRepository: возвращаем площадку ===');
    debugPrint('ID: ${site.id}');
    debugPrint('Название: ${site.projectName}');
    debugPrint('Адрес: ${site.address}');
    debugPrint('Прогресс: ${(progress * 100).toStringAsFixed(0)}%');
    debugPrint('Камер: ${site.cameras.length}');
    for (var camera in site.cameras) {
      debugPrint(
        '  - ${camera.name}: ${camera.isActive ? "активна" : "неактивна"}',
      );
    }
    return site;
  }

  @override
  @Deprecated('Используйте getConstructionSiteByObjectId')
  Future<ConstructionSite> getConstructionSiteByProjectId(
    String projectId,
  ) async {
    debugPrint(
      '=== MockConstructionSiteRepository.getConstructionSiteByProjectId (deprecated) ===',
    );
    debugPrint('projectId: $projectId');
    
    // Пытаемся найти объект по projectId
    final objects = await _constructionObjectRepository.getObjects();
    final object = objects.firstWhere(
      (obj) => obj.projectId == projectId,
      orElse: () => throw UnknownFailure(
        'Объект строительства для проекта $projectId не найден',
      ),
    );
    
    return getConstructionSiteByObjectId(object.id);
  }

  @override
  Future<List<Camera>> getCameras(String siteId) async {
    debugPrint('=== MockConstructionSiteRepository.getCameras ===');
    debugPrint('siteId: $siteId');
    await Future.delayed(const Duration(milliseconds: 500));

    // siteId теперь это objectId
    final site = await getConstructionSiteByObjectId(siteId);
    return site.cameras;
  }

  @override
  Future<Camera> getCameraById(String siteId, String cameraId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final cameras = await getCameras(siteId);
    try {
      return cameras.firstWhere((c) => c.id == cameraId);
    } catch (e) {
      throw UnknownFailure('Моковая камера с ID $cameraId не найдена');
    }
  }
}
