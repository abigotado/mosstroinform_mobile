// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsNotifierHash() => r'53614cb40ee5f0ae3b87f9703314b90e9e71ea36';

/// Notifier для управления состоянием списка проектов
///
/// Copied from [ProjectsNotifier].
@ProviderFor(ProjectsNotifier)
final projectsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ProjectsNotifier, ProjectsState>.internal(
      ProjectsNotifier.new,
      name: r'projectsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$projectsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProjectsNotifier = AutoDisposeAsyncNotifier<ProjectsState>;
String _$projectNotifierHash() => r'9394f15df82f363dcaf515544637b1a149b5e18c';

/// Notifier для управления состоянием конкретного проекта
///
/// Copied from [ProjectNotifier].
@ProviderFor(ProjectNotifier)
final projectNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ProjectNotifier, ProjectState>.internal(
      ProjectNotifier.new,
      name: r'projectNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$projectNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProjectNotifier = AutoDisposeAsyncNotifier<ProjectState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
