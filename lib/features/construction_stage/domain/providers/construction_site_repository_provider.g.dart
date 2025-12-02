// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для репозитория строительной площадки
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория

@ProviderFor(constructionSiteRepository)
const constructionSiteRepositoryProvider =
    ConstructionSiteRepositoryProvider._();

/// Провайдер для репозитория строительной площадки
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория

final class ConstructionSiteRepositoryProvider
    extends
        $FunctionalProvider<
          ConstructionSiteRepository,
          ConstructionSiteRepository,
          ConstructionSiteRepository
        >
    with $Provider<ConstructionSiteRepository> {
  /// Провайдер для репозитория строительной площадки
  /// Возвращает интерфейс, а не имплементацию
  /// Использует моковый репозиторий если включены моки, иначе реальный
  /// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
  const ConstructionSiteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'constructionSiteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$constructionSiteRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConstructionSiteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConstructionSiteRepository create(Ref ref) {
    return constructionSiteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConstructionSiteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConstructionSiteRepository>(value),
    );
  }
}

String _$constructionSiteRepositoryHash() =>
    r'a3af079124b31a74c827ebfb54531e40787a9411';
