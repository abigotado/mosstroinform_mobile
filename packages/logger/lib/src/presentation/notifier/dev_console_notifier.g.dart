// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_console_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием dev console

@ProviderFor(DevConsoleNotifier)
const devConsoleProvider = DevConsoleNotifierProvider._();

/// Notifier для управления состоянием dev console
final class DevConsoleNotifierProvider
    extends $AsyncNotifierProvider<DevConsoleNotifier, DevConsoleState> {
  /// Notifier для управления состоянием dev console
  const DevConsoleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devConsoleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devConsoleNotifierHash();

  @$internal
  @override
  DevConsoleNotifier create() => DevConsoleNotifier();
}

String _$devConsoleNotifierHash() =>
    r'01e2d90c719e10c5a194b7f1f3b80ede6afe7e6c';

/// Notifier для управления состоянием dev console

abstract class _$DevConsoleNotifier extends $AsyncNotifier<DevConsoleState> {
  FutureOr<DevConsoleState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<DevConsoleState>, DevConsoleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DevConsoleState>, DevConsoleState>,
              AsyncValue<DevConsoleState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Провайдер репозитория для dev console

@ProviderFor(devConsoleRepository)
const devConsoleRepositoryProvider = DevConsoleRepositoryProvider._();

/// Провайдер репозитория для dev console

final class DevConsoleRepositoryProvider
    extends
        $FunctionalProvider<
          IDevConsoleRepository,
          IDevConsoleRepository,
          IDevConsoleRepository
        >
    with $Provider<IDevConsoleRepository> {
  /// Провайдер репозитория для dev console
  const DevConsoleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devConsoleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devConsoleRepositoryHash();

  @$internal
  @override
  $ProviderElement<IDevConsoleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IDevConsoleRepository create(Ref ref) {
    return devConsoleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDevConsoleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDevConsoleRepository>(value),
    );
  }
}

String _$devConsoleRepositoryHash() =>
    r'ddf3afdc4a7279a100aa1e72e7df42f4fe992fe4';
