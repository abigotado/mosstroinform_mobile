import 'package:dio/dio.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

/// Провайдер для Dio клиента
/// Базовая настройка сети для всего приложения
@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(seconds: AppConstants.requestTimeout),
      receiveTimeout: Duration(seconds: AppConstants.requestTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Добавляем логгер для всех HTTP запросов
  dio.interceptors.add(AppLogger.dioLogger);

  return dio;
}
