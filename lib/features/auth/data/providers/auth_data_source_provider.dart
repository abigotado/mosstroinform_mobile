import 'package:dio/dio.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/network/auth_interceptor.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';
import 'package:mosstroinform_mobile/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_source_provider.g.dart';

/// Провайдер для Dio клиента с авторизацией
@riverpod
Dio authDio(Ref ref) {
  final baseDio = ref.watch(dioProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  // Создаём новый Dio с interceptor для авторизации
  // Копируем все interceptors из baseDio (включая логгер)
  final dio = Dio(baseDio.options);
  dio.interceptors.addAll(baseDio.interceptors);

  // Создаем временный AuthRemoteDataSource для обновления токена
  // (избегаем циклической зависимости с authRepositoryProvider)
  final tempDataSource = AuthRemoteDataSource(
    dio,
    baseUrl: AppConstants.baseUrl,
  );

  dio.interceptors.add(
    AuthInterceptor(
      secureStorage: secureStorage,
      refreshTokenCallback: () async {
        // Функция для обновления токена через временный data source
        final refreshTokenValue = await secureStorage.read(
          key: StorageKeys.refreshToken,
        );
        if (refreshTokenValue == null) {
          throw Exception('Refresh token не найден');
        }
        final response = await tempDataSource.refreshToken(
          RefreshTokenRequest(refreshToken: refreshTokenValue),
        );
        await secureStorage.write(
          key: StorageKeys.accessToken,
          value: response.accessToken,
        );
        await secureStorage.write(
          key: StorageKeys.refreshToken,
          value: response.refreshToken,
        );
        return response.accessToken;
      },
    ),
  );

  return dio;
}

/// Провайдер для удалённого источника данных авторизации
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(authDioProvider);
  return AuthRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}
