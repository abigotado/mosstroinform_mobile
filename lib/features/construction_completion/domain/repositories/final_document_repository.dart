import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';

/// Интерфейс репозитория для работы с финальными документами
abstract class FinalDocumentRepository {
  /// Получить статус завершения строительства по ID проекта
  Future<ConstructionCompletionStatus> getCompletionStatus(String projectId);

  /// Получить список всех финальных документов
  Future<List<FinalDocument>> getFinalDocuments(String projectId);

  /// Получить финальный документ по ID
  Future<FinalDocument> getFinalDocumentById(
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
