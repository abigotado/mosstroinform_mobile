import 'package:hive_ce/hive.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';

part 'final_document_adapter.g.dart';

/// Адаптер Hive для сущности FinalDocument
@HiveType(typeId: 4)
class FinalDocumentAdapter extends HiveObject {
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
  final String statusString; // 'pending', 'signed', 'rejected'

  @HiveField(6)
  final DateTime? submittedAt;

  @HiveField(7)
  final DateTime? signedAt;

  @HiveField(8)
  final String? signatureUrl;

  FinalDocumentAdapter({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    this.fileUrl,
    required this.statusString,
    this.submittedAt,
    this.signedAt,
    this.signatureUrl,
  });

  /// Конвертация из FinalDocument в FinalDocumentAdapter
  factory FinalDocumentAdapter.fromDocument(
    FinalDocument document,
    String projectId,
  ) {
    return FinalDocumentAdapter(
      id: document.id,
      projectId: projectId,
      title: document.title,
      description: document.description,
      fileUrl: document.fileUrl,
      statusString: _statusToString(document.status),
      submittedAt: document.submittedAt,
      signedAt: document.signedAt,
      signatureUrl: document.signatureUrl,
    );
  }

  /// Конвертация из FinalDocumentAdapter в FinalDocument
  FinalDocument toDocument() {
    return FinalDocument(
      id: id,
      title: title,
      description: description,
      fileUrl: fileUrl,
      status: _statusFromString(statusString),
      submittedAt: submittedAt,
      signedAt: signedAt,
      signatureUrl: signatureUrl,
    );
  }

  static String _statusToString(FinalDocumentStatus status) {
    switch (status) {
      case FinalDocumentStatus.pending:
        return 'pending';
      case FinalDocumentStatus.signed:
        return 'signed';
      case FinalDocumentStatus.rejected:
        return 'rejected';
    }
  }

  static FinalDocumentStatus _statusFromString(String status) {
    switch (status) {
      case 'pending':
        return FinalDocumentStatus.pending;
      case 'signed':
        return FinalDocumentStatus.signed;
      case 'rejected':
        return FinalDocumentStatus.rejected;
      default:
        return FinalDocumentStatus.pending;
    }
  }
}

