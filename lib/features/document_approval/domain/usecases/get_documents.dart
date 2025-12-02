import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Use case для получения списка документов
class GetDocuments {
  final DocumentRepository repository;

  GetDocuments(this.repository);

  Future<List<Document>> call() async {
    return await repository.getDocuments();
  }
}
