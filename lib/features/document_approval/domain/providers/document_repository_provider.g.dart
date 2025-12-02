// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentRepositoryHash() =>
    r'76695c945a8f32d29c727bab6b1a3b7059265ff5';

/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
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
