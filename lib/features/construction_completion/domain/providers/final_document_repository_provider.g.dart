// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для репозитория финальных документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория

@ProviderFor(finalDocumentRepository)
const finalDocumentRepositoryProvider = FinalDocumentRepositoryProvider._();

/// Провайдер для репозитория финальных документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория

final class FinalDocumentRepositoryProvider
    extends
        $FunctionalProvider<
          FinalDocumentRepository,
          FinalDocumentRepository,
          FinalDocumentRepository
        >
    with $Provider<FinalDocumentRepository> {
  /// Провайдер для репозитория финальных документов
  /// Возвращает интерфейс, а не имплементацию
  /// Использует моковый репозиторий если включены моки, иначе реальный
  /// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
  const FinalDocumentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'finalDocumentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$finalDocumentRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinalDocumentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinalDocumentRepository create(Ref ref) {
    return finalDocumentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinalDocumentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinalDocumentRepository>(value),
    );
  }
}

String _$finalDocumentRepositoryHash() =>
    r'2357fc681d7af4d8a6ae438a17a19e3451c6485d';
