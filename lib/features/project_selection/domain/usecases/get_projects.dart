import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Use case для получения списка проектов
class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<List<Project>> call() async {
    try {
      return await repository.getProjects();
    } catch (e) {
      throw UnknownFailure('Ошибка при получении списка проектов: $e');
    }
  }
}

