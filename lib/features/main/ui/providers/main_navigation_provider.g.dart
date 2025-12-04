// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для индекса текущей вкладки в главном экране

@ProviderFor(MainNavigationIndex)
const mainNavigationIndexProvider = MainNavigationIndexProvider._();

/// Провайдер для индекса текущей вкладки в главном экране
final class MainNavigationIndexProvider
    extends $NotifierProvider<MainNavigationIndex, int> {
  /// Провайдер для индекса текущей вкладки в главном экране
  const MainNavigationIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainNavigationIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainNavigationIndexHash();

  @$internal
  @override
  MainNavigationIndex create() => MainNavigationIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainNavigationIndexHash() =>
    r'48006f27c8b3820777e6b2d46986d9e7ba24e1f8';

/// Провайдер для индекса текущей вкладки в главном экране

abstract class _$MainNavigationIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
