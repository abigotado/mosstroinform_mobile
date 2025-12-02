// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectRepositoryHash() => r'522f47d9d7a3fc0514b17d7b6f608c51244562f1';

/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
///
/// Copied from [projectRepository].
@ProviderFor(projectRepository)
final projectRepositoryProvider =
    AutoDisposeProvider<ProjectRepository>.internal(
      projectRepository,
      name: r'projectRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$projectRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjectRepositoryRef = AutoDisposeProviderRef<ProjectRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
