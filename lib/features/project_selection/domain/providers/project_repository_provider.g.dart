// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

@ProviderFor(projectRepository)
const projectRepositoryProvider = ProjectRepositoryProvider._();

/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

final class ProjectRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectRepository,
          ProjectRepository,
          ProjectRepository
        >
    with $Provider<ProjectRepository> {
  /// Провайдер для репозитория проектов
  /// Возвращает интерфейс, а не имплементацию
  /// Использует моковый репозиторий если включены моки, иначе реальный
  /// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
  /// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов
  const ProjectRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProjectRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectRepository create(Ref ref) {
    return projectRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectRepository>(value),
    );
  }
}

String _$projectRepositoryHash() => r'28047f2c2eb9eae1e3548512f8e03cf75ff04ac6';
