// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectRemoteDataSourceHash() =>
    r'9822588e52787fc4cd6ebfe59bdb92da2d5d56f1';

/// Провайдер для Retrofit источника данных
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
String _$projectRepositoryHash() => r'b6b382ac0ba9faac7b58f9d78f0a0925d17feeeb';

/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
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
