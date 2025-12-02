// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для Retrofit источника данных финальных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)

@ProviderFor(finalDocumentRemoteDataSource)
const finalDocumentRemoteDataSourceProvider =
    FinalDocumentRemoteDataSourceProvider._();

/// Провайдер для Retrofit источника данных финальных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)

final class FinalDocumentRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          FinalDocumentRemoteDataSource,
          FinalDocumentRemoteDataSource,
          FinalDocumentRemoteDataSource
        >
    with $Provider<FinalDocumentRemoteDataSource> {
  /// Провайдер для Retrofit источника данных финальных документов
  /// Находится в data слое, так как зависит от реализации (Retrofit)
  const FinalDocumentRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'finalDocumentRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$finalDocumentRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<FinalDocumentRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinalDocumentRemoteDataSource create(Ref ref) {
    return finalDocumentRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinalDocumentRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinalDocumentRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$finalDocumentRemoteDataSourceHash() =>
    r'72b741c7de381d1ed1ece39f44351d2ff38f108b';
