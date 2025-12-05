import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/auth/domain/entities/user.dart';
import 'package:mosstroinform_mobile/features/auth/domain/repositories/auth_repository.dart';

/// Mock реализация репозитория авторизации для тестирования
class MockAuthRepository implements AuthRepository {
  final FlutterSecureStorage secureStorage;
  
  // Mock данные пользователей
  static const _mockUsers = {
    'test@example.com': {
      'password': 'password123',
      'id': 'user1',
      'name': 'Тестовый Пользователь',
      'phone': '+7 (999) 123-45-67',
    },
    'admin@example.com': {
      'password': 'admin123',
      'id': 'user2',
      'name': 'Администратор',
      'phone': null,
    },
  };

  MockAuthRepository({required this.secureStorage});

  @override
  Future<String> login(String email, String password) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    
    final userData = _mockUsers[email];
    if (userData == null || userData['password'] != password) {
      throw ValidationFailure('Неверный email или пароль');
    }
    
    // Генерируем mock токен
    final token = 'mock_token_${userData['id']}_${DateTime.now().millisecondsSinceEpoch}';
    
    // Сохраняем токены
    await secureStorage.write(key: StorageKeys.accessToken, value: token);
    await secureStorage.write(key: StorageKeys.refreshToken, value: 'refresh_$token');
    await secureStorage.write(key: StorageKeys.userId, value: userData['id'] as String);
    
    // Очищаем базу данных при логине, чтобы начать с чистого листа
    // Проекты загрузятся автоматически при первом обращении к списку проектов
    try {
      final flavor = AppConfigSimple.getFlavor();
      final config = AppConfigSimple.fromFlavor(flavor);
      if (config.useMocks) {
        await HiveService.clearUserData();
        AppLogger.info('MockAuthRepository.login: моковая база данных очищена, будет создана с нуля');
      }
    } catch (e) {
      AppLogger.warning('MockAuthRepository.login: ошибка при очистке базы данных: $e');
      // Не прерываем логин, даже если очистка не удалась
    }
    
    return token;
  }

  @override
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_mockUsers.containsKey(email)) {
      throw ValidationFailure('Пользователь с таким email уже существует');
    }
    
    if (password.length < 6) {
      throw ValidationFailure('Пароль должен содержать минимум 6 символов');
    }
    
    // Генерируем новый ID
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final token = 'mock_token_$userId';
    
    // Сохраняем токены
    await secureStorage.write(key: StorageKeys.accessToken, value: token);
    await secureStorage.write(key: StorageKeys.refreshToken, value: 'refresh_$token');
    await secureStorage.write(key: StorageKeys.userId, value: userId);
    
    // Очищаем базу данных при регистрации, чтобы начать с чистого листа
    // Проекты загрузятся автоматически при первом обращении к списку проектов
    try {
      final flavor = AppConfigSimple.getFlavor();
      final config = AppConfigSimple.fromFlavor(flavor);
      if (config.useMocks) {
        await HiveService.clearUserData();
        AppLogger.info('MockAuthRepository.register: моковая база данных очищена, будет создана с нуля');
      }
    } catch (e) {
      AppLogger.warning('MockAuthRepository.register: ошибка при очистке базы данных: $e');
      // Не прерываем регистрацию, даже если очистка не удалась
    }
    
    return token;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Очищаем токены
    await secureStorage.delete(key: StorageKeys.accessToken);
    await secureStorage.delete(key: StorageKeys.refreshToken);
    await secureStorage.delete(key: StorageKeys.userId);
    
    // Очищаем всю моковую базу данных при logout (только в моковом режиме)
    // При новом логине база будет создана с нуля
    try {
      final flavor = AppConfigSimple.getFlavor();
      final config = AppConfigSimple.fromFlavor(flavor);
      if (config.useMocks) {
        await HiveService.clearUserData();
        AppLogger.info('MockAuthRepository.logout: вся моковая база данных очищена, будет создана с нуля при следующем логине');
      }
    } catch (e) {
      AppLogger.warning('MockAuthRepository.logout: ошибка при очистке базы данных: $e');
      // Не прерываем logout, даже если очистка базы не удалась
    }
  }

  @override
  Future<User> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final userId = await secureStorage.read(key: StorageKeys.userId);
    if (userId == null) {
      throw ValidationFailure('Требуется авторизация');
    }
    
    // Ищем пользователя в mock данных
    final userEntry = _mockUsers.entries.firstWhere(
      (entry) => entry.value['id'] == userId,
      orElse: () => _mockUsers.entries.first,
    );
    
    return User(
      id: userEntry.value['id']!,
      email: userEntry.key,
      name: userEntry.value['name']!,
      phone: userEntry.value['phone'],
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await secureStorage.read(key: StorageKeys.accessToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: StorageKeys.accessToken);
  }

  @override
  Future<String> refreshToken() async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    final refreshTokenValue =
        await secureStorage.read(key: StorageKeys.refreshToken);
    if (refreshTokenValue == null) {
      throw ValidationFailure('Refresh token не найден');
    }

    // Генерируем новый mock токен
    final newToken =
        'mock_token_refreshed_${DateTime.now().millisecondsSinceEpoch}';
    final newRefreshToken = 'refresh_$newToken';

    // Сохраняем новые токены
    await secureStorage.write(key: StorageKeys.accessToken, value: newToken);
    await secureStorage.write(
      key: StorageKeys.refreshToken,
      value: newRefreshToken,
    );

    return newToken;
  }
}

