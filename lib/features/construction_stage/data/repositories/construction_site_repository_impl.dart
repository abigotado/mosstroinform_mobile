import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/models/construction_site_model.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/datasources/construction_site_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

/// Реализация репозитория строительной площадки
class ConstructionSiteRepositoryImpl implements ConstructionSiteRepository {
  final IConstructionSiteRemoteDataSource remoteDataSource;

  ConstructionSiteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ConstructionSite> getConstructionSiteByProjectId(
    String projectId,
  ) async {
    return guard(() async {
      final model = await remoteDataSource.getConstructionSiteByProjectId(
        projectId,
      );
      return model.toEntity();
    }, methodName: 'getConstructionSiteByProjectId');
  }

  @override
  Future<List<Camera>> getCameras(String siteId) async {
    return guard(() async {
      final models = await remoteDataSource.getCameras(siteId);
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getCameras');
  }

  @override
  Future<Camera> getCameraById(String siteId, String cameraId) async {
    return guard(() async {
      final model = await remoteDataSource.getCameraById(siteId, cameraId);
      return model.toEntity();
    }, methodName: 'getCameraById');
  }
}
