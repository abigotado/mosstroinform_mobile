import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';

/// Расширение для преобразования различных типов ошибок в Failure
extension FailureMapper on Object {
  /// Преобразует любую ошибку в Failure
  Failure toFailure() {
    try {
      if (this is Failure) {
        return this as Failure;
      }
      
      if (this is DioException) {
        return _mapDioException(this as DioException);
      }
      
      if (this is FormatException) {
        return UnknownFailure(
          'Ошибка формата данных: ${(this as FormatException).message}',
        );
      }
      
      if (this is IOException) {
        return const NetworkFailure(
          'Ошибка сети. Проверьте подключение к интернету',
        );
      }
      
      return UnknownFailure('Неизвестная ошибка: $this');
    } catch (e, s) {
      return UnknownFailure(
        'Ошибка при обработке исключения: $e\nStackTrace: $s',
      );
    }
  }

  /// Преобразует DioException в соответствующий тип Failure
  Failure _mapDioException(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final message = exception.response?.data?['message'] as String? ??
        exception.message ??
        'Ошибка сети';

    return switch (exception.type) {
      DioExceptionType.cancel => NetworkFailure('Запрос отменен'),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.badCertificate => NetworkFailure(
          'Ошибка подключения к серверу. Проверьте подключение к интернету',
        ),
      DioExceptionType.connectionError => const NetworkFailure(
          'Ошибка сети. Проверьте подключение к интернету',
        ),
      _ => _mapHttpStatusToFailure(statusCode, message),
    };
  }

  /// Преобразует HTTP статус код в соответствующий тип Failure
  Failure _mapHttpStatusToFailure(int? statusCode, String message) {
    if (statusCode == null) {
      return NetworkFailure(message);
    }

    return switch (statusCode) {
      HttpStatus.unauthorized => ValidationFailure(
          'Требуется авторизация. Войдите в систему',
        ),
      HttpStatus.forbidden => ValidationFailure(
          'Доступ запрещен',
        ),
      HttpStatus.notFound => ValidationFailure('Ресурс не найден'),
      HttpStatus.badRequest => ValidationFailure(message),
      HttpStatus.unprocessableEntity => ValidationFailure(message),
      HttpStatus.conflict => ValidationFailure(message),
      HttpStatus.tooManyRequests => ValidationFailure(
          'Слишком много запросов. Попробуйте позже',
        ),
      >= 500 => ServerFailure('Ошибка сервера: $message'),
      >= 400 => ValidationFailure(message),
      _ => NetworkFailure(message),
    };
  }
}
