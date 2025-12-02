import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Use case для отправки запроса на строительство
class RequestConstruction {
  final ProjectRepository repository;

  RequestConstruction(this.repository);

  Future<void> call(String projectId) async {
    try {
      await repository.requestConstruction(projectId);
    } catch (e) {
      throw UnknownFailure('Ошибка при отправке запроса на строительство: $e');
    }
  }
}

