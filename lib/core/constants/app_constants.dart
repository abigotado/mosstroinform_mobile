import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';

/// Константы приложения
/// Использует конфигурацию на основе flavor
class AppConstants {
  AppConstants._();

  static final AppConfigSimple _config = AppConfigSimple.fromFlavor(
    AppConfigSimple.getFlavor(),
  );

  /// Базовый URL API (зависит от flavor)
  static String get baseUrl => _config.baseUrl;

  /// Использовать моки вместо реального API (зависит от flavor)
  static bool get useMocks => _config.useMocks;

  /// Таймаут запросов в секундах
  static int get requestTimeout => _config.requestTimeout;

  /// Название текущего окружения
  static String get environmentName => _config.environmentName;

  /// Размер страницы для пагинации
  static const int pageSize = 20;
}
