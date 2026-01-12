import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/core/errors/extensions/failure_mapper_extension.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Расширение для локализации сообщений об ошибках (для Object)
extension LocalizeErrorMessage on Object {
  /// Преобразует объект в локализованное сообщение для пользователя
  String toLocalizedMessage(BuildContext context) {
    // Сохраняем исходное исключение для извлечения статус кода
    DioException? dioException;

    // Если это Exception, преобразуем в Failure
    if (this is Exception) {
      final exception = this as Exception;

      // Сохраняем DioException для извлечения статус кода
      if (exception is DioException) {
        dioException = exception;
      }

      // Преобразуем в Failure если это не Failure
      final failure = exception is Failure ? exception as Failure : exception.toFailure();

      return failure.toLocalizedMessage(context, dioException: dioException);
    }

    // Если это не Exception, преобразуем в Failure
    final failure = this is Failure ? this as Failure : toFailure();
    return failure.toLocalizedMessage(context);
  }
}

/// Расширение для Failure для получения локализованного сообщения
extension FailureLocalization on Failure {
  /// Преобразует Failure в локализованное сообщение для пользователя
  /// [dioException] - исходное DioException для извлечения статус кода (если доступно)
  String toLocalizedMessage(BuildContext context, {DioException? dioException}) {
    final l10n = AppLocalizations.of(context)!;
    final statusCode = dioException?.response?.statusCode;

    // Проверяем, есть ли в сообщении полезная информация от сервера
    // Дефолтные сообщения обычно короткие и не содержат деталей
    final hasServerMessage =
        message.isNotEmpty &&
        !message.startsWith('Ошибка сети') &&
        !message.startsWith('Ошибка сервера:') &&
        !message.startsWith('Неизвестная ошибка:') &&
        message.length > 10; // Минимальная длина для полезного сообщения

    if (this is NetworkFailure) {
      // Если есть сообщение от сервера - показываем его, иначе локализованное + статус код
      if (hasServerMessage) {
        return message;
      }
      return statusCode != null ? '${l10n.networkError} (HTTP $statusCode)' : l10n.networkError;
    }

    if (this is ServerFailure) {
      // Если есть сообщение от сервера - показываем его, иначе локализованное + статус код
      if (hasServerMessage) {
        return message;
      }
      return statusCode != null ? '${l10n.serverError} (HTTP $statusCode)' : l10n.serverError;
    }

    if (this is ValidationFailure) {
      // Для ValidationFailure показываем сообщение от сервера, если оно есть
      // Иначе показываем локализованное + статус код
      if (hasServerMessage) {
        return message;
      }
      return statusCode != null ? '${l10n.error} (HTTP $statusCode)' : l10n.error;
    }

    if (this is CacheFailure) {
      return l10n.cacheError;
    }

    // UnknownFailure - показываем сообщение, если оно есть, иначе локализованное + статус код
    if (hasServerMessage) {
      return message;
    }
    return statusCode != null ? '${l10n.error} (HTTP $statusCode)' : l10n.error;
  }
}
