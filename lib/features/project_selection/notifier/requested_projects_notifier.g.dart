// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requested_projects_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием запрошенных проектов

@ProviderFor(RequestedProjectsNotifier)
const requestedProjectsProvider = RequestedProjectsNotifierProvider._();

/// Notifier для управления состоянием запрошенных проектов
final class RequestedProjectsNotifierProvider
    extends $AsyncNotifierProvider<RequestedProjectsNotifier, List<Project>> {
  /// Notifier для управления состоянием запрошенных проектов
  const RequestedProjectsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestedProjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestedProjectsNotifierHash();

  @$internal
  @override
  RequestedProjectsNotifier create() => RequestedProjectsNotifier();
}

String _$requestedProjectsNotifierHash() =>
    r'542daad9023da5a00ea0fbf29a406c3e2213e7f2';

/// Notifier для управления состоянием запрошенных проектов

abstract class _$RequestedProjectsNotifier
    extends $AsyncNotifier<List<Project>> {
  FutureOr<List<Project>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Project>>, List<Project>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Project>>, List<Project>>,
              AsyncValue<List<Project>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Провайдер для проверки, запрошен ли проект

@ProviderFor(isProjectRequested)
const isProjectRequestedProvider = IsProjectRequestedFamily._();

/// Провайдер для проверки, запрошен ли проект

final class IsProjectRequestedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Провайдер для проверки, запрошен ли проект
  const IsProjectRequestedProvider._({
    required IsProjectRequestedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isProjectRequestedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isProjectRequestedHash();

  @override
  String toString() {
    return r'isProjectRequestedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return isProjectRequested(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IsProjectRequestedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isProjectRequestedHash() =>
    r'0fc474f500838ee5a17dac167dd4db3dc72ba664';

/// Провайдер для проверки, запрошен ли проект

final class IsProjectRequestedFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const IsProjectRequestedFamily._()
    : super(
        retry: null,
        name: r'isProjectRequestedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Провайдер для проверки, запрошен ли проект

  IsProjectRequestedProvider call(String projectId) =>
      IsProjectRequestedProvider._(argument: projectId, from: this);

  @override
  String toString() => r'isProjectRequestedProvider';
}
