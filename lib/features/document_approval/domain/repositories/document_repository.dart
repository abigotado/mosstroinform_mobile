import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';

/// Интерфейс репозитория для работы с документами
abstract class DocumentRepository {
  /// Получить список всех документов
  Future<List<Document>> getDocuments();

  /// Получить документы для проекта
  Future<List<Document>> getDocumentsByProjectId(String projectId);

  /// Получить документ по ID
  Future<Document> getDocumentById(String id);

  /// Одобрить документ
  Future<void> approveDocument(String documentId);

  /// Отклонить документ
  Future<void> rejectDocument(String documentId, String reason);
}
