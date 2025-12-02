// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$finalDocumentRepositoryHash() =>
    r'c624abede596089a9a7a0aed3a674166022a9c20';

/// Провайдер для репозитория финальных документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
///
/// Copied from [finalDocumentRepository].
@ProviderFor(finalDocumentRepository)
final finalDocumentRepositoryProvider =
    AutoDisposeProvider<FinalDocumentRepository>.internal(
      finalDocumentRepository,
      name: r'finalDocumentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$finalDocumentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinalDocumentRepositoryRef =
    AutoDisposeProviderRef<FinalDocumentRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
