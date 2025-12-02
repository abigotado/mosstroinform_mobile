import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/models/construction_site_model.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/datasources/construction_site_remote_data_source.dart';

part 'construction_site_remote_data_source.g.dart';

/// Удалённый источник данных для строительной площадки (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class ConstructionSiteRemoteDataSource
    implements IConstructionSiteRemoteDataSource {
  factory ConstructionSiteRemoteDataSource(Dio dio, {String baseUrl}) =
      _ConstructionSiteRemoteDataSource;

  @override
  @GET('/construction-sites/project/{projectId}')
  Future<ConstructionSiteModel> getConstructionSiteByProjectId(
    @Path('projectId') String projectId,
  );

  @override
  @GET('/construction-sites/{siteId}/cameras')
  Future<List<CameraModel>> getCameras(@Path('siteId') String siteId);

  @override
  @GET('/construction-sites/{siteId}/cameras/{cameraId}')
  Future<CameraModel> getCameraById(
    @Path('siteId') String siteId,
    @Path('cameraId') String cameraId,
  );
}
