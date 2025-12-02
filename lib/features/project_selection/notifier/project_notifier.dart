import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/providers/project_data_providers.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
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
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(projectRepositoryProvider);
      final projects = await repository.getProjects();
      state = AsyncValue.data(
        ProjectsState(projects: projects, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.data(
        ProjectsState(projects: [], isLoading: false, error: e),
      );
    } catch (e) {
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
  final Failure? error;

  const ProjectState({this.project, this.isLoading = false, this.error});

  ProjectState copyWith({Project? project, bool? isLoading, Failure? error}) {
    return ProjectState(
      project: project ?? this.project,
      isLoading: isLoading ?? this.isLoading,
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
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(projectRepositoryProvider);
      final project = await repository.getProjectById(id);
      state = AsyncValue.data(ProjectState(project: project, isLoading: false));
    } on Failure catch (e) {
      state = AsyncValue.data(ProjectState(isLoading: false, error: e));
    } catch (e) {
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
    try {
      final repository = ref.read(projectRepositoryProvider);
      await repository.requestConstruction(projectId);
      // Перезагружаем проект после отправки запроса
      await loadProject(projectId);
    } on Failure catch (e) {
      state = AsyncValue.data(
        ProjectState(project: state.value?.project, isLoading: false, error: e),
      );
    } catch (e) {
      state = AsyncValue.data(
        ProjectState(
          project: state.value?.project,
          isLoading: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
    }
  }
}
