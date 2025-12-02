import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/project_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Реализация репозитория проектов
class ProjectRepositoryImpl implements ProjectRepository {
  final IProjectRemoteDataSource remoteDataSource;

  ProjectRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Project>> getProjects() async {
    try {
      final models = await remoteDataSource.getProjects();
      return models.map((model) => model.toEntity()).toList();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении проектов: $e');
    }
  }

  @override
  Future<Project> getProjectById(String id) async {
    try {
      final model = await remoteDataSource.getProjectById(id);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении проекта: $e');
    }
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    try {
      await remoteDataSource.requestConstruction(projectId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отправке запроса: $e');
    }
  }
}
