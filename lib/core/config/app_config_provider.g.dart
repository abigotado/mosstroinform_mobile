// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для конфигурации приложения

@ProviderFor(appConfigSimple)
const appConfigSimpleProvider = AppConfigSimpleProvider._();

/// Провайдер для конфигурации приложения

final class AppConfigSimpleProvider
    extends
        $FunctionalProvider<AppConfigSimple, AppConfigSimple, AppConfigSimple>
    with $Provider<AppConfigSimple> {
  /// Провайдер для конфигурации приложения
  const AppConfigSimpleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigSimpleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigSimpleHash();

  @$internal
  @override
  $ProviderElement<AppConfigSimple> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppConfigSimple create(Ref ref) {
    return appConfigSimple(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfigSimple value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfigSimple>(value),
    );
  }
}

String _$appConfigSimpleHash() => r'0f51be39cd505c8c8393c7da0960dda5073fe05f';
