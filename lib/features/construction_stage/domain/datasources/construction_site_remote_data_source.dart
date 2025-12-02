import 'package:mosstroinform_mobile/features/construction_stage/data/models/construction_site_model.dart';

/// Интерфейс удалённого источника данных для строительной площадки
abstract class IConstructionSiteRemoteDataSource {
  /// Получить информацию о строительной площадке по ID проекта
  Future<ConstructionSiteModel> getConstructionSiteByProjectId(String projectId);

  /// Получить список всех камер на стройке
  Future<List<CameraModel>> getCameras(String siteId);

  /// Получить информацию о конкретной камере
  Future<CameraModel> getCameraById(String siteId, String cameraId);
}

