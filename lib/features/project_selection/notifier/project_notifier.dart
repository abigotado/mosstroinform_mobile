import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_notifier.g.dart';

/// Состояние списка проектов
class ProjectsState {
  final List<Project> projects;
  final bool isLoading;
  final Failure? error;

  const ProjectsState({
    required this.projects,
    this.isLoading = false,
    this.error,
  });

  ProjectsState copyWith({
    List<Project>? projects,
    bool? isLoading,
    Failure? error,
  }) {
    return ProjectsState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием списка проектов
@riverpod
class ProjectsNotifier extends _$ProjectsNotifier {
  @override
  Future<ProjectsState> build() async {
    return const ProjectsState(projects: []);
  }

  /// Загрузить список проектов
  Future<void> loadProjects() async {
    if (!ref.mounted) return;
    
    AppLogger.info('ProjectsNotifier.loadProjects: начинаем загрузку');
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(projectRepositoryProvider);
      AppLogger.info(
        'ProjectsNotifier.loadProjects: репозиторий получен, тип: ${repository.runtimeType}',
      );
      
      final projects = await repository.getProjects();
      
      if (!ref.mounted) {
        AppLogger.warning('ProjectsNotifier.loadProjects: провайдер disposed после загрузки проектов');
        return;
      }
      
      AppLogger.info(
        'ProjectsNotifier.loadProjects: получено ${projects.length} проектов',
      );
      state = AsyncValue.data(
        ProjectsState(projects: projects, isLoading: false),
      );
    } on Failure catch (e) {
      if (!ref.mounted) return;
      AppLogger.error('ProjectsNotifier.loadProjects: ошибка Failure: $e');
      state = AsyncValue.data(
        ProjectsState(projects: [], isLoading: false, error: e),
      );
    } catch (e, stackTrace) {
      if (!ref.mounted) return;
      AppLogger.error(
        'ProjectsNotifier.loadProjects: неизвестная ошибка: $e',
        stackTrace,
      );
      state = AsyncValue.data(
        ProjectsState(
          projects: [],
          isLoading: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
    }
  }
}

/// Состояние проекта
class ProjectState {
  final Project? project;
  final bool isLoading;
  final bool isRequestingConstruction;
  final Failure? error;

  const ProjectState({
    this.project,
    this.isLoading = false,
    this.isRequestingConstruction = false,
    this.error,
  });

  ProjectState copyWith({
    Project? project,
    bool? isLoading,
    bool? isRequestingConstruction,
    Failure? error,
  }) {
    return ProjectState(
      project: project ?? this.project,
      isLoading: isLoading ?? this.isLoading,
      isRequestingConstruction: isRequestingConstruction ?? this.isRequestingConstruction,
      error: error,
    );
  }
}

/// Notifier для управления состоянием конкретного проекта
@riverpod
class ProjectNotifier extends _$ProjectNotifier {
  @override
  Future<ProjectState> build() async {
    return const ProjectState();
  }

  /// Загрузить проект по ID
  Future<void> loadProject(String id) async {
    if (!ref.mounted) return;
    
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(projectRepositoryProvider);
      final project = await repository.getProjectById(id);
      
      if (!ref.mounted) return;
      
      state = AsyncValue.data(ProjectState(project: project, isLoading: false));
    } on Failure catch (e) {
      if (!ref.mounted) return;
      state = AsyncValue.data(ProjectState(isLoading: false, error: e));
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncValue.data(
        ProjectState(
          isLoading: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
    }
  }

  /// Отправить запрос на строительство
  Future<void> requestConstruction(String projectId) async {
    if (!ref.mounted) return;
    
    // Устанавливаем состояние загрузки запроса
    final currentState = state.value;
    state = AsyncValue.data(
      ProjectState(
        project: currentState?.project,
        isLoading: false,
        isRequestingConstruction: true,
        error: null,
      ),
    );
    
    try {
      final repository = ref.read(projectRepositoryProvider);
      await repository.requestConstruction(projectId);
      
      if (!ref.mounted) return;
      
      // Обновляем состояние: запрос завершен, проект остается тем же
      state = AsyncValue.data(
        ProjectState(
          project: currentState?.project,
          isLoading: false,
          isRequestingConstruction: false,
          error: null,
        ),
      );
      
      // Обновляем список проектов, чтобы карточки обновились со статусом
      if (ref.mounted) {
        ref.read(projectsProvider.notifier).loadProjects();
      }
    } on Failure catch (e) {
      if (!ref.mounted) return;
      state = AsyncValue.data(
        ProjectState(
          project: currentState?.project,
          isLoading: false,
          isRequestingConstruction: false,
          error: e,
        ),
      );
    } catch (e) {
      if (!ref.mounted) return;
      state = AsyncValue.data(
        ProjectState(
          project: currentState?.project,
          isLoading: false,
          isRequestingConstruction: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
    }
  }
}
