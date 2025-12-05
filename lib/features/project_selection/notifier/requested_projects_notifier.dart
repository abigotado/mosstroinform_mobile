import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'requested_projects_notifier.g.dart';

/// Notifier для управления состоянием запрошенных проектов
@riverpod
class RequestedProjectsNotifier extends _$RequestedProjectsNotifier {
  @override
  Future<List<Project>> build() async {
    final repository = ref.read(projectRepositoryProvider);
    return await repository.getRequestedProjects();
  }

  /// Загрузить список запрошенных проектов
  Future<void> loadRequestedProjects() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(projectRepositoryProvider);
      final projects = await repository.getRequestedProjects();
      state = AsyncValue.data(projects);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

/// Провайдер для проверки, запрошен ли проект
@riverpod
Future<bool> isProjectRequested(
  Ref ref,
  String projectId,
) async {
  final repository = ref.read(projectRepositoryProvider);
  return await repository.isProjectRequested(projectId);
}

