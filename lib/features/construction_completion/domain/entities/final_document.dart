/// Сущность финального документа
class FinalDocument {
  final String id;
  final String title;
  final String description;
  final String? fileUrl;
  final FinalDocumentStatus status;
  final DateTime? submittedAt;
  final DateTime? signedAt;
  final String? signatureUrl;

  const FinalDocument({
    required this.id,
    required this.title,
    required this.description,
    this.fileUrl,
    required this.status,
    this.submittedAt,
    this.signedAt,
    this.signatureUrl,
  });
}

/// Статус финального документа
enum FinalDocumentStatus {
  /// Документ ожидает подписания
  pending,
  /// Документ подписан
  signed,
  /// Документ отклонён
  rejected,
}

/// Сущность статуса завершения строительства
class ConstructionCompletionStatus {
  final String projectId;
  final bool isCompleted;
  final DateTime? completionDate;
  final double progress; // 0.0 - 1.0
  final List<FinalDocument> documents;
  final bool allDocumentsSigned;

  const ConstructionCompletionStatus({
    required this.projectId,
    required this.isCompleted,
    this.completionDate,
    required this.progress,
    required this.documents,
    required this.allDocumentsSigned,
  });
}

