import 'package:dio/dio.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/construction_object_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/construction_object_remote_data_source.dart';
import 'package:retrofit/retrofit.dart';

part 'construction_object_remote_data_source.g.dart';

/// Удалённый источник данных для объектов строительства (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class ConstructionObjectRemoteDataSource
    implements IConstructionObjectRemoteDataSource {
  factory ConstructionObjectRemoteDataSource(Dio dio, {String baseUrl}) =
      _ConstructionObjectRemoteDataSource;

  @override
  @GET('/construction-objects')
  Future<List<ConstructionObjectModel>> getObjects();

  @override
  @GET('/construction-objects/{objectId}')
  Future<ConstructionObjectModel> getObjectById(
    @Path('objectId') String objectId,
  );

  @override
  @POST('/construction-objects/{objectId}/complete')
  Future<void> completeConstruction(@Path('objectId') String objectId);

  @override
  @PATCH('/construction-objects/by-project/{projectId}/documents-status')
  Future<void> updateDocumentsSignedStatus(
    @Path('projectId') String projectId,
    @Body() Map<String, dynamic> body,
  );
}

