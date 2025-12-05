import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/database/adapters/final_document_adapter.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Моковая реализация репозитория финальных документов
class MockFinalDocumentRepository implements FinalDocumentRepository {
  /// Получить документы для проекта (загружаются из Hive или создаются при первом запросе)
  List<FinalDocument> _getDocumentsForProject(String projectId) {
    final box = HiveService.finalDocumentsBox;
    
    // Пытаемся загрузить документы из Hive
    final existingDocs = box.values
        .where((adapter) => adapter.projectId == projectId)
        .map((adapter) => adapter.toDocument())
        .toList();
    
    if (existingDocs.isNotEmpty) {
      AppLogger.info(
        'MockFinalDocumentRepository._getDocumentsForProject: загружено ${existingDocs.length} документов из Hive для проекта $projectId',
      );
      return existingDocs;
    }
    
    // Если документов нет, создаем начальные
    final initialDocs = [
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
    
    // Сохраняем в Hive
    for (final doc in initialDocs) {
      final adapter = FinalDocumentAdapter.fromDocument(doc, projectId);
      box.put(doc.id, adapter);
    }
    
    AppLogger.info(
      'MockFinalDocumentRepository._getDocumentsForProject: создано ${initialDocs.length} начальных документов для проекта $projectId',
    );
    
    return initialDocs;
  }
  
  /// Сохранить документ в Hive
  void _saveDocument(FinalDocument document, String projectId) {
    final box = HiveService.finalDocumentsBox;
    final adapter = FinalDocumentAdapter.fromDocument(document, projectId);
    box.put(document.id, adapter);
    AppLogger.info(
      'MockFinalDocumentRepository._saveDocument: документ ${document.id} сохранен в Hive',
    );
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

    // Получаем реальный статус завершения из объекта строительства
    bool isCompleted = false;
    DateTime? completionDate;
    
    try {
      final objectsBox = HiveService.constructionObjectsBox;
      final objectAdapter = objectsBox.values.firstWhere(
        (adapter) => adapter.projectId == projectId,
      );
      isCompleted = objectAdapter.isCompleted;
      // В моке не храним дату завершения отдельно, поэтому если завершено - ставим текущую (или надо добавить в адаптер)
      // Для простоты, если завершено, ставим заглушку даты
      if (isCompleted) {
        completionDate = DateTime.now(); 
      }
    } catch (_) {
      // Если объект не найден, считаем что не завершено
    }

    return ConstructionCompletionStatus(
      projectId: projectId,
      isCompleted: isCompleted,
      completionDate: completionDate,
      progress: 1.0, // Прогресс приходит с бэка, у объекта 100%
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
      final updatedDoc = FinalDocument(
        id: documents[index].id,
        title: documents[index].title,
        description: documents[index].description,
        fileUrl: documents[index].fileUrl,
        status: FinalDocumentStatus.signed,
        submittedAt: documents[index].submittedAt ?? DateTime.now(),
        signedAt: DateTime.now(),
        signatureUrl: 'https://example.com/signature$documentId.png',
      );
      // Сохраняем в Hive
      _saveDocument(updatedDoc, projectId);
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
