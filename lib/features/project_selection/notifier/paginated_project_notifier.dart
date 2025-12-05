import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/pagination/paginated_notifier_mixin.dart';
import 'package:mosstroinform_mobile/core/pagination/paginated_state.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paginated_project_notifier.freezed.dart';
part 'paginated_project_notifier.g.dart';

/// Состояние списка проектов с пагинацией
@freezed
abstract class PaginatedProjectsState
    with _$PaginatedProjectsState
    implements PaginatedState<Project> {
  const PaginatedProjectsState._();

  @Implements<PaginatedState<Project>>()
  const factory PaginatedProjectsState({
    required List<Project> items,
    @Default(0) int currentPage,
    @Default(10) int itemsPerPage,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(null) int? totalCount,
    @Default(null) Object? error,
  }) = _PaginatedProjectsState;

  /// Добавить новые элементы (для следующей страницы)
  PaginatedProjectsState appendItems(List<Project> newItems, {bool? hasMore}) {
    return copyWith(
      items: [...items, ...newItems],
      currentPage: currentPage + 1,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: false,
      error: null,
    );
  }

  /// Сбросить пагинацию (начать с первой страницы)
  PaginatedProjectsState reset() {
    return copyWith(
      items: [],
      currentPage: 0,
      hasMore: false,
      isLoadingMore: false,
      error: null,
    );
  }
}

/// Notifier для управления списком проектов с пагинацией
@riverpod
class PaginatedProjectsNotifier extends _$PaginatedProjectsNotifier
    with PaginatedNotifierMixin<Project, PaginatedProjectsState> {
  @override
  Future<PaginatedProjectsState> build() async {
    return const PaginatedProjectsState(items: []);
  }

  @override
  Future<void> loadFirstPage() async {
    AppLogger.info(
      'PaginatedProjectsNotifier.loadFirstPage: начинаем загрузку первой страницы',
    );

    // Сбрасываем состояние
    state = AsyncValue.data(const PaginatedProjectsState(items: []));

    try {
      final repository = ref.read(projectRepositoryProvider);
      final paginationParams = getPaginationParams();

      AppLogger.info(
        'PaginatedProjectsNotifier.loadFirstPage: запрос с параметрами: $paginationParams',
      );

      final page = paginationParams['page'] as int;
      final limit = paginationParams['limit'] as int;
      
      // Запрашиваем первую страницу с бэкенда
      final firstPageItems = await repository.getProjects(page: page, limit: limit);
      
      // Проверяем, есть ли еще данные (если получили меньше limit, значит это последняя страница)
      final hasMore = firstPageItems.length == limit;

      AppLogger.info(
        'PaginatedProjectsNotifier.loadFirstPage: получено ${firstPageItems.length} проектов, hasMore=$hasMore',
      );

      state = AsyncValue.data(
        PaginatedProjectsState(
          items: firstPageItems,
          currentPage: 0,
          itemsPerPage: limit,
          hasMore: hasMore,
          totalCount: null, // Бэкенд может не возвращать totalCount
        ),
      );
    } on Failure catch (e) {
      AppLogger.error(
        'PaginatedProjectsNotifier.loadFirstPage: ошибка Failure: $e',
      );
      state = AsyncValue.data(
        const PaginatedProjectsState(items: []).copyWith(error: e),
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'PaginatedProjectsNotifier.loadFirstPage: неизвестная ошибка: $e',
        stackTrace,
      );
      state = AsyncValue.data(
        const PaginatedProjectsState(
          items: [],
        ).copyWith(error: UnknownFailure('Неизвестная ошибка: $e')),
      );
    }
  }

  @override
  Future<void> loadNextPage() async {
    if (!canLoadNextPage()) {
      AppLogger.info(
        'PaginatedProjectsNotifier.loadNextPage: нельзя загрузить следующую страницу',
      );
      return;
    }

    if (!state.hasValue || state.value == null) {
      AppLogger.warning(
        'PaginatedProjectsNotifier.loadNextPage: состояние null',
      );
      return;
    }

    final currentState = state.value!;

    AppLogger.info(
      'PaginatedProjectsNotifier.loadNextPage: загрузка страницы ${currentState.currentPage + 1}',
    );

    // Устанавливаем флаг загрузки
    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    try {
      final repository = ref.read(projectRepositoryProvider);
      final paginationParams = getPaginationParams();

      AppLogger.info(
        'PaginatedProjectsNotifier.loadNextPage: запрос с параметрами: $paginationParams',
      );

      final nextPage = currentState.currentPage + 1;
      final limit = currentState.itemsPerPage;
      
      // Запрашиваем следующую страницу с бэкенда
      final nextPageItems = await repository.getProjects(
        page: nextPage,
        limit: limit,
      );
      
      // Проверяем, есть ли еще данные (если получили меньше limit, значит это последняя страница)
      final hasMore = nextPageItems.length == limit;

      AppLogger.info(
        'PaginatedProjectsNotifier.loadNextPage: получено ${nextPageItems.length} проектов, hasMore=$hasMore',
      );

      state = AsyncValue.data(
        currentState.appendItems(nextPageItems, hasMore: hasMore),
      );
    } on Failure catch (e) {
      AppLogger.error(
        'PaginatedProjectsNotifier.loadNextPage: ошибка Failure: $e',
      );
      state = AsyncValue.data(
        currentState.copyWith(error: e, isLoadingMore: false),
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'PaginatedProjectsNotifier.loadNextPage: неизвестная ошибка: $e',
        stackTrace,
      );
      state = AsyncValue.data(
        currentState.copyWith(
          error: UnknownFailure('Неизвестная ошибка: $e'),
          isLoadingMore: false,
        ),
      );
    }
  }
}
