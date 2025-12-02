import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Моковая реализация репозитория финальных документов
class MockFinalDocumentRepository implements FinalDocumentRepository {
  final List<FinalDocument> _mockDocuments = [
    FinalDocument(
      id: 'final1',
      title: 'Акт приёмки выполненных работ',
      description: 'Финальный акт приёмки всех выполненных строительных работ',
      fileUrl: 'https://example.com/act.pdf',
      status: FinalDocumentStatus.pending,
      submittedAt: null,
      signedAt: null,
      signatureUrl: null,
    ),
    FinalDocument(
      id: 'final2',
      title: 'Гарантийное обязательство',
      description: 'Документ о гарантийных обязательствах на выполненные работы',
      fileUrl: 'https://example.com/warranty.pdf',
      status: FinalDocumentStatus.pending,
      submittedAt: null,
      signedAt: null,
      signatureUrl: null,
    ),
    FinalDocument(
      id: 'final3',
      title: 'Паспорт объекта',
      description: 'Технический паспорт построенного объекта',
      fileUrl: 'https://example.com/passport.pdf',
      status: FinalDocumentStatus.signed,
      submittedAt: DateTime.now().subtract(const Duration(days: 5)),
      signedAt: DateTime.now().subtract(const Duration(days: 2)),
      signatureUrl: 'https://example.com/signature3.png',
    ),
  ];

  @override
  Future<ConstructionCompletionStatus> getCompletionStatus(
    String projectId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final allSigned = _mockDocuments.every((doc) => doc.status == FinalDocumentStatus.signed);

    return ConstructionCompletionStatus(
      projectId: projectId,
      isCompleted: allSigned,
      completionDate: allSigned ? DateTime.now() : null,
      progress: 0.95,
      documents: _mockDocuments,
      allDocumentsSigned: allSigned,
    );
  }

  @override
  Future<List<FinalDocument>> getFinalDocuments(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDocuments;
  }

  @override
  Future<FinalDocument> getFinalDocumentById(
    String projectId,
    String documentId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockDocuments.firstWhere((doc) => doc.id == documentId);
    } catch (e) {
      throw UnknownFailure('Моковый документ с ID $documentId не найден');
    }
  }

  @override
  Future<void> signFinalDocument(String projectId, String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockDocuments.indexWhere((doc) => doc.id == documentId);
    if (index != -1) {
      _mockDocuments[index] = FinalDocument(
        id: _mockDocuments[index].id,
        title: _mockDocuments[index].title,
        description: _mockDocuments[index].description,
        fileUrl: _mockDocuments[index].fileUrl,
        status: FinalDocumentStatus.signed,
        submittedAt: _mockDocuments[index].submittedAt ?? DateTime.now(),
        signedAt: DateTime.now(),
        signatureUrl: 'https://example.com/signature$documentId.png',
      );
    } else {
      throw UnknownFailure('Моковый документ с ID $documentId не найден');
    }
  }

  @override
  Future<void> rejectFinalDocument(
    String projectId,
    String documentId,
    String reason,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // В моковой реализации просто симулируем успех
    return;
  }
}

