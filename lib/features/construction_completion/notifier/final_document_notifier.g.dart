// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием завершения строительства

@ProviderFor(CompletionStatusNotifier)
const completionStatusProvider = CompletionStatusNotifierFamily._();

/// Notifier для управления состоянием завершения строительства
final class CompletionStatusNotifierProvider
    extends
        $AsyncNotifierProvider<
          CompletionStatusNotifier,
          CompletionStatusState
        > {
  /// Notifier для управления состоянием завершения строительства
  const CompletionStatusNotifierProvider._({
    required CompletionStatusNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'completionStatusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$completionStatusNotifierHash();

  @override
  String toString() {
    return r'completionStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CompletionStatusNotifier create() => CompletionStatusNotifier();

  @override
  bool operator ==(Object other) {
    return other is CompletionStatusNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$completionStatusNotifierHash() =>
    r'3b79e2df5937a5f15d62e83f03cdc2ab7361a865';

/// Notifier для управления состоянием завершения строительства

final class CompletionStatusNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CompletionStatusNotifier,
          AsyncValue<CompletionStatusState>,
          CompletionStatusState,
          FutureOr<CompletionStatusState>,
          String
        > {
  const CompletionStatusNotifierFamily._()
    : super(
        retry: null,
        name: r'completionStatusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием завершения строительства

  CompletionStatusNotifierProvider call(String projectId) =>
      CompletionStatusNotifierProvider._(argument: projectId, from: this);

  @override
  String toString() => r'completionStatusProvider';
}

/// Notifier для управления состоянием завершения строительства

abstract class _$CompletionStatusNotifier
    extends $AsyncNotifier<CompletionStatusState> {
  late final _$args = ref.$arg as String;
  String get projectId => _$args;

  FutureOr<CompletionStatusState> build(String projectId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<CompletionStatusState>, CompletionStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CompletionStatusState>,
                CompletionStatusState
              >,
              AsyncValue<CompletionStatusState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием списка финальных документов

@ProviderFor(FinalDocumentsNotifier)
const finalDocumentsProvider = FinalDocumentsNotifierFamily._();

/// Notifier для управления состоянием списка финальных документов
final class FinalDocumentsNotifierProvider
    extends
        $AsyncNotifierProvider<FinalDocumentsNotifier, FinalDocumentsState> {
  /// Notifier для управления состоянием списка финальных документов
  const FinalDocumentsNotifierProvider._({
    required FinalDocumentsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'finalDocumentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$finalDocumentsNotifierHash();

  @override
  String toString() {
    return r'finalDocumentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FinalDocumentsNotifier create() => FinalDocumentsNotifier();

  @override
  bool operator ==(Object other) {
    return other is FinalDocumentsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$finalDocumentsNotifierHash() =>
    r'3ba3323b00ad63156b6a76f405ad6bb25f7ec244';

/// Notifier для управления состоянием списка финальных документов

final class FinalDocumentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FinalDocumentsNotifier,
          AsyncValue<FinalDocumentsState>,
          FinalDocumentsState,
          FutureOr<FinalDocumentsState>,
          String
        > {
  const FinalDocumentsNotifierFamily._()
    : super(
        retry: null,
        name: r'finalDocumentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием списка финальных документов

  FinalDocumentsNotifierProvider call(String projectId) =>
      FinalDocumentsNotifierProvider._(argument: projectId, from: this);

  @override
  String toString() => r'finalDocumentsProvider';
}

/// Notifier для управления состоянием списка финальных документов

abstract class _$FinalDocumentsNotifier
    extends $AsyncNotifier<FinalDocumentsState> {
  late final _$args = ref.$arg as String;
  String get projectId => _$args;

  FutureOr<FinalDocumentsState> build(String projectId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<FinalDocumentsState>, FinalDocumentsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FinalDocumentsState>, FinalDocumentsState>,
              AsyncValue<FinalDocumentsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием отдельного финального документа

@ProviderFor(FinalDocumentNotifier)
const finalDocumentProvider = FinalDocumentNotifierFamily._();

/// Notifier для управления состоянием отдельного финального документа
final class FinalDocumentNotifierProvider
    extends $AsyncNotifierProvider<FinalDocumentNotifier, FinalDocumentState> {
  /// Notifier для управления состоянием отдельного финального документа
  const FinalDocumentNotifierProvider._({
    required FinalDocumentNotifierFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'finalDocumentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$finalDocumentNotifierHash();

  @override
  String toString() {
    return r'finalDocumentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FinalDocumentNotifier create() => FinalDocumentNotifier();

  @override
  bool operator ==(Object other) {
    return other is FinalDocumentNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$finalDocumentNotifierHash() =>
    r'2ad5ae54681cf2a76316e9ae602c5d98e9c90468';

/// Notifier для управления состоянием отдельного финального документа

final class FinalDocumentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FinalDocumentNotifier,
          AsyncValue<FinalDocumentState>,
          FinalDocumentState,
          FutureOr<FinalDocumentState>,
          (String, String)
        > {
  const FinalDocumentNotifierFamily._()
    : super(
        retry: null,
        name: r'finalDocumentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием отдельного финального документа

  FinalDocumentNotifierProvider call((String, String) params) =>
      FinalDocumentNotifierProvider._(argument: params, from: this);

  @override
  String toString() => r'finalDocumentProvider';
}

/// Notifier для управления состоянием отдельного финального документа

abstract class _$FinalDocumentNotifier
    extends $AsyncNotifier<FinalDocumentState> {
  late final _$args = ref.$arg as (String, String);
  (String, String) get params => _$args;

  FutureOr<FinalDocumentState> build((String, String) params);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<FinalDocumentState>, FinalDocumentState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FinalDocumentState>, FinalDocumentState>,
              AsyncValue<FinalDocumentState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
