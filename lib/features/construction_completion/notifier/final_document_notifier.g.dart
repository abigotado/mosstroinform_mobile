// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completionStatusNotifierHash() =>
    r'0ac96695d52bbf4dcb1fc80b53d06870984edfe4';

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

abstract class _$CompletionStatusNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CompletionStatusState> {
  late final String projectId;

  FutureOr<CompletionStatusState> build(String projectId);
}

/// Notifier для управления состоянием завершения строительства
///
/// Copied from [CompletionStatusNotifier].
@ProviderFor(CompletionStatusNotifier)
const completionStatusNotifierProvider = CompletionStatusNotifierFamily();

/// Notifier для управления состоянием завершения строительства
///
/// Copied from [CompletionStatusNotifier].
class CompletionStatusNotifierFamily
    extends Family<AsyncValue<CompletionStatusState>> {
  /// Notifier для управления состоянием завершения строительства
  ///
  /// Copied from [CompletionStatusNotifier].
  const CompletionStatusNotifierFamily();

  /// Notifier для управления состоянием завершения строительства
  ///
  /// Copied from [CompletionStatusNotifier].
  CompletionStatusNotifierProvider call(String projectId) {
    return CompletionStatusNotifierProvider(projectId);
  }

  @override
  CompletionStatusNotifierProvider getProviderOverride(
    covariant CompletionStatusNotifierProvider provider,
  ) {
    return call(provider.projectId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'completionStatusNotifierProvider';
}

/// Notifier для управления состоянием завершения строительства
///
/// Copied from [CompletionStatusNotifier].
class CompletionStatusNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CompletionStatusNotifier,
          CompletionStatusState
        > {
  /// Notifier для управления состоянием завершения строительства
  ///
  /// Copied from [CompletionStatusNotifier].
  CompletionStatusNotifierProvider(String projectId)
    : this._internal(
        () => CompletionStatusNotifier()..projectId = projectId,
        from: completionStatusNotifierProvider,
        name: r'completionStatusNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$completionStatusNotifierHash,
        dependencies: CompletionStatusNotifierFamily._dependencies,
        allTransitiveDependencies:
            CompletionStatusNotifierFamily._allTransitiveDependencies,
        projectId: projectId,
      );

  CompletionStatusNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  FutureOr<CompletionStatusState> runNotifierBuild(
    covariant CompletionStatusNotifier notifier,
  ) {
    return notifier.build(projectId);
  }

  @override
  Override overrideWith(CompletionStatusNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompletionStatusNotifierProvider._internal(
        () => create()..projectId = projectId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    CompletionStatusNotifier,
    CompletionStatusState
  >
  createElement() {
    return _CompletionStatusNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompletionStatusNotifierProvider &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CompletionStatusNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CompletionStatusState> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _CompletionStatusNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CompletionStatusNotifier,
          CompletionStatusState
        >
    with CompletionStatusNotifierRef {
  _CompletionStatusNotifierProviderElement(super.provider);

  @override
  String get projectId =>
      (origin as CompletionStatusNotifierProvider).projectId;
}

String _$finalDocumentsNotifierHash() =>
    r'3ba3323b00ad63156b6a76f405ad6bb25f7ec244';

abstract class _$FinalDocumentsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<FinalDocumentsState> {
  late final String projectId;

  FutureOr<FinalDocumentsState> build(String projectId);
}

/// Notifier для управления состоянием списка финальных документов
///
/// Copied from [FinalDocumentsNotifier].
@ProviderFor(FinalDocumentsNotifier)
const finalDocumentsNotifierProvider = FinalDocumentsNotifierFamily();

/// Notifier для управления состоянием списка финальных документов
///
/// Copied from [FinalDocumentsNotifier].
class FinalDocumentsNotifierFamily
    extends Family<AsyncValue<FinalDocumentsState>> {
  /// Notifier для управления состоянием списка финальных документов
  ///
  /// Copied from [FinalDocumentsNotifier].
  const FinalDocumentsNotifierFamily();

  /// Notifier для управления состоянием списка финальных документов
  ///
  /// Copied from [FinalDocumentsNotifier].
  FinalDocumentsNotifierProvider call(String projectId) {
    return FinalDocumentsNotifierProvider(projectId);
  }

  @override
  FinalDocumentsNotifierProvider getProviderOverride(
    covariant FinalDocumentsNotifierProvider provider,
  ) {
    return call(provider.projectId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'finalDocumentsNotifierProvider';
}

/// Notifier для управления состоянием списка финальных документов
///
/// Copied from [FinalDocumentsNotifier].
class FinalDocumentsNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          FinalDocumentsNotifier,
          FinalDocumentsState
        > {
  /// Notifier для управления состоянием списка финальных документов
  ///
  /// Copied from [FinalDocumentsNotifier].
  FinalDocumentsNotifierProvider(String projectId)
    : this._internal(
        () => FinalDocumentsNotifier()..projectId = projectId,
        from: finalDocumentsNotifierProvider,
        name: r'finalDocumentsNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$finalDocumentsNotifierHash,
        dependencies: FinalDocumentsNotifierFamily._dependencies,
        allTransitiveDependencies:
            FinalDocumentsNotifierFamily._allTransitiveDependencies,
        projectId: projectId,
      );

  FinalDocumentsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  FutureOr<FinalDocumentsState> runNotifierBuild(
    covariant FinalDocumentsNotifier notifier,
  ) {
    return notifier.build(projectId);
  }

  @override
  Override overrideWith(FinalDocumentsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FinalDocumentsNotifierProvider._internal(
        () => create()..projectId = projectId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    FinalDocumentsNotifier,
    FinalDocumentsState
  >
  createElement() {
    return _FinalDocumentsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinalDocumentsNotifierProvider &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FinalDocumentsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<FinalDocumentsState> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _FinalDocumentsNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          FinalDocumentsNotifier,
          FinalDocumentsState
        >
    with FinalDocumentsNotifierRef {
  _FinalDocumentsNotifierProviderElement(super.provider);

  @override
  String get projectId => (origin as FinalDocumentsNotifierProvider).projectId;
}

String _$finalDocumentNotifierHash() =>
    r'3426098d603db1567fe5e52c2c04ef24f4e199ac';

abstract class _$FinalDocumentNotifier
    extends BuildlessAutoDisposeAsyncNotifier<FinalDocumentState> {
  late final (String, String) params;

  FutureOr<FinalDocumentState> build((String, String) params);
}

/// Notifier для управления состоянием отдельного финального документа
///
/// Copied from [FinalDocumentNotifier].
@ProviderFor(FinalDocumentNotifier)
const finalDocumentNotifierProvider = FinalDocumentNotifierFamily();

/// Notifier для управления состоянием отдельного финального документа
///
/// Copied from [FinalDocumentNotifier].
class FinalDocumentNotifierFamily
    extends Family<AsyncValue<FinalDocumentState>> {
  /// Notifier для управления состоянием отдельного финального документа
  ///
  /// Copied from [FinalDocumentNotifier].
  const FinalDocumentNotifierFamily();

  /// Notifier для управления состоянием отдельного финального документа
  ///
  /// Copied from [FinalDocumentNotifier].
  FinalDocumentNotifierProvider call((String, String) params) {
    return FinalDocumentNotifierProvider(params);
  }

  @override
  FinalDocumentNotifierProvider getProviderOverride(
    covariant FinalDocumentNotifierProvider provider,
  ) {
    return call(provider.params);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'finalDocumentNotifierProvider';
}

/// Notifier для управления состоянием отдельного финального документа
///
/// Copied from [FinalDocumentNotifier].
class FinalDocumentNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          FinalDocumentNotifier,
          FinalDocumentState
        > {
  /// Notifier для управления состоянием отдельного финального документа
  ///
  /// Copied from [FinalDocumentNotifier].
  FinalDocumentNotifierProvider((String, String) params)
    : this._internal(
        () => FinalDocumentNotifier()..params = params,
        from: finalDocumentNotifierProvider,
        name: r'finalDocumentNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$finalDocumentNotifierHash,
        dependencies: FinalDocumentNotifierFamily._dependencies,
        allTransitiveDependencies:
            FinalDocumentNotifierFamily._allTransitiveDependencies,
        params: params,
      );

  FinalDocumentNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final (String, String) params;

  @override
  FutureOr<FinalDocumentState> runNotifierBuild(
    covariant FinalDocumentNotifier notifier,
  ) {
    return notifier.build(params);
  }

  @override
  Override overrideWith(FinalDocumentNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FinalDocumentNotifierProvider._internal(
        () => create()..params = params,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    FinalDocumentNotifier,
    FinalDocumentState
  >
  createElement() {
    return _FinalDocumentNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FinalDocumentNotifierProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FinalDocumentNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<FinalDocumentState> {
  /// The parameter `params` of this provider.
  (String, String) get params;
}

class _FinalDocumentNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          FinalDocumentNotifier,
          FinalDocumentState
        >
    with FinalDocumentNotifierRef {
  _FinalDocumentNotifierProviderElement(super.provider);

  @override
  (String, String) get params =>
      (origin as FinalDocumentNotifierProvider).params;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
