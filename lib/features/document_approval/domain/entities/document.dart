/// Сущность документа в доменном слое
class Document {
  final String id;
  final String projectId; // ID проекта, к которому относится документ
  final String title;
  final String description;
  final String? fileUrl;
  final DocumentStatus status;
  final DateTime? submittedAt;
  final DateTime? approvedAt;
  final String? rejectionReason;

  const Document({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.fileUrl,
    required this.status,
    this.submittedAt,
    this.approvedAt,
    this.rejectionReason,
  });
}

/// Статус документа
enum DocumentStatus {
  /// Документ ожидает просмотра
  pending,
  /// Документ на согласовании
  underReview,
  /// Документ одобрен
  approved,
  /// Документ отклонён
  rejected,
}

