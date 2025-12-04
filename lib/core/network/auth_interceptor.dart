import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';

/// Interceptor для добавления токена авторизации в заголовки запросов
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read(key: StorageKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Если получили 401, возможно токен истёк - можно попробовать обновить
    if (err.response?.statusCode == 401) {
      // TODO: Реализовать обновление токена при необходимости
    }
    handler.next(err);
  }
}
