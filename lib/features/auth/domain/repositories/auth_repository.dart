import 'package:mosstroinform_mobile/features/auth/domain/entities/user.dart';

/// Интерфейс репозитория авторизации
abstract class AuthRepository {
  /// Вход в систему
  /// Возвращает токен доступа при успешной авторизации
  /// Выбрасывает Failure при ошибке
  Future<String> login(String email, String password);

  /// Регистрация нового пользователя
  /// Возвращает токен доступа при успешной регистрации
  /// Выбрасывает Failure при ошибке
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  });

  /// Выход из системы
  /// Выбрасывает Failure при ошибке
  Future<void> logout();

  /// Получить текущего пользователя
  /// Выбрасывает Failure при ошибке
  Future<User> getCurrentUser();

  /// Проверить, авторизован ли пользователь
  Future<bool> isAuthenticated();

  /// Получить токен доступа
  Future<String?> getAccessToken();

  /// Обновить токен доступа используя refresh token
  /// Выбрасывает Failure при ошибке
  Future<String> refreshToken();
}

