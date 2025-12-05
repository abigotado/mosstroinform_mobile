// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для удалённого источника данных объектов строительства

@ProviderFor(constructionObjectRemoteDataSource)
const constructionObjectRemoteDataSourceProvider =
    ConstructionObjectRemoteDataSourceProvider._();

/// Провайдер для удалённого источника данных объектов строительства

final class ConstructionObjectRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IConstructionObjectRemoteDataSource,
          IConstructionObjectRemoteDataSource,
          IConstructionObjectRemoteDataSource
        >
    with $Provider<IConstructionObjectRemoteDataSource> {
  /// Провайдер для удалённого источника данных объектов строительства
  const ConstructionObjectRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'constructionObjectRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$constructionObjectRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IConstructionObjectRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IConstructionObjectRemoteDataSource create(Ref ref) {
    return constructionObjectRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IConstructionObjectRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IConstructionObjectRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$constructionObjectRemoteDataSourceHash() =>
    r'de4689dbca3f7c11b549943fac919b9bb4876b0f';
