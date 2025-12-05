// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для репозитория объектов строительства
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

@ProviderFor(constructionObjectRepository)
const constructionObjectRepositoryProvider =
    ConstructionObjectRepositoryProvider._();

/// Провайдер для репозитория объектов строительства
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов

final class ConstructionObjectRepositoryProvider
    extends
        $FunctionalProvider<
          ConstructionObjectRepository,
          ConstructionObjectRepository,
          ConstructionObjectRepository
        >
    with $Provider<ConstructionObjectRepository> {
  /// Провайдер для репозитория объектов строительства
  /// Возвращает интерфейс, а не имплементацию
  /// Использует моковый репозиторий если включены моки, иначе реальный
  /// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
  /// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов
  const ConstructionObjectRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'constructionObjectRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$constructionObjectRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConstructionObjectRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConstructionObjectRepository create(Ref ref) {
    return constructionObjectRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConstructionObjectRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConstructionObjectRepository>(value),
    );
  }
}

String _$constructionObjectRepositoryHash() =>
    r'2d8d1d4ac05ec2a83d44d7c9bf2d3df4fe6aa75c';
