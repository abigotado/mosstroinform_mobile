import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Use case для отклонения документа
class RejectDocument {
  final DocumentRepository repository;

  RejectDocument(this.repository);

  Future<void> call(String documentId, String reason) async {
    return await repository.rejectDocument(documentId, reason);
  }
}
