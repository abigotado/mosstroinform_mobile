import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/providers/document_data_providers.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';

part 'document_notifier.g.dart';

/// Notifier для управления состоянием списка документов
@riverpod
class DocumentsNotifier extends _$DocumentsNotifier {
  @override
  Future<List<Document>> build() async {
    return [];
  }

  /// Загрузить список документов
  Future<void> loadDocuments() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(documentRepositoryProvider);
      final documents = await repository.getDocuments();
      state = AsyncValue.data(documents);
    } on Failure catch (failure, stackTrace) {
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при загрузке документов: $e'),
        stackTrace,
      );
    }
  }
}

/// Notifier для управления состоянием отдельного документа
@riverpod
class DocumentNotifier extends _$DocumentNotifier {
  @override
  Future<Document?> build(String documentId) async {
    return null;
  }

  /// Загрузить документ по ID
  Future<void> loadDocument(String documentId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(documentRepositoryProvider);
      final document = await repository.getDocumentById(documentId);
      state = AsyncValue.data(document);
    } on Failure catch (failure, stackTrace) {
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при загрузке документа: $e'),
        stackTrace,
      );
    }
  }

  /// Одобрить документ
  Future<void> approveDocument(String documentId) async {
    try {
      final repository = ref.read(documentRepositoryProvider);
      await repository.approveDocument(documentId);
      // Перезагружаем документ после одобрения
      await loadDocument(documentId);
    } on Failure catch (failure, stackTrace) {
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при одобрении документа: $e'),
        stackTrace,
      );
    }
  }

  /// Отклонить документ
  Future<void> rejectDocument(String documentId, String reason) async {
    try {
      final repository = ref.read(documentRepositoryProvider);
      await repository.rejectDocument(documentId, reason);
      // Перезагружаем документ после отклонения
      await loadDocument(documentId);
    } on Failure catch (failure, stackTrace) {
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при отклонении документа: $e'),
        stackTrace,
      );
    }
  }
}

