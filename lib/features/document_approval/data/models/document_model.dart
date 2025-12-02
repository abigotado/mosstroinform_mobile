import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

/// Модель документа для работы с API
@freezed
abstract class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    required String id,
    required String projectId,
    required String title,
    required String description,
    String? fileUrl,
    @JsonKey(name: 'status') @Default('pending') String statusString,
    DateTime? submittedAt,
    DateTime? approvedAt,
    String? rejectionReason,
  }) = _DocumentModel;

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension DocumentModelExtension on DocumentModel {
  Document toEntity() {
    return Document(
      id: id,
      projectId: projectId,
      title: title,
      description: description,
      fileUrl: fileUrl,
      status: _parseStatus(statusString),
      submittedAt: submittedAt,
      approvedAt: approvedAt,
      rejectionReason: rejectionReason,
    );
  }

  DocumentStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return DocumentStatus.pending;
      case 'under_review':
      case 'underreview':
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

/// Расширение для конвертации сущности в модель
extension DocumentExtension on Document {
  String get statusString {
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
}
