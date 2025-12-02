import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Use case для получения документа по ID
class GetDocumentById {
  final DocumentRepository repository;

  GetDocumentById(this.repository);

  Future<Document> call(String id) async {
    return await repository.getDocumentById(id);
  }
}

