import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/mock_state_providers.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/providers/document_repository_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/mock_construction_object_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';

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

  /// Загрузить документы для проекта
  Future<void> loadDocumentsForProject(String projectId) async {
    state = const AsyncValue.loading();
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
    try {
      final repository = ref.read(documentRepositoryProvider);
      await repository.approveDocument(documentId);
      // Перезагружаем документ после одобрения
      await loadDocument(documentId);

      // Проверяем, все ли документы проекта одобрены
      final document = state.value;
      if (document != null) {
        final projectId = document.projectId;
        final allApproved = ref.read(mockDocumentsStateProvider.notifier).areAllDocumentsApproved(projectId);

        if (allApproved) {
          AppLogger.info(
            'DocumentNotifier.approveDocument: все документы проекта $projectId одобрены, создаем объект',
          );

          // Получаем проект
          final projectRepository = ref.read(projectRepositoryProvider);
          final project = await projectRepository.getProjectById(projectId);

          // Создаем объект строительства
          final objectRepository = ref.read(constructionObjectRepositoryProvider);
          if (objectRepository.runtimeType.toString() == 'MockConstructionObjectRepository') {
            final mockRepo = objectRepository as MockConstructionObjectRepository;
            await mockRepo.createObjectFromProject(projectId, project);
            AppLogger.info(
              'DocumentNotifier.approveDocument: объект создан для проекта $projectId',
            );
          }
        }
      }
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
