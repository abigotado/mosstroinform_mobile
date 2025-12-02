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
          'streamUrl': 'https://example.com/stream1',
          'isActive': true,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+1',
        },
        {
          'id': 'cam2',
          'name': 'Камера 2 - Стройплощадка',
          'description': 'Обзор строительной площадки',
          'streamUrl': 'https://example.com/stream2',
          'isActive': true,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+2',
        },
        {
          'id': 'cam3',
          'name': 'Камера 3 - Задний двор',
          'description': 'Обзор заднего двора',
          'streamUrl': 'https://example.com/stream3',
          'isActive': false,
          'thumbnailUrl': 'https://via.placeholder.com/320x240?text=Камера+3',
        },
      ],
      'startDate': '2024-01-15T00:00:00Z',
      'expectedCompletionDate': '2024-12-31T00:00:00Z',
      'progress': 0.45,
    };

    return ConstructionSiteModel.fromJson(mockData).toEntity();
  }

  @override
  Future<List<Camera>> getCameras(String siteId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final site = await getConstructionSiteByProjectId('1');
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

