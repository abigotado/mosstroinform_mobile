import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/project_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Реализация репозитория проектов
class ProjectRepositoryImpl implements ProjectRepository {
  final IProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Project>> getProjects({int? page, int? limit}) async {
    return guard(() async {
      final models = await remoteDataSource.getProjects(page: page, limit: limit);
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getProjects');
  }

  @override
  Future<Project> getProjectById(String id) async {
    return guard(() async {
      final model = await remoteDataSource.getProjectById(id);
      return model.toEntity();
    }, methodName: 'getProjectById');
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    return guard(() async {
      await remoteDataSource.requestConstruction(projectId);
    }, methodName: 'requestConstruction');
  }

  @override
  Future<void> startConstruction(String projectId, String address) async {
    return guard(() async {
      await remoteDataSource.startConstruction(
        projectId,
        {'address': address} as Map<String, dynamic>,
      );
    }, methodName: 'startConstruction');
  }

  @override
  Future<List<Project>> getRequestedProjects() async {
    return guard(() async {
      final models = await remoteDataSource.getRequestedProjects();
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getRequestedProjects');
  }

  @override
  Future<bool> isProjectRequested(String projectId) async {
    return guard(() async {
      // Получаем проект по ID и проверяем его статус
      final project = await remoteDataSource.getProjectById(projectId);
      return project.status == 'requested';
    }, methodName: 'isProjectRequested');
  }
}
