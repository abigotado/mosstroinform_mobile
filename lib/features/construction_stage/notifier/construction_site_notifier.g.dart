// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием строительной площадки

@ProviderFor(ConstructionSiteNotifier)
const constructionSiteProvider = ConstructionSiteNotifierFamily._();

/// Notifier для управления состоянием строительной площадки
final class ConstructionSiteNotifierProvider
    extends
        $AsyncNotifierProvider<
          ConstructionSiteNotifier,
          ConstructionSiteState
        > {
  /// Notifier для управления состоянием строительной площадки
  const ConstructionSiteNotifierProvider._({
    required ConstructionSiteNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'constructionSiteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$constructionSiteNotifierHash();

  @override
  String toString() {
    return r'constructionSiteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConstructionSiteNotifier create() => ConstructionSiteNotifier();

  @override
  bool operator ==(Object other) {
    return other is ConstructionSiteNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$constructionSiteNotifierHash() =>
    r'd3c6a014526039413c9661cc2dd639a2a617c3f0';

/// Notifier для управления состоянием строительной площадки

final class ConstructionSiteNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ConstructionSiteNotifier,
          AsyncValue<ConstructionSiteState>,
          ConstructionSiteState,
          FutureOr<ConstructionSiteState>,
          String
        > {
  const ConstructionSiteNotifierFamily._()
    : super(
        retry: null,
        name: r'constructionSiteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием строительной площадки

  ConstructionSiteNotifierProvider call(String objectId) =>
      ConstructionSiteNotifierProvider._(argument: objectId, from: this);

  @override
  String toString() => r'constructionSiteProvider';
}

/// Notifier для управления состоянием строительной площадки

abstract class _$ConstructionSiteNotifier
    extends $AsyncNotifier<ConstructionSiteState> {
  late final _$args = ref.$arg as String;
  String get objectId => _$args;

  FutureOr<ConstructionSiteState> build(String objectId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<ConstructionSiteState>, ConstructionSiteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConstructionSiteState>,
                ConstructionSiteState
              >,
              AsyncValue<ConstructionSiteState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием списка камер

@ProviderFor(CamerasNotifier)
const camerasProvider = CamerasNotifierFamily._();

/// Notifier для управления состоянием списка камер
final class CamerasNotifierProvider
    extends $AsyncNotifierProvider<CamerasNotifier, CamerasState> {
  /// Notifier для управления состоянием списка камер
  const CamerasNotifierProvider._({
    required CamerasNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'camerasProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$camerasNotifierHash();

  @override
  String toString() {
    return r'camerasProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CamerasNotifier create() => CamerasNotifier();

  @override
  bool operator ==(Object other) {
    return other is CamerasNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$camerasNotifierHash() => r'e61fabf5684bc23fd4baae91b19a9fb25ebc3c56';

/// Notifier для управления состоянием списка камер

final class CamerasNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CamerasNotifier,
          AsyncValue<CamerasState>,
          CamerasState,
          FutureOr<CamerasState>,
          String
        > {
  const CamerasNotifierFamily._()
    : super(
        retry: null,
        name: r'camerasProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier для управления состоянием списка камер

  CamerasNotifierProvider call(String siteId) =>
      CamerasNotifierProvider._(argument: siteId, from: this);

  @override
  String toString() => r'camerasProvider';
}

/// Notifier для управления состоянием списка камер

abstract class _$CamerasNotifier extends $AsyncNotifier<CamerasState> {
  late final _$args = ref.$arg as String;
  String get siteId => _$args;

  FutureOr<CamerasState> build(String siteId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<CamerasState>, CamerasState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CamerasState>, CamerasState>,
              AsyncValue<CamerasState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
