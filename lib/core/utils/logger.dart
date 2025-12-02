import 'package:flutter/foundation.dart';

/// Простой логгер для приложения
/// В debug режиме использует debugPrint
/// В production может быть расширен для отправки логов на сервер
class AppLogger {
  AppLogger._();

  static const String _tag = '[MosStroInform]';

  /// Логирование отладочной информации
  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      final buffer = StringBuffer('$_tag [DEBUG] $message');
      if (error != null) {
        buffer.write('\nError: $error');
      }
      if (stackTrace != null) {
        buffer.write('\nStackTrace: $stackTrace');
      }
      debugPrint(buffer.toString());
    }
  }

  /// Логирование информационных сообщений
  static void info(String message) {
    if (kDebugMode) {
      debugPrint('$_tag [INFO] $message');
    }
  }

  /// Логирование предупреждений
  static void warning(String message, [Object? error]) {
    if (kDebugMode) {
      final buffer = StringBuffer('$_tag [WARNING] $message');
      if (error != null) {
        buffer.write('\nError: $error');
      }
      debugPrint(buffer.toString());
    }
  }

  /// Логирование ошибок
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      final buffer = StringBuffer('$_tag [ERROR] $message');
      if (error != null) {
        buffer.write('\nError: $error');
      }
      if (stackTrace != null) {
        buffer.write('\nStackTrace: $stackTrace');
      }
      debugPrint(buffer.toString());
    }
    // В production здесь можно добавить отправку логов на сервер
  }
}
