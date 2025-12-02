import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';

/// Интерфейс удалённого источника данных для документов
abstract class IDocumentRemoteDataSource {
  /// Получить список всех документов
  Future<List<DocumentModel>> getDocuments();

  /// Получить документ по ID
  Future<DocumentModel> getDocumentById(String id);

  /// Одобрить документ
  Future<void> approveDocument(String documentId);

  /// Отклонить документ
  Future<void> rejectDocument(String documentId, Map<String, dynamic> body);
}

