import 'package:mosstroinform_mobile/features/construction_completion/data/models/final_document_model.dart';

/// Интерфейс удалённого источника данных для финальных документов
abstract class IFinalDocumentRemoteDataSource {
  /// Получить статус завершения строительства по ID проекта
  Future<ConstructionCompletionStatusModel> getCompletionStatus(
    String projectId,
  );

  /// Получить список всех финальных документов
  Future<List<FinalDocumentModel>> getFinalDocuments(String projectId);

  /// Получить финальный документ по ID
  Future<FinalDocumentModel> getFinalDocumentById(
    String projectId,
    String documentId,
  );

  /// Подписать финальный документ
  Future<void> signFinalDocument(String projectId, String documentId);

  /// Отклонить финальный документ
  Future<void> rejectFinalDocument(
    String projectId,
    String documentId,
    String reason,
  );
}
