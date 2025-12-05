// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием списка проектов

@ProviderFor(ProjectsNotifier)
const projectsProvider = ProjectsNotifierProvider._();

/// Notifier для управления состоянием списка проектов
final class ProjectsNotifierProvider
    extends $AsyncNotifierProvider<ProjectsNotifier, ProjectsState> {
  /// Notifier для управления состоянием списка проектов
  const ProjectsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsNotifierHash();

  @$internal
  @override
  ProjectsNotifier create() => ProjectsNotifier();
}

String _$projectsNotifierHash() => r'2782031c87e4eb51c3b127e886ab8da87afb9ec7';

/// Notifier для управления состоянием списка проектов

abstract class _$ProjectsNotifier extends $AsyncNotifier<ProjectsState> {
  FutureOr<ProjectsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ProjectsState>, ProjectsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectsState>, ProjectsState>,
              AsyncValue<ProjectsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием конкретного проекта

@ProviderFor(ProjectNotifier)
const projectProvider = ProjectNotifierProvider._();

/// Notifier для управления состоянием конкретного проекта
final class ProjectNotifierProvider
    extends $AsyncNotifierProvider<ProjectNotifier, ProjectState> {
  /// Notifier для управления состоянием конкретного проекта
  const ProjectNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectNotifierHash();

  @$internal
  @override
  ProjectNotifier create() => ProjectNotifier();
}

String _$projectNotifierHash() => r'8fc7ef1e34ea6110d130e3d7a12711d9a7e7124f';

/// Notifier для управления состоянием конкретного проекта

abstract class _$ProjectNotifier extends $AsyncNotifier<ProjectState> {
  FutureOr<ProjectState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ProjectState>, ProjectState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProjectState>, ProjectState>,
              AsyncValue<ProjectState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
