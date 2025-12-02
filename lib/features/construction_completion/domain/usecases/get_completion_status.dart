import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Use case для получения статуса завершения строительства
class GetCompletionStatus {
  final FinalDocumentRepository repository;

  GetCompletionStatus(this.repository);

  Future<ConstructionCompletionStatus> call(String projectId) async {
    try {
      return await repository.getCompletionStatus(projectId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении статуса завершения: $e');
    }
  }
}
