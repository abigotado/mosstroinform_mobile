// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер состояния моковых документов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения

@ProviderFor(MockDocumentsState)
const mockDocumentsStateProvider = MockDocumentsStateProvider._();

/// Провайдер состояния моковых документов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
final class MockDocumentsStateProvider
    extends $NotifierProvider<MockDocumentsState, List<Document>> {
  /// Провайдер состояния моковых документов
  /// Состояние хранится в памяти и сбрасывается при перезапуске приложения
  const MockDocumentsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockDocumentsStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockDocumentsStateHash();

  @$internal
  @override
  MockDocumentsState create() => MockDocumentsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Document> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Document>>(value),
    );
  }
}

String _$mockDocumentsStateHash() =>
    r'4628894770df3e6b777a57b38922cfb932479559';

/// Провайдер состояния моковых документов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения

abstract class _$MockDocumentsState extends $Notifier<List<Document>> {
  List<Document> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Document>, List<Document>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Document>, List<Document>>,
              List<Document>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Провайдер состояния моковых проектов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения

@ProviderFor(MockProjectsState)
const mockProjectsStateProvider = MockProjectsStateProvider._();

/// Провайдер состояния моковых проектов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
final class MockProjectsStateProvider
    extends $NotifierProvider<MockProjectsState, List<Project>> {
  /// Провайдер состояния моковых проектов
  /// Состояние хранится в памяти и сбрасывается при перезапуске приложения
  const MockProjectsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockProjectsStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockProjectsStateHash();

  @$internal
  @override
  MockProjectsState create() => MockProjectsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Project> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Project>>(value),
    );
  }
}

String _$mockProjectsStateHash() => r'6ad6f218a4505b96a28ae47b8d534616fd8b7aa9';

/// Провайдер состояния моковых проектов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения

abstract class _$MockProjectsState extends $Notifier<List<Project>> {
  List<Project> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Project>, List<Project>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Project>, List<Project>>,
              List<Project>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
