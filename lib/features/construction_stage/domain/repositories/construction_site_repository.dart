import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';

/// Интерфейс репозитория для работы со строительной площадкой
abstract class ConstructionSiteRepository {
  /// Получить информацию о строительной площадке по ID проекта
  Future<ConstructionSite> getConstructionSiteByProjectId(String projectId);

  /// Получить список всех камер на стройке
  Future<List<Camera>> getCameras(String siteId);

  /// Получить информацию о конкретной камере
  Future<Camera> getCameraById(String siteId, String cameraId);
}

