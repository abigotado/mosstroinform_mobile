// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$documentsNotifierHash() => r'7246db5cae980a3f2cd0f54b678473a1079add4b';

/// Notifier для управления состоянием списка документов
///
/// Copied from [DocumentsNotifier].
@ProviderFor(DocumentsNotifier)
final documentsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      DocumentsNotifier,
      List<Document>
    >.internal(
      DocumentsNotifier.new,
      name: r'documentsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$documentsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DocumentsNotifier = AutoDisposeAsyncNotifier<List<Document>>;
String _$documentNotifierHash() => r'395ca2c330aa9bbd73dcaf8ee66c7dfa53c6fb96';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DocumentNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Document?> {
  late final String documentId;

  FutureOr<Document?> build(String documentId);
}

/// Notifier для управления состоянием отдельного документа
///
/// Copied from [DocumentNotifier].
@ProviderFor(DocumentNotifier)
const documentNotifierProvider = DocumentNotifierFamily();

/// Notifier для управления состоянием отдельного документа
///
/// Copied from [DocumentNotifier].
class DocumentNotifierFamily extends Family<AsyncValue<Document?>> {
  /// Notifier для управления состоянием отдельного документа
  ///
  /// Copied from [DocumentNotifier].
  const DocumentNotifierFamily();

  /// Notifier для управления состоянием отдельного документа
  ///
  /// Copied from [DocumentNotifier].
  DocumentNotifierProvider call(String documentId) {
    return DocumentNotifierProvider(documentId);
  }

  @override
  DocumentNotifierProvider getProviderOverride(
    covariant DocumentNotifierProvider provider,
  ) {
    return call(provider.documentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'documentNotifierProvider';
}

/// Notifier для управления состоянием отдельного документа
///
/// Copied from [DocumentNotifier].
class DocumentNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DocumentNotifier, Document?> {
  /// Notifier для управления состоянием отдельного документа
  ///
  /// Copied from [DocumentNotifier].
  DocumentNotifierProvider(String documentId)
    : this._internal(
        () => DocumentNotifier()..documentId = documentId,
        from: documentNotifierProvider,
        name: r'documentNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$documentNotifierHash,
        dependencies: DocumentNotifierFamily._dependencies,
        allTransitiveDependencies:
            DocumentNotifierFamily._allTransitiveDependencies,
        documentId: documentId,
      );

  DocumentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.documentId,
  }) : super.internal();

  final String documentId;

  @override
  FutureOr<Document?> runNotifierBuild(covariant DocumentNotifier notifier) {
    return notifier.build(documentId);
  }

  @override
  Override overrideWith(DocumentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DocumentNotifierProvider._internal(
        () => create()..documentId = documentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        documentId: documentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DocumentNotifier, Document?>
  createElement() {
    return _DocumentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DocumentNotifierProvider && other.documentId == documentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, documentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DocumentNotifierRef on AutoDisposeAsyncNotifierProviderRef<Document?> {
  /// The parameter `documentId` of this provider.
  String get documentId;
}

class _DocumentNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DocumentNotifier, Document?>
    with DocumentNotifierRef {
  _DocumentNotifierProviderElement(super.provider);

  @override
  String get documentId => (origin as DocumentNotifierProvider).documentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
