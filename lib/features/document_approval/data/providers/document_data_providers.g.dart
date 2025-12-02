// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentRemoteDataSourceHash() =>
    r'6a2a45c04de98311c3ca0da180dfb4cd2c8a4e22';

/// Провайдер для Retrofit источника данных документов
///
/// Copied from [documentRemoteDataSource].
@ProviderFor(documentRemoteDataSource)
final documentRemoteDataSourceProvider =
    AutoDisposeProvider<DocumentRemoteDataSource>.internal(
      documentRemoteDataSource,
      name: r'documentRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentRemoteDataSourceRef =
    AutoDisposeProviderRef<DocumentRemoteDataSource>;
String _$documentRepositoryHash() =>
    r'0d9ff013fe648ec7ee2d06bcb2ea721d610f44e0';

/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
///
/// Copied from [documentRepository].
@ProviderFor(documentRepository)
final documentRepositoryProvider =
    AutoDisposeProvider<DocumentRepository>.internal(
      documentRepository,
      name: r'documentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DocumentRepositoryRef = AutoDisposeProviderRef<DocumentRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
