// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием авторизации
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние авторизации должно сохраняться

@ProviderFor(AuthNotifier)
const authProvider = AuthNotifierProvider._();

/// Notifier для управления состоянием авторизации
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние авторизации должно сохраняться
final class AuthNotifierProvider
    extends $AsyncNotifierProvider<AuthNotifier, AuthState> {
  /// Notifier для управления состоянием авторизации
  /// keepAlive: true - провайдер не должен быть disposed автоматически,
  /// так как состояние авторизации должно сохраняться
  const AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();
}

String _$authNotifierHash() => r'e727bd5163e72c3d32bc4c821511f75b25f1ebaa';

/// Notifier для управления состоянием авторизации
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние авторизации должно сохраняться

abstract class _$AuthNotifier extends $AsyncNotifier<AuthState> {
  FutureOr<AuthState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthState>, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthState>, AuthState>,
              AsyncValue<AuthState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
