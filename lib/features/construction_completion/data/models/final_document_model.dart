import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';

part 'final_document_model.freezed.dart';
part 'final_document_model.g.dart';

/// Модель финального документа для работы с API
@freezed
abstract class FinalDocumentModel with _$FinalDocumentModel {
  const factory FinalDocumentModel({
    String? id,
    String? title,
    String? description,
    String? fileUrl,
    @Default('pending') String statusString,
    DateTime? submittedAt,
    DateTime? signedAt,
    String? signatureUrl,
  }) = _FinalDocumentModel;

  factory FinalDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$FinalDocumentModelFromJson(json);
}

/// Модель статуса завершения строительства для работы с API
class ConstructionCompletionStatusModel {
  final String? projectId;
  final bool isCompleted;
  final DateTime? completionDate;
  final double progress;
  final List<FinalDocumentModel> documents;

  const ConstructionCompletionStatusModel({
    this.projectId,
    required this.isCompleted,
    this.completionDate,
    required this.progress,
    required this.documents,
  });

  factory ConstructionCompletionStatusModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ConstructionCompletionStatusModel(
      // Проверяем оба варианта: camelCase и snake_case
      projectId: json['project_id'] as String? ?? json['projectId'] as String?,
      isCompleted:
          json['is_completed'] as bool? ??
          json['isCompleted'] as bool? ??
          false,
      completionDate: () {
        final dateStr =
            json['completion_date'] as String? ??
            json['completionDate'] as String?;
        return dateStr != null ? DateTime.parse(dateStr) : null;
      }(),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      documents:
          (json['documents'] as List<dynamic>?)
              ?.map(
                (e) => FinalDocumentModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

/// Расширение для конвертации модели в сущность
extension FinalDocumentModelExtension on FinalDocumentModel {
  FinalDocument toEntity() {
    return FinalDocument(
      id: id ?? '',
      title: title ?? '',
      description: description ?? '',
      fileUrl: fileUrl,
      status: _parseStatus(statusString),
      submittedAt: submittedAt,
      signedAt: signedAt,
      signatureUrl: signatureUrl,
    );
  }

  FinalDocumentStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
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

/// Расширение для конвертации модели статуса в сущность
extension ConstructionCompletionStatusModelExtension
    on ConstructionCompletionStatusModel {
  ConstructionCompletionStatus toEntity() {
    final allSigned = documents.every((doc) => doc.statusString == 'signed');
    return ConstructionCompletionStatus(
      projectId: projectId ?? '',
      isCompleted: isCompleted,
      completionDate: completionDate,
      progress: progress,
      documents: documents.map((doc) => doc.toEntity()).toList(),
      allDocumentsSigned: allSigned,
    );
  }
}

/// Расширение для конвертации сущности в строку статуса
extension FinalDocumentExtension on FinalDocument {
  String get statusString {
    switch (status) {
      case FinalDocumentStatus.pending:
        return 'pending';
      case FinalDocumentStatus.signed:
        return 'signed';
      case FinalDocumentStatus.rejected:
        return 'rejected';
    }
  }
}
