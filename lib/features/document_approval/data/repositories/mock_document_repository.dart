import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/mock_state_providers.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Интерактивная моковая реализация репозитория документов
/// Использует состояние через Riverpod для имитации реальной работы приложения
/// Состояние сбрасывается при перезапуске приложения
class MockDocumentRepository implements DocumentRepository {
  final Ref ref;

  MockDocumentRepository(this.ref);

  @override
  Future<List<Document>> getDocuments() async {
    // Проверяем mounted ДО await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    // Получаем текущее состояние из провайдера ДО await
    final state = ref.read(mockDocumentsStateProvider);

    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Проверяем mounted после await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed после await');
    }

    return state;
  }

  @override
  Future<List<Document>> getDocumentsByProjectId(String projectId) async {
    // Проверяем mounted ДО await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    // Получаем документы для проекта из состояния ДО await
    final allDocuments = ref.read(mockDocumentsStateProvider);

    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Проверяем mounted после await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed после await');
    }

    // Фильтруем документы по projectId
    return allDocuments.where((doc) => doc.projectId == projectId).toList();
  }

  @override
  Future<Document> getDocumentById(String id) async {
    // Проверяем mounted ДО await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Проверяем mounted после await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed после await');
    }

    final documents = await getDocuments();
    try {
      final document = documents.firstWhere((d) => d.id == id);
      return document;
    } catch (e) {
      throw UnknownFailure('Документ с ID $id не найден');
    }
  }

  @override
  Future<void> approveDocument(String documentId) async {
    debugPrint('=== MockDocumentRepository.approveDocument ===');
    debugPrint('documentId: $documentId');
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем текущий документ
    final documents = ref.read(mockDocumentsStateProvider);
    debugPrint('Текущее количество документов: ${documents.length}');
    final document = documents.firstWhere((d) => d.id == documentId);
    debugPrint(
      'Документ найден: ${document.title}, текущий статус: ${document.status}',
    );

    // Создаем обновленный документ со статусом approved
    final updatedDocument = Document(
      id: document.id,
      projectId: document.projectId,
      title: document.title,
      description: document.description,
      fileUrl: document.fileUrl,
      status: DocumentStatus.approved,
      submittedAt: document.submittedAt,
      approvedAt: DateTime.now(),
      rejectionReason: null,
    );

    debugPrint('Обновляем документ со статусом: ${updatedDocument.status}');
    // Обновляем состояние
    ref
        .read(mockDocumentsStateProvider.notifier)
        .updateDocument(updatedDocument);
    debugPrint('Состояние обновлено');
  }

  @override
  Future<void> rejectDocument(String documentId, String reason) async {
    // Проверяем mounted ДО await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed');
    }

    // Получаем текущий документ ДО await
    final documents = ref.read(mockDocumentsStateProvider);
    final document = documents.firstWhere((d) => d.id == documentId);

    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Проверяем mounted после await
    if (!ref.mounted) {
      throw UnknownFailure('Провайдер disposed после await');
    }

    // Создаем обновленный документ со статусом rejected
    final updatedDocument = Document(
      id: document.id,
      projectId: document.projectId,
      title: document.title,
      description: document.description,
      fileUrl: document.fileUrl,
      status: DocumentStatus.rejected,
      submittedAt: document.submittedAt,
      approvedAt: null,
      rejectionReason: reason,
    );

    // Обновляем состояние
    ref
        .read(mockDocumentsStateProvider.notifier)
        .updateDocument(updatedDocument);
  }
}
