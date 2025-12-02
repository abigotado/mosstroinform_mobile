// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для Retrofit источника данных проектов
/// Находится в data слое, так как зависит от реализации (Retrofit)

@ProviderFor(projectRemoteDataSource)
const projectRemoteDataSourceProvider = ProjectRemoteDataSourceProvider._();

/// Провайдер для Retrofit источника данных проектов
/// Находится в data слое, так как зависит от реализации (Retrofit)

final class ProjectRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ProjectRemoteDataSource,
          ProjectRemoteDataSource,
          ProjectRemoteDataSource
        >
    with $Provider<ProjectRemoteDataSource> {
  /// Провайдер для Retrofit источника данных проектов
  /// Находится в data слое, так как зависит от реализации (Retrofit)
  const ProjectRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProjectRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectRemoteDataSource create(Ref ref) {
    return projectRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectRemoteDataSource>(value),
    );
  }
}

String _$projectRemoteDataSourceHash() =>
    r'056d656ef79356718720a730be7fe527dcc2bc1a';
