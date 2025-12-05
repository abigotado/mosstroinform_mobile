// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием списка документов

@ProviderFor(DocumentsNotifier)
const documentsProvider = DocumentsNotifierProvider._();

/// Notifier для управления состоянием списка документов
final class DocumentsNotifierProvider
    extends $AsyncNotifierProvider<DocumentsNotifier, List<Document>> {
  /// Notifier для управления состоянием списка документов
  const DocumentsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentsNotifierHash();

  @$internal
  @override
  DocumentsNotifier create() => DocumentsNotifier();
}

String _$documentsNotifierHash() => r'199670653d5ccbcb866095a0239f9391d65e7f67';

/// Notifier для управления состоянием списка документов

abstract class _$DocumentsNotifier extends $AsyncNotifier<List<Document>> {
  FutureOr<List<Document>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Document>>, List<Document>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Document>>, List<Document>>,
              AsyncValue<List<Document>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием отдельного документа

@ProviderFor(DocumentNotifier)
const documentProvider = DocumentNotifierFamily._();

/// Notifier для управления состоянием отдельного документа
final class DocumentNotifierProvider
    extends $AsyncNotifierProvider<DocumentNotifier, Document?> {
  /// Notifier для управления состоянием отдельного документа
  const DocumentNotifierProvider._({
    required DocumentNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'documentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$documentNotifierHash();

  @override
  String toString() {
    return r'documentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DocumentNotifier create() => DocumentNotifier();

  @override
  bool operator ==(Object other) {
    return other is DocumentNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$documentNotifierHash() => r'e87f36e977db45ac7e1008e6f0fc201d1767b9aa';

/// Notifier для управления состоянием отдельного документа

final class DocumentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          DocumentNotifier,
          AsyncValue<Document?>,
          Document?,
          FutureOr<Document?>,
          String
        > {
  const DocumentNotifierFamily._()
    : super(
        retry: null,
        name: r'documentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием отдельного документа

  DocumentNotifierProvider call(String documentId) =>
      DocumentNotifierProvider._(argument: documentId, from: this);

  @override
  String toString() => r'documentProvider';
}

/// Notifier для управления состоянием отдельного документа

abstract class _$DocumentNotifier extends $AsyncNotifier<Document?> {
  late final _$args = ref.$arg as String;
  String get documentId => _$args;

  FutureOr<Document?> build(String documentId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Document?>, Document?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Document?>, Document?>,
              AsyncValue<Document?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
