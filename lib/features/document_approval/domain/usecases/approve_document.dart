import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Use case для одобрения документа
class ApproveDocument {
  final DocumentRepository repository;

  ApproveDocument(this.repository);

  Future<void> call(String documentId) async {
    return await repository.approveDocument(documentId);
  }
}

