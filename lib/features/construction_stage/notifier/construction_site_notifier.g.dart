// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$constructionSiteNotifierHash() =>
    r'f0d839a7154635dacd608f39f660197f47a0f459';

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

abstract class _$ConstructionSiteNotifier
    extends BuildlessAutoDisposeAsyncNotifier<ConstructionSiteState> {
  late final String projectId;

  FutureOr<ConstructionSiteState> build(String projectId);
}

/// Notifier для управления состоянием строительной площадки
///
/// Copied from [ConstructionSiteNotifier].
@ProviderFor(ConstructionSiteNotifier)
const constructionSiteNotifierProvider = ConstructionSiteNotifierFamily();

/// Notifier для управления состоянием строительной площадки
///
/// Copied from [ConstructionSiteNotifier].
class ConstructionSiteNotifierFamily
    extends Family<AsyncValue<ConstructionSiteState>> {
  /// Notifier для управления состоянием строительной площадки
  ///
  /// Copied from [ConstructionSiteNotifier].
  const ConstructionSiteNotifierFamily();

  /// Notifier для управления состоянием строительной площадки
  ///
  /// Copied from [ConstructionSiteNotifier].
  ConstructionSiteNotifierProvider call(String projectId) {
    return ConstructionSiteNotifierProvider(projectId);
  }

  @override
  ConstructionSiteNotifierProvider getProviderOverride(
    covariant ConstructionSiteNotifierProvider provider,
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
  String? get name => r'constructionSiteNotifierProvider';
}

/// Notifier для управления состоянием строительной площадки
///
/// Copied from [ConstructionSiteNotifier].
class ConstructionSiteNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ConstructionSiteNotifier,
          ConstructionSiteState
        > {
  /// Notifier для управления состоянием строительной площадки
  ///
  /// Copied from [ConstructionSiteNotifier].
  ConstructionSiteNotifierProvider(String projectId)
    : this._internal(
        () => ConstructionSiteNotifier()..projectId = projectId,
        from: constructionSiteNotifierProvider,
        name: r'constructionSiteNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$constructionSiteNotifierHash,
        dependencies: ConstructionSiteNotifierFamily._dependencies,
        allTransitiveDependencies:
            ConstructionSiteNotifierFamily._allTransitiveDependencies,
        projectId: projectId,
      );

  ConstructionSiteNotifierProvider._internal(
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
  FutureOr<ConstructionSiteState> runNotifierBuild(
    covariant ConstructionSiteNotifier notifier,
  ) {
    return notifier.build(projectId);
  }

  @override
  Override overrideWith(ConstructionSiteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConstructionSiteNotifierProvider._internal(
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
    ConstructionSiteNotifier,
    ConstructionSiteState
  >
  createElement() {
    return _ConstructionSiteNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConstructionSiteNotifierProvider &&
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
mixin ConstructionSiteNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<ConstructionSiteState> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _ConstructionSiteNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ConstructionSiteNotifier,
          ConstructionSiteState
        >
    with ConstructionSiteNotifierRef {
  _ConstructionSiteNotifierProviderElement(super.provider);

  @override
  String get projectId =>
      (origin as ConstructionSiteNotifierProvider).projectId;
}

String _$camerasNotifierHash() => r'e61fabf5684bc23fd4baae91b19a9fb25ebc3c56';

abstract class _$CamerasNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CamerasState> {
  late final String siteId;

  FutureOr<CamerasState> build(String siteId);
}

/// Notifier для управления состоянием списка камер
///
/// Copied from [CamerasNotifier].
@ProviderFor(CamerasNotifier)
const camerasNotifierProvider = CamerasNotifierFamily();

/// Notifier для управления состоянием списка камер
///
/// Copied from [CamerasNotifier].
class CamerasNotifierFamily extends Family<AsyncValue<CamerasState>> {
  /// Notifier для управления состоянием списка камер
  ///
  /// Copied from [CamerasNotifier].
  const CamerasNotifierFamily();

  /// Notifier для управления состоянием списка камер
  ///
  /// Copied from [CamerasNotifier].
  CamerasNotifierProvider call(String siteId) {
    return CamerasNotifierProvider(siteId);
  }

  @override
  CamerasNotifierProvider getProviderOverride(
    covariant CamerasNotifierProvider provider,
  ) {
    return call(provider.siteId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'camerasNotifierProvider';
}

/// Notifier для управления состоянием списка камер
///
/// Copied from [CamerasNotifier].
class CamerasNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<CamerasNotifier, CamerasState> {
  /// Notifier для управления состоянием списка камер
  ///
  /// Copied from [CamerasNotifier].
  CamerasNotifierProvider(String siteId)
    : this._internal(
        () => CamerasNotifier()..siteId = siteId,
        from: camerasNotifierProvider,
        name: r'camerasNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$camerasNotifierHash,
        dependencies: CamerasNotifierFamily._dependencies,
        allTransitiveDependencies:
            CamerasNotifierFamily._allTransitiveDependencies,
        siteId: siteId,
      );

  CamerasNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.siteId,
  }) : super.internal();

  final String siteId;

  @override
  FutureOr<CamerasState> runNotifierBuild(covariant CamerasNotifier notifier) {
    return notifier.build(siteId);
  }

  @override
  Override overrideWith(CamerasNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CamerasNotifierProvider._internal(
        () => create()..siteId = siteId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        siteId: siteId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CamerasNotifier, CamerasState>
  createElement() {
    return _CamerasNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CamerasNotifierProvider && other.siteId == siteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, siteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CamerasNotifierRef on AutoDisposeAsyncNotifierProviderRef<CamerasState> {
  /// The parameter `siteId` of this provider.
  String get siteId;
}

class _CamerasNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<CamerasNotifier, CamerasState>
    with CamerasNotifierRef {
  _CamerasNotifierProviderElement(super.provider);

  @override
  String get siteId => (origin as CamerasNotifierProvider).siteId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
