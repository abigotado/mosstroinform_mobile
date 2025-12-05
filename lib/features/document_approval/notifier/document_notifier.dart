import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/providers/document_repository_provider.dart';
import 'package:mosstroinform_mobile/features/my_objects/ui/screens/my_objects_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    // Если список пустой, ставим loading, иначе обновляем в фоне
    if (state.value == null || state.value!.isEmpty) {
       state = const AsyncValue.loading();
    }
    
    try {
      final repository = ref.read(documentRepositoryProvider);
      final documents = await repository.getDocuments();
      state = AsyncValue.data(documents);
    } on Failure catch (failure, stackTrace) {
      // Если были данные, оставляем их и показываем ошибку (можно через доп поле в стейте, но тут AsyncValue)
      // В Riverpod 2 AsyncValue.error может содержать previousValue, но state = ... затирает.
      // Используем guard или ручную обработку.
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при загрузке документов: $e'),
        stackTrace,
      );
    }
  }

  /// Загрузить документы для проекта
  Future<void> loadDocumentsForProject(String projectId) async {
    // Если список пустой, ставим loading
    if (state.value == null || state.value!.isEmpty) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(documentRepositoryProvider);
      final documents = await repository.getDocumentsByProjectId(projectId);
      state = AsyncValue.data(documents);
    } on Failure catch (failure, stackTrace) {
      state = AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        UnknownFailure('Ошибка при загрузке документов проекта: $e'),
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
    // Сохраняем текущее состояние документа перед обновлением
    final currentDocument = state.value;

    try {
      final repository = ref.read(documentRepositoryProvider);
      await repository.approveDocument(documentId);

      // Получаем обновленный документ напрямую из репозитория
      // чтобы избежать перезагрузки через loadDocument, которая может вызвать шиммер
      final updatedDocument = await repository.getDocumentById(documentId);

      // Обновляем состояние напрямую, не вызывая loadDocument
      state = AsyncValue.data(updatedDocument);

      // Получаем projectId для обновления UI
      final projectId = updatedDocument.projectId;

      // Инвалидируем провайдер объектов, чтобы обновить список "Мои объекты"
      // (в моковой реализации объект уже создан внутри approveDocument)
      ref.invalidate(myObjectsProvider);

      // Обновляем список документов, чтобы показать обновленное состояние
      await ref
          .read(documentsProvider.notifier)
          .loadDocumentsForProject(projectId);
    } on Failure catch (failure, stackTrace) {
      // Восстанавливаем предыдущее состояние при ошибке
      state = currentDocument != null
          ? AsyncValue.data(currentDocument)
          : AsyncValue.error(failure, stackTrace);
    } catch (e, stackTrace) {
      // Восстанавливаем предыдущее состояние при ошибке
      state = currentDocument != null
          ? AsyncValue.data(currentDocument)
          : AsyncValue.error(
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
