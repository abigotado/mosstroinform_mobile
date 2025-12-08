import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/features/my_objects/ui/screens/my_objects_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/paginated_project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/requested_projects_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_notifier.freezed.dart';
part 'project_notifier.g.dart';

/// Состояние списка проектов
@freezed
abstract class ProjectsState with _$ProjectsState {
  const factory ProjectsState({
    required List<Project> projects,
    @Default(false) bool isLoading,
    @Default(null) Failure? error,
  }) = _ProjectsState;
}

/// Notifier для управления состоянием списка проектов
@riverpod
class ProjectsNotifier extends _$ProjectsNotifier {
  @override
  Future<ProjectsState> build() async {
    // Следим за состоянием авторизации, чтобы сбрасывать состояние при выходе
    ref.watch(authProvider);

    // Начинаем с загрузки, чтобы UI показывал шиммер, а не "нет проектов"
    return const ProjectsState(projects: [], isLoading: true);
  }

  /// Загрузить список проектов
  Future<void> loadProjects() async {
    // Проверяем авторизацию перед загрузкой
    final authState = ref.read(authProvider);
    if (authState.value?.isAuthenticated != true) {
      AppLogger.info('ProjectsNotifier.loadProjects: пользователь не авторизован, пропускаем загрузку');
      return;
    }

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(projectRepositoryProvider);
      final projects = await repository
          .getProjects(); // Без пагинации - получаем все проекты

      if (state.hasValue || !state.hasError) {
        state = AsyncValue.data(
          ProjectsState(projects: projects, isLoading: false),
        );
      }
    } on Failure catch (e) {
      state = AsyncValue.data(
        const ProjectsState(projects: []).copyWith(isLoading: false, error: e),
      );
    } catch (e, _) {
      // Игнорируем ошибку использования disposed ref, если она возникла
      if (e.toString().contains('disposed')) return;

      state = AsyncValue.data(
        const ProjectsState(projects: []).copyWith(
          isLoading: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
    }
  }
}

/// Состояние проекта
@freezed
abstract class ProjectState with _$ProjectState {
  const factory ProjectState({
    @Default(null) Project? project,
    @Default(false) bool isLoading,
    @Default(false) bool isRequestingConstruction,
    @Default(null) Failure? error,
  }) = _ProjectState;
}

/// Notifier для управления состоянием конкретного проекта
@riverpod
class ProjectNotifier extends _$ProjectNotifier {
  @override
  Future<ProjectState> build() async {
    return const ProjectState();
  }

  /// Загрузить проект по ID
  Future<void> loadProject(String id, {bool showLoading = true}) async {
    // Если showLoading = false и есть данные, обновляем без показа loading
    final currentState = state.value;
    if (showLoading || currentState == null || currentState.project == null) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(projectRepositoryProvider);
      final project = await repository.getProjectById(id);

      state = AsyncValue.data(ProjectState(project: project, isLoading: false));
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(isLoading: false, error: e) ??
            const ProjectState().copyWith(isLoading: false, error: e),
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(
              isLoading: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ) ??
            const ProjectState().copyWith(
              isLoading: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ),
      );
    }
  }

  /// Начать строительство проекта
  Future<void> startConstruction(String projectId, String address) async {
    // Устанавливаем состояние загрузки
    final currentState = state.value;
    state = AsyncValue.data(
      currentState?.copyWith(isLoading: true, error: null) ??
          const ProjectState(isLoading: true),
    );

    try {
      final repository = ref.read(projectRepositoryProvider);
      await repository.startConstruction(projectId, address);

      // Инвалидируем провайдеры для обновления UI
      ref.invalidate(isProjectRequestedProvider(projectId));
      ref.invalidate(projectsProvider);
      ref.invalidate(requestedProjectsProvider);
      ref.invalidate(paginatedProjectsProvider);
      ref.invalidate(
        myObjectsProvider,
      ); // Инвалидируем список объектов для обновления "Мои объекты"

      // Перезагружаем данные после инвалидации
      await loadProject(projectId);
      ref.read(projectsProvider.notifier).loadProjects();
      ref.read(requestedProjectsProvider.notifier).loadRequestedProjects();
      ref.read(paginatedProjectsProvider.notifier).loadFirstPage();
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(isLoading: false, error: e) ??
            ProjectState(error: e),
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(
              isLoading: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ) ??
            ProjectState(error: UnknownFailure('Неизвестная ошибка: $e')),
      );
    }
  }

  /// Отправить запрос на строительство
  Future<void> requestConstruction(String projectId) async {
    // Устанавливаем состояние загрузки запроса
    final currentState = state.value;
    state = AsyncValue.data(
      currentState?.copyWith(
            isLoading: false,
            isRequestingConstruction: true,
            error: null,
          ) ??
          const ProjectState(isRequestingConstruction: true),
    );

    try {
      final repository = ref.read(projectRepositoryProvider);
      await repository.requestConstruction(projectId);

      // Инвалидируем провайдеры для обновления UI
      // Инвалидируем провайдер проверки статуса запроса для этого проекта
      ref.invalidate(isProjectRequestedProvider(projectId));
      // Инвалидируем список проектов для обновления карточек
      ref.invalidate(projectsProvider);
      // Инвалидируем список запрошенных проектов
      ref.invalidate(requestedProjectsProvider);
      // Инвалидируем пагинированный список проектов
      ref.invalidate(paginatedProjectsProvider);

      // Перезагружаем данные после инвалидации
      // Перезагружаем текущий проект для обновления статуса на странице деталей
      // Не показываем loading, так как данные уже есть
      await loadProject(projectId, showLoading: false);
      // Перезагружаем список проектов для обновления карточек
      ref.read(projectsProvider.notifier).loadProjects();
      // Перезагружаем список запрошенных проектов
      ref.read(requestedProjectsProvider.notifier).loadRequestedProjects();
      // Перезагружаем пагинированный список проектов
      ref.read(paginatedProjectsProvider.notifier).loadFirstPage();
    } on Failure catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(
              isLoading: false,
              isRequestingConstruction: false,
              error: e,
            ) ??
            ProjectState(error: e),
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState?.copyWith(
              isLoading: false,
              isRequestingConstruction: false,
              error: UnknownFailure('Неизвестная ошибка: $e'),
            ) ??
            ProjectState(error: UnknownFailure('Неизвестная ошибка: $e')),
      );
    }
  }
}
