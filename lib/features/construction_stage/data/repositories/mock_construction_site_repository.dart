import 'package:flutter/foundation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/models/construction_site_model.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

/// Моковая реализация репозитория строительной площадки
class MockConstructionSiteRepository implements ConstructionSiteRepository {
  @override
  Future<ConstructionSite> getConstructionSiteByProjectId(
    String projectId,
  ) async {
    debugPrint(
      '=== MockConstructionSiteRepository.getConstructionSiteByProjectId ===',
    );
    debugPrint('projectId: $projectId');
    await Future.delayed(const Duration(milliseconds: 500));

    final mockData = {
      'id': 'site1',
      'projectId': projectId,
      'projectName': 'Частный жилой дом',
      'address': 'ул. Лесная, 15',
      'cameras': [
        {
          'id': 'cam1',
          'name': 'Камера 1 - Главный вход',
          'description': 'Обзор главного входа и фасада',
          // Публичный HLS поток для тестирования (Big Buck Bunny)
          // HLS (HTTP Live Streaming) - стандартный формат для потокового видео
          'streamUrl': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
          'isActive': true,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+1',
        },
        {
          'id': 'cam2',
          'name': 'Камера 2 - Стройплощадка',
          'description': 'Обзор строительной площадки',
          // Публичный HLS поток (Apple демо)
          'streamUrl':
              'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
          'isActive': true,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+2',
        },
        {
          'id': 'cam3',
          'name': 'Камера 3 - Задний двор',
          'description': 'Обзор заднего двора',
          // Альтернативный HLS поток (Unified Streaming демо)
          'streamUrl':
              'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8',
          'isActive': false,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+3',
        },
      ],
      'startDate': '2024-01-15T00:00:00Z',
      'expectedCompletionDate': '2024-12-31T00:00:00Z',
      'progress': 0.45,
    };

    final site = ConstructionSiteModel.fromJson(mockData).toEntity();
    debugPrint('=== MockConstructionSiteRepository: возвращаем площадку ===');
    debugPrint('ID: ${site.id}');
    debugPrint('Название: ${site.projectName}');
    debugPrint('Камер: ${site.cameras.length}');
    for (var camera in site.cameras) {
      debugPrint(
        '  - ${camera.name}: ${camera.isActive ? "активна" : "неактивна"}',
      );
    }
    return site;
  }

  @override
  Future<List<Camera>> getCameras(String siteId) async {
    debugPrint('=== MockConstructionSiteRepository.getCameras ===');
    debugPrint('siteId: $siteId');
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем projectId из siteId (siteId обычно совпадает с projectId в моках)
    // Или можно извлечь projectId из siteId, если они связаны
    // Для моков используем siteId напрямую, так как в моках siteId = projectId
    final site = await getConstructionSiteByProjectId(siteId);
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
