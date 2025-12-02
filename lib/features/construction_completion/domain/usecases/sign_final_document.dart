import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Use case для подписания финального документа
class SignFinalDocument {
  final FinalDocumentRepository repository;

  SignFinalDocument(this.repository);

  Future<void> call(String projectId, String documentId) async {
    try {
      return await repository.signFinalDocument(projectId, documentId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при подписании документа: $e');
    }
  }
}
