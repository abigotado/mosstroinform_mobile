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

  @override
  Future<void> startConstruction(String projectId, String address) async {
    try {
      // TODO: Добавить метод в IProjectRemoteDataSource
      // await remoteDataSource.startConstruction(projectId, address);
      throw UnimplementedError('startConstruction not implemented');
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при начале строительства: $e');
    }
  }

  @override
  Future<List<Project>> getRequestedProjects() async {
    try {
      // В реальной реализации бэкенд должен иметь отдельный эндпоинт для запрошенных проектов
      // TODO: Добавить отдельный эндпоинт в IProjectRemoteDataSource
      // Пока возвращаем пустой список, так как в реальной реализации нужен отдельный эндпоинт
      return [];
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении запрошенных проектов: $e');
    }
  }

  @override
  Future<bool> isProjectRequested(String projectId) async {
    try {
      // В реальной реализации бэкенд должен вернуть статус в самом проекте
      // TODO: Добавить поле status в Project entity для проверки статуса
      // Пока возвращаем false, так как в реальной реализации нужен отдельный эндпоинт
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при проверке статуса проекта: $e');
    }
  }
}
