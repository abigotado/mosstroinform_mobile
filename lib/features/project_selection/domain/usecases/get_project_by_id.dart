import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Use case для получения проекта по ID
class GetProjectById {
  final ProjectRepository repository;

  GetProjectById(this.repository);

  Future<Project> call(String id) async {
    try {
      return await repository.getProjectById(id);
    } catch (e) {
      throw UnknownFailure('Ошибка при получении проекта: $e');
    }
  }
}

