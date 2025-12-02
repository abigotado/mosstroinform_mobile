// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для Retrofit источника данных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)

@ProviderFor(documentRemoteDataSource)
const documentRemoteDataSourceProvider = DocumentRemoteDataSourceProvider._();

/// Провайдер для Retrofit источника данных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)

final class DocumentRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          DocumentRemoteDataSource,
          DocumentRemoteDataSource,
          DocumentRemoteDataSource
        >
    with $Provider<DocumentRemoteDataSource> {
  /// Провайдер для Retrofit источника данных документов
  /// Находится в data слое, так как зависит от реализации (Retrofit)
  const DocumentRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<DocumentRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DocumentRemoteDataSource create(Ref ref) {
    return documentRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentRemoteDataSource>(value),
    );
  }
}

String _$documentRemoteDataSourceHash() =>
    r'31a829f4b464597fb2751295b70215576027f31f';
