import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/auth/domain/entities/user.dart';
import 'package:mosstroinform_mobile/features/auth/domain/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';

/// Состояние авторизации
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(null) User? user,
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    @Default(null) Failure? error,
  }) = _AuthState;
}

/// Notifier для управления состоянием авторизации
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние авторизации должно сохраняться
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthState> build() async {
    // Проверяем авторизацию при инициализации
    final repository = ref.read(authRepositoryProvider);
    final isAuthenticated = await repository.isAuthenticated();

    if (isAuthenticated) {
      try {
        final user = await repository.getCurrentUser();
        return AuthState(user: user, isAuthenticated: true);
      } catch (e) {
        AppLogger.error('Ошибка при получении пользователя: $e');
        return const AuthState(isAuthenticated: false);
      }
    }

    return const AuthState(isAuthenticated: false);
  }

  /// Вход в систему
  Future<void> login(String email, String password) async {
    AppLogger.info('AuthNotifier.login: начало, ref.mounted=${ref.mounted}');
    if (!ref.mounted) {
      AppLogger.warning('AuthNotifier.login: провайдер не mounted, выход');
      return;
    }
    state = const AsyncValue.loading();
    AppLogger.info('AuthNotifier.login: состояние установлено в loading');

    try {
      AppLogger.info('AuthNotifier.login: получение репозитория');
      final repository = ref.read(authRepositoryProvider);
      AppLogger.info('AuthNotifier.login: вызов repository.login');
      await repository.login(email, password);
      AppLogger.info(
        'AuthNotifier.login: repository.login завершен, ref.mounted=${ref.mounted}',
      );

      if (!ref.mounted) {
        AppLogger.warning(
          'AuthNotifier.login: провайдер disposed после login, выход',
        );
        return;
      }

      // Получаем данные пользователя
      final user = await repository.getCurrentUser();

      if (!ref.mounted) return;

      state = AsyncValue.data(AuthState(user: user, isAuthenticated: true));

      AppLogger.info('Пользователь успешно авторизован: ${user.email}');
    } on Failure catch (e) {
      if (!ref.mounted) return;
      AppLogger.error('Ошибка авторизации: ${e.message}');
      state = AsyncValue.data(const AuthState().copyWith(isAuthenticated: false, error: e));
      rethrow;
    } catch (e, stackTrace) {
      if (!ref.mounted) return;
      AppLogger.error('Неизвестная ошибка при авторизации: $e', stackTrace);
      state = AsyncValue.data(
        const AuthState().copyWith(
          isAuthenticated: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
      rethrow;
    }
  }

  /// Регистрация нового пользователя
  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    if (!ref.mounted) return;
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

      if (!ref.mounted) return;

      // Получаем данные пользователя
      final user = await repository.getCurrentUser();

      if (!ref.mounted) return;

      state = AsyncValue.data(AuthState(user: user, isAuthenticated: true));

      AppLogger.info('Пользователь успешно зарегистрирован: ${user.email}');
    } on Failure catch (e) {
      if (!ref.mounted) return;
      AppLogger.error('Ошибка регистрации: ${e.message}');
      state = AsyncValue.data(const AuthState().copyWith(isAuthenticated: false, error: e));
      rethrow;
    } catch (e, stackTrace) {
      if (!ref.mounted) return;
      AppLogger.error('Неизвестная ошибка при регистрации: $e', stackTrace);
      state = AsyncValue.data(
        const AuthState().copyWith(
          isAuthenticated: false,
          error: UnknownFailure('Неизвестная ошибка: $e'),
        ),
      );
      rethrow;
    }
  }

  /// Выход из системы
  Future<void> logout() async {
    if (!ref.mounted) return;

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.logout();

      if (!ref.mounted) return;

      state = const AsyncValue.data(AuthState(isAuthenticated: false));

      AppLogger.info('Пользователь вышел из системы');
    } catch (e) {
      if (!ref.mounted) return;
      AppLogger.error('Ошибка при выходе: $e');
      // Даже при ошибке сбрасываем состояние
      state = const AsyncValue.data(AuthState(isAuthenticated: false));
    }
  }

  /// Проверить авторизацию
  Future<void> checkAuth() async {
    if (!ref.mounted) return;

    try {
      final repository = ref.read(authRepositoryProvider);
      final isAuthenticated = await repository.isAuthenticated();

      if (!ref.mounted) return;

      if (isAuthenticated) {
        final user = await repository.getCurrentUser();

        if (!ref.mounted) return;

        state = AsyncValue.data(AuthState(user: user, isAuthenticated: true));
      } else {
        state = const AsyncValue.data(AuthState(isAuthenticated: false));
      }
    } catch (e) {
      if (!ref.mounted) return;
      AppLogger.error('Ошибка при проверке авторизации: $e');
      state = const AsyncValue.data(AuthState(isAuthenticated: false));
    }
  }
}
