import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';

part 'dio_provider.g.dart';

/// Провайдер для Dio клиента
/// Базовая настройка сети для всего приложения
@riverpod
Dio dio(Ref ref) {
  return Dio(
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
}

