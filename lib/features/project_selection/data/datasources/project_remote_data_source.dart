import 'package:dio/dio.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/project_remote_data_source.dart';
import 'package:retrofit/retrofit.dart';

part 'project_remote_data_source.g.dart';

/// Удалённый источник данных для проектов (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class ProjectRemoteDataSource implements IProjectRemoteDataSource {
  factory ProjectRemoteDataSource(Dio dio, {String baseUrl}) =
      _ProjectRemoteDataSource;

  @override
  @GET('/projects')
  Future<List<ProjectModel>> getProjects({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @override
  @GET('/projects/{id}')
  Future<ProjectModel> getProjectById(@Path('id') String id);

  @override
  @POST('/projects/{id}/request')
  Future<void> requestConstruction(@Path('id') String projectId);

  @override
  @POST('/projects/{id}/start')
  Future<ProjectModel> startConstruction(
    @Path('id') String projectId,
    @Body() Map<String, dynamic> body,
  );

  @override
  @GET('/projects/requested')
  Future<List<ProjectModel>> getRequestedProjects();
}
