import 'package:hive_ce/hive.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';

part 'document_adapter.g.dart';

/// Адаптер Hive для сущности Document
@HiveType(typeId: 1)
class DocumentAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String projectId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String? fileUrl;

  @HiveField(5)
  final String statusString; // 'pending', 'under_review', 'approved', 'rejected'

  @HiveField(6)
  final DateTime? submittedAt;

  @HiveField(7)
  final DateTime? approvedAt;

  @HiveField(8)
  final String? rejectionReason;

  DocumentAdapter({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.fileUrl,
    required this.statusString,
    this.submittedAt,
    this.approvedAt,
    this.rejectionReason,
  });

  /// Конвертация из Document в DocumentAdapter
  factory DocumentAdapter.fromDocument(Document document) {
    return DocumentAdapter(
      id: document.id,
      projectId: document.projectId,
      title: document.title,
      description: document.description,
      fileUrl: document.fileUrl,
      statusString: _statusToString(document.status),
      submittedAt: document.submittedAt,
      approvedAt: document.approvedAt,
      rejectionReason: document.rejectionReason,
    );
  }

  /// Конвертация из DocumentAdapter в Document
  Document toDocument() {
    return Document(
      id: id,
      projectId: projectId,
      title: title,
      description: description,
      fileUrl: fileUrl,
      status: _statusFromString(statusString),
      submittedAt: submittedAt,
      approvedAt: approvedAt,
      rejectionReason: rejectionReason,
    );
  }

  static String _statusToString(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return 'pending';
      case DocumentStatus.underReview:
        return 'under_review';
      case DocumentStatus.approved:
        return 'approved';
      case DocumentStatus.rejected:
        return 'rejected';
    }
  }

  static DocumentStatus _statusFromString(String status) {
    switch (status) {
      case 'pending':
        return DocumentStatus.pending;
      case 'under_review':
        return DocumentStatus.underReview;
      case 'approved':
        return DocumentStatus.approved;
      case 'rejected':
        return DocumentStatus.rejected;
      default:
        return DocumentStatus.pending;
    }
  }
}

