// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectRemoteDataSourceHash() =>
    r'056d656ef79356718720a730be7fe527dcc2bc1a';

/// Провайдер для Retrofit источника данных проектов
/// Находится в data слое, так как зависит от реализации (Retrofit)
///
/// Copied from [projectRemoteDataSource].
@ProviderFor(projectRemoteDataSource)
final projectRemoteDataSourceProvider =
    AutoDisposeProvider<ProjectRemoteDataSource>.internal(
      projectRemoteDataSource,
      name: r'projectRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$projectRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjectRemoteDataSourceRef =
    AutoDisposeProviderRef<ProjectRemoteDataSource>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
