import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/errors/extensions/failure_mapper_extension.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Расширение для локализации сообщений об ошибках (для Object)
extension LocalizeErrorMessage on Object {
  /// Преобразует объект в локализованное сообщение для пользователя
  String toLocalizedMessage(BuildContext context) {
    // Если это Exception, преобразуем в Failure
    if (this is Exception) {
      final exception = this as Exception;
      // Преобразуем в Failure если это не Failure
      final failure = exception is Failure
          ? exception as Failure
          : exception.toFailure();

      return failure.toLocalizedMessage(context);
    }

    // Если это не Exception, преобразуем в Failure
    final failure = this is Failure ? this as Failure : toFailure();
    return failure.toLocalizedMessage(context);
  }
}

/// Расширение для Failure для получения локализованного сообщения
extension FailureLocalization on Failure {
  /// Преобразует Failure в локализованное сообщение для пользователя
  String toLocalizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    if (this is NetworkFailure) {
      return l10n.networkError;
    }
    
    if (this is ServerFailure) {
      // Для ServerFailure показываем сообщение от сервера, если оно есть
      return message.isNotEmpty ? message : l10n.serverError;
    }
    
    if (this is ValidationFailure) {
      return message;
    }
    
    if (this is CacheFailure) {
      return l10n.cacheError;
    }
    
    // UnknownFailure
    return l10n.error;
  }
}

