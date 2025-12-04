import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';
import 'package:mosstroinform_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/auth/data/models/user_model.dart';
import 'package:mosstroinform_mobile/features/auth/domain/entities/user.dart';
import 'package:mosstroinform_mobile/features/auth/domain/repositories/auth_repository.dart';

/// Реализация репозитория авторизации
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await remoteDataSource.login(
        LoginRequest(email: email, password: password),
      );
      
      // Сохраняем токены
      await secureStorage.write(
        key: StorageKeys.accessToken,
        value: response.accessToken,
      );
      await secureStorage.write(
        key: StorageKeys.refreshToken,
        value: response.refreshToken,
      );
      await secureStorage.write(
        key: StorageKeys.userId,
        value: response.user.id,
      );
      
      return response.accessToken;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ValidationFailure('Неверный email или пароль');
      } else if (e.response?.statusCode == 404) {
        throw ValidationFailure('Пользователь не найден');
      } else {
        throw NetworkFailure('Ошибка сети: ${e.message}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw UnknownFailure('Ошибка при входе: $e');
    }
  }

  @override
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    try {
      final response = await remoteDataSource.register(
        RegisterRequest(
          email: email,
          password: password,
          name: name,
          phone: phone,
        ),
      );
      
      // Сохраняем токены
      await secureStorage.write(
        key: StorageKeys.accessToken,
        value: response.accessToken,
      );
      await secureStorage.write(
        key: StorageKeys.refreshToken,
        value: response.refreshToken,
      );
      await secureStorage.write(
        key: StorageKeys.userId,
        value: response.user.id,
      );
      
      return response.accessToken;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ValidationFailure(
          e.response?.data['message'] as String? ?? 'Неверные данные',
        );
      } else if (e.response?.statusCode == 409) {
        throw ValidationFailure('Пользователь с таким email уже существует');
      } else {
        throw NetworkFailure('Ошибка сети: ${e.message}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw UnknownFailure('Ошибка при регистрации: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Удаляем токены из хранилища
      await secureStorage.delete(key: StorageKeys.accessToken);
      await secureStorage.delete(key: StorageKeys.refreshToken);
      await secureStorage.delete(key: StorageKeys.userId);
    } catch (e) {
      throw UnknownFailure('Ошибка при выходе: $e');
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return userModel.toEntity();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ValidationFailure('Требуется авторизация');
      } else {
        throw NetworkFailure('Ошибка сети: ${e.message}');
      }
    } catch (e) {
      if (e is Failure) rethrow;
      throw UnknownFailure('Ошибка при получении пользователя: $e');
    }
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
}

