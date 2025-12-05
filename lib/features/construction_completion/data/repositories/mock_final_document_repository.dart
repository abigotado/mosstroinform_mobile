import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Моковая реализация репозитория финальных документов
class MockFinalDocumentRepository implements FinalDocumentRepository {
  // Храним документы по projectId для каждого объекта строительства
  static final Map<String, List<FinalDocument>> _documentsByProject = {};

  /// Получить документы для проекта (создаются при первом запросе)
  List<FinalDocument> _getDocumentsForProject(String projectId) {
    if (!_documentsByProject.containsKey(projectId)) {
      _documentsByProject[projectId] = [
        FinalDocument(
          id: 'final1_$projectId',
          title: 'Акт приёмки выполненных работ',
          description: 'Финальный акт приёмки всех выполненных строительных работ',
          fileUrl: 'https://example.com/act.pdf',
          status: FinalDocumentStatus.pending,
          submittedAt: null,
          signedAt: null,
          signatureUrl: null,
        ),
        FinalDocument(
          id: 'final2_$projectId',
          title: 'Гарантийное обязательство',
          description:
              'Документ о гарантийных обязательствах на выполненные работы',
          fileUrl: 'https://example.com/warranty.pdf',
          status: FinalDocumentStatus.pending,
          submittedAt: null,
          signedAt: null,
          signatureUrl: null,
        ),
        FinalDocument(
          id: 'final3_$projectId',
          title: 'Паспорт объекта',
          description: 'Технический паспорт построенного объекта',
          fileUrl: 'https://example.com/passport.pdf',
          status: FinalDocumentStatus.pending,
          submittedAt: null,
          signedAt: null,
          signatureUrl: null,
        ),
      ];
    }
    return _documentsByProject[projectId]!;
  }

  @override
  Future<ConstructionCompletionStatus> getCompletionStatus(
    String projectId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final documents = _getDocumentsForProject(projectId);
    final allSigned = documents.every(
      (doc) => doc.status == FinalDocumentStatus.signed,
    );

    return ConstructionCompletionStatus(
      projectId: projectId,
      isCompleted: allSigned,
      completionDate: allSigned ? DateTime.now() : null,
      progress: 0.95,
      documents: documents,
      allDocumentsSigned: allSigned,
    );
  }

  @override
  Future<List<FinalDocument>> getFinalDocuments(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _getDocumentsForProject(projectId);
  }

  @override
  Future<FinalDocument> getFinalDocumentById(
    String projectId,
    String documentId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final documents = _getDocumentsForProject(projectId);
    try {
      return documents.firstWhere((doc) => doc.id == documentId);
    } catch (e) {
      throw UnknownFailure('Моковый документ с ID $documentId не найден');
    }
  }

  @override
  Future<void> signFinalDocument(String projectId, String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final documents = _getDocumentsForProject(projectId);
    final index = documents.indexWhere((doc) => doc.id == documentId);
    if (index != -1) {
      documents[index] = FinalDocument(
        id: documents[index].id,
        title: documents[index].title,
        description: documents[index].description,
        fileUrl: documents[index].fileUrl,
        status: FinalDocumentStatus.signed,
        submittedAt: documents[index].submittedAt ?? DateTime.now(),
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
