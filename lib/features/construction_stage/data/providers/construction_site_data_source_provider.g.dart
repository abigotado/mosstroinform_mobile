// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для Retrofit источника данных строительной площадки
/// Находится в data слое, так как зависит от реализации (Retrofit)

@ProviderFor(constructionSiteRemoteDataSource)
const constructionSiteRemoteDataSourceProvider =
    ConstructionSiteRemoteDataSourceProvider._();

/// Провайдер для Retrofit источника данных строительной площадки
/// Находится в data слое, так как зависит от реализации (Retrofit)

final class ConstructionSiteRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ConstructionSiteRemoteDataSource,
          ConstructionSiteRemoteDataSource,
          ConstructionSiteRemoteDataSource
        >
    with $Provider<ConstructionSiteRemoteDataSource> {
  /// Провайдер для Retrofit источника данных строительной площадки
  /// Находится в data слое, так как зависит от реализации (Retrofit)
  const ConstructionSiteRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'constructionSiteRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$constructionSiteRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ConstructionSiteRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConstructionSiteRemoteDataSource create(Ref ref) {
    return constructionSiteRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConstructionSiteRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConstructionSiteRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$constructionSiteRemoteDataSourceHash() =>
    r'8ca3cb82f90d7e2cdc449e63c5f3a7032b60f385';
