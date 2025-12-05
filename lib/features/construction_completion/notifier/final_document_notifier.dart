import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/providers/final_document_repository_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_by_project_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'final_document_notifier.g.dart';

/// Состояние статуса завершения строительства
class CompletionStatusState {
  final ConstructionCompletionStatus? status;
  final bool isLoading;
  final Failure? error;

  const CompletionStatusState({
    this.status,
    this.isLoading = false,
    this.error,
  });

  CompletionStatusState copyWith({
    ConstructionCompletionStatus? status,
    bool? isLoading,
    Failure? error,
  }) {
    return CompletionStatusState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием завершения строительства
@riverpod
class CompletionStatusNotifier extends _$CompletionStatusNotifier {
  @override
  Future<CompletionStatusState> build(String projectId) async {
    // Сразу загружаем данные при создании провайдера
    final repository = ref.read(finalDocumentRepositoryProvider);
    final status = await repository.getCompletionStatus(projectId);
    return CompletionStatusState(status: status, isLoading: false);
  }

  /// Загрузить статус завершения строительства
  Future<void> loadCompletionStatus() async {
    // Сохраняем предыдущее состояние, если оно есть
    final previousState = state.value;
    // Устанавливаем loading только если нет предыдущих данных
    if (previousState == null || previousState.status == null) {
      state = const AsyncValue.loading();
    }
    // Если есть данные, не меняем состояние - обновляем в фоне

    try {
      final repository = ref.read(finalDocumentRepositoryProvider);
      final status = await repository.getCompletionStatus(projectId);
      state = AsyncValue.data(
        CompletionStatusState(status: status, isLoading: false),
      );
    } on Failure catch (e) {
      // При ошибке сохраняем предыдущие данные, если они были
      if (previousState != null && previousState.status != null) {
        state = AsyncValue.data(
          previousState.copyWith(error: e, isLoading: false),
        );
      } else {
        state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, s) {
      final failure = UnknownFailure('Неизвестная ошибка: $e');
      if (previousState != null && previousState.status != null) {
        state = AsyncValue.data(
          previousState.copyWith(error: failure, isLoading: false),
        );
      } else {
        state = AsyncValue.error(failure, s);
      }
    }
  }
}

/// Состояние списка финальных документов
class FinalDocumentsState {
  final List<FinalDocument> documents;
  final bool isLoading;
  final Failure? error;

  const FinalDocumentsState({
    required this.documents,
    this.isLoading = false,
    this.error,
  });

  FinalDocumentsState copyWith({
    List<FinalDocument>? documents,
    bool? isLoading,
    Failure? error,
  }) {
    return FinalDocumentsState(
      documents: documents ?? this.documents,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием списка финальных документов
@riverpod
class FinalDocumentsNotifier extends _$FinalDocumentsNotifier {
  @override
  Future<FinalDocumentsState> build(String projectId) async {
    return const FinalDocumentsState(documents: []);
  }

  /// Загрузить список финальных документов
  Future<void> loadFinalDocuments() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(finalDocumentRepositoryProvider);
      final documents = await repository.getFinalDocuments(projectId);
      state = AsyncValue.data(
        FinalDocumentsState(documents: documents, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }
}

/// Состояние отдельного финального документа
class FinalDocumentState {
  final FinalDocument? document;
  final bool isLoading;
  final Failure? error;

  const FinalDocumentState({this.document, this.isLoading = false, this.error});

  FinalDocumentState copyWith({
    FinalDocument? document,
    bool? isLoading,
    Failure? error,
  }) {
    return FinalDocumentState(
      document: document ?? this.document,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием отдельного финального документа
@riverpod
class FinalDocumentNotifier extends _$FinalDocumentNotifier {
  @override
  Future<FinalDocumentState> build(
    (String projectId, String documentId) params,
  ) async {
    return const FinalDocumentState();
  }

  /// Загрузить финальный документ по ID
  Future<void> loadFinalDocument() async {
    // Сохраняем предыдущее состояние, если оно есть
    final previousState = state.value;
    // Устанавливаем loading только если нет предыдущих данных
    if (previousState == null || previousState.document == null) {
      state = const AsyncValue.loading();
    }
    // Если есть данные, не меняем состояние - обновляем в фоне

    try {
      final repository = ref.read(finalDocumentRepositoryProvider);
      final document = await repository.getFinalDocumentById(
        params.$1,
        params.$2,
      );
      state = AsyncValue.data(
        FinalDocumentState(document: document, isLoading: false),
      );
    } on Failure catch (e) {
      // При ошибке сохраняем предыдущие данные, если они были
      if (previousState != null && previousState.document != null) {
        state = AsyncValue.data(
          previousState.copyWith(error: e, isLoading: false),
        );
      } else {
        state = AsyncValue.error(e, StackTrace.current);
      }
    } catch (e, s) {
      final failure = UnknownFailure('Неизвестная ошибка: $e');
      if (previousState != null && previousState.document != null) {
        state = AsyncValue.data(
          previousState.copyWith(error: failure, isLoading: false),
        );
      } else {
        state = AsyncValue.error(failure, s);
      }
    }
  }

  /// Подписать финальный документ
  Future<void> signFinalDocument() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final repository = ref.read(finalDocumentRepositoryProvider);
      await repository.signFinalDocument(params.$1, params.$2);
      await loadFinalDocument(); // Перезагрузить документ после подписания

      // Проверяем, все ли документы подписаны
      final completionStatus = await repository.getCompletionStatus(params.$1);
      final allDocumentsSigned = completionStatus.allDocumentsSigned;

      // Обновляем статус документов в объекте строительства
      final objectRepository = ref.read(constructionObjectRepositoryProvider);
      await objectRepository.updateDocumentsSignedStatus(
        params.$1,
        allDocumentsSigned,
      );

      // Обновить статус завершения строительства
      ref.invalidate(completionStatusProvider(params.$1));

      // Инвалидируем провайдер списка документов, чтобы обновился список на экране
      ref.invalidate(finalDocumentsProvider(params.$1));

      // Инвалидируем провайдер объекта строительства, чтобы обновилась кнопка "Завершить строительство"
      ref.invalidate(constructionObjectByProjectProvider(params.$1));
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }
}
