import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';

/// Interceptor для добавления токена авторизации в заголовки запросов
/// и автоматического обновления токена при получении 401
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Future<String> Function() refreshTokenCallback;
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];

  AuthInterceptor({
    required this.secureStorage,
    required this.refreshTokenCallback,
  });

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
    // Если получили 401, пытаемся обновить токен
    if (err.response?.statusCode == 401) {
      final requestOptions = err.requestOptions;

      // Если это запрос на обновление токена, не пытаемся обновить снова
      if (requestOptions.path == '/auth/refresh') {
        handler.next(err);
        return;
      }

      // Если уже обновляем токен, добавляем запрос в очередь
      if (_isRefreshing) {
        _pendingRequests.add(_PendingRequest(
          requestOptions: requestOptions,
          handler: handler,
        ));
        return;
      }

      _isRefreshing = true;

      try {
        // Обновляем токен через callback
        await refreshTokenCallback();

        // Повторяем оригинальный запрос с новым токеном
        final token = await secureStorage.read(key: StorageKeys.accessToken);
        requestOptions.headers['Authorization'] = 'Bearer $token';

        final dio = Dio();
        final response = await dio.fetch(requestOptions);
        handler.resolve(response);

        // Обрабатываем запросы из очереди
        _processPendingRequests(dio);
      } catch (e) {
        // Если обновление токена не удалось, обрабатываем все запросы с ошибкой
        _failPendingRequests(err);
        handler.next(err);
      } finally {
        _isRefreshing = false;
        _pendingRequests.clear();
      }
    } else {
      handler.next(err);
    }
  }

  void _processPendingRequests(Dio dio) async {
    final token = await secureStorage.read(key: StorageKeys.accessToken);
    for (final pending in _pendingRequests) {
      try {
        pending.requestOptions.headers['Authorization'] = 'Bearer $token';
        final response = await dio.fetch(pending.requestOptions);
        pending.handler.resolve(response);
      } catch (e) {
        pending.handler.reject(
          DioException(
            requestOptions: pending.requestOptions,
            error: e,
          ),
        );
      }
    }
  }

  void _failPendingRequests(DioException error) {
    for (final pending in _pendingRequests) {
      pending.handler.reject(
        DioException(
          requestOptions: pending.requestOptions,
          response: error.response,
          error: error.error,
        ),
      );
    }
  }
}

class _PendingRequest {
  final RequestOptions requestOptions;
  final ErrorInterceptorHandler handler;

  _PendingRequest({
    required this.requestOptions,
    required this.handler,
  });
}
