// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$constructionSiteRepositoryHash() =>
    r'62c103f561c2435cd01cafc04521328248fdcf55';

/// Провайдер для репозитория строительной площадки
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
///
/// Copied from [constructionSiteRepository].
@ProviderFor(constructionSiteRepository)
final constructionSiteRepositoryProvider =
    AutoDisposeProvider<ConstructionSiteRepository>.internal(
      constructionSiteRepository,
      name: r'constructionSiteRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$constructionSiteRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConstructionSiteRepositoryRef =
    AutoDisposeProviderRef<ConstructionSiteRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
