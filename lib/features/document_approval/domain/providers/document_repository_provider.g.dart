// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

@ProviderFor(documentRepository)
const documentRepositoryProvider = DocumentRepositoryProvider._();

/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

final class DocumentRepositoryProvider
    extends
        $FunctionalProvider<
          DocumentRepository,
          DocumentRepository,
          DocumentRepository
        >
    with $Provider<DocumentRepository> {
  /// Провайдер для репозитория документов
  /// Возвращает интерфейс, а не имплементацию
  /// Использует моковый репозиторий если включены моки, иначе реальный
  /// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
  /// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов
  const DocumentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentRepositoryHash();

  @$internal
  @override
  $ProviderElement<DocumentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DocumentRepository create(Ref ref) {
    return documentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentRepository>(value),
    );
  }
}

String _$documentRepositoryHash() =>
    r'4c3700c4a75682ce03b11e4c1d600aae02b21d0a';
