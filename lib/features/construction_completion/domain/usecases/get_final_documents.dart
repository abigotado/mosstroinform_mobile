import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Use case для получения списка финальных документов
class GetFinalDocuments {
  final FinalDocumentRepository repository;

  GetFinalDocuments(this.repository);

  Future<List<FinalDocument>> call(String projectId) async {
    try {
      return await repository.getFinalDocuments(projectId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении финальных документов: $e');
    }
  }
}

