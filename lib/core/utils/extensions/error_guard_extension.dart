import 'dart:async';

import 'package:mosstroinform_mobile/core/errors/extensions/failure_mapper_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';

// Экспортируем расширения для удобного использования
export 'package:mosstroinform_mobile/core/errors/extensions/failure_mapper_extension.dart';
export 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';

/// Расширение для безопасного выполнения функций с автоматической обработкой ошибок
extension ErrorGuard on Object {
  /// Безопасно выполняет функцию с автоматической обработкой ошибок
  /// Преобразует все ошибки в Failure и логирует их
  FutureOr<T> guard<T>(
    FutureOr<T> Function() function, {
    String? methodName,
  }) async {
    try {
      return await function();
    } catch (error, stackTrace) {
      final failure = error.toFailure();
      AppLogger.error(
        methodName != null ? '$methodName: ${failure.message}' : failure.message,
        failure,
        stackTrace,
      );
      throw failure;
    }
  }
}

