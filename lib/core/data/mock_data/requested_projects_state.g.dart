// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_projects_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер состояния запрошенных проектов
/// Хранит ID проектов, по которым был отправлен запрос на строительство

@ProviderFor(RequestedProjectsState)
const requestedProjectsStateProvider = RequestedProjectsStateProvider._();

/// Провайдер состояния запрошенных проектов
/// Хранит ID проектов, по которым был отправлен запрос на строительство
final class RequestedProjectsStateProvider
    extends $NotifierProvider<RequestedProjectsState, Set<String>> {
  /// Провайдер состояния запрошенных проектов
  /// Хранит ID проектов, по которым был отправлен запрос на строительство
  const RequestedProjectsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestedProjectsStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestedProjectsStateHash();

  @$internal
  @override
  RequestedProjectsState create() => RequestedProjectsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$requestedProjectsStateHash() =>
    r'6fdc4eaeb33f69120e941ecdf78d90ae3c63d304';

/// Провайдер состояния запрошенных проектов
/// Хранит ID проектов, по которым был отправлен запрос на строительство

abstract class _$RequestedProjectsState extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
