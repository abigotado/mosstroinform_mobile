import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
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
    return guard(() async {
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
    }, methodName: 'login');
  }

  @override
  Future<String> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    return guard(() async {
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
    }, methodName: 'register');
  }

  @override
  Future<void> logout() async {
    return guard(() async {
      // Удаляем токены из хранилища
      await secureStorage.delete(key: StorageKeys.accessToken);
      await secureStorage.delete(key: StorageKeys.refreshToken);
      await secureStorage.delete(key: StorageKeys.userId);
    }, methodName: 'logout');
  }

  @override
  Future<User> getCurrentUser() async {
    return guard(() async {
      final userModel = await remoteDataSource.getCurrentUser();
      return userModel.toEntity();
    }, methodName: 'getCurrentUser');
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
    return guard(() async {
      final refreshTokenValue =
          await secureStorage.read(key: StorageKeys.refreshToken);
      if (refreshTokenValue == null) {
        throw ValidationFailure('Refresh token не найден');
      }

      final response = await remoteDataSource.refreshToken(
        RefreshTokenRequest(refreshToken: refreshTokenValue),
      );

      // Сохраняем новые токены
      await secureStorage.write(
        key: StorageKeys.accessToken,
        value: response.accessToken,
      );
      await secureStorage.write(
        key: StorageKeys.refreshToken,
        value: response.refreshToken,
      );

      return response.accessToken;
    }, methodName: 'refreshToken');
  }
}

