import 'package:flutter/services.dart';

/// Упрощённая конфигурация приложения для разных окружений
/// Используется когда envied не настроен или для быстрого старта
class AppConfigSimple {
  final String baseUrl;
  final bool useMocks;
  final int requestTimeout;
  final String environmentName;

  const AppConfigSimple({
    required this.baseUrl,
    required this.useMocks,
    required this.requestTimeout,
    required this.environmentName,
  });

  /// Конфигурация для production окружения (реальные данные)
  factory AppConfigSimple.prod() {
    return const AppConfigSimple(
      baseUrl: 'https://mosstroiinform.vasmarfas.com/api/v1',
      useMocks: false,
      requestTimeout: 30,
      environmentName: 'Production',
    );
  }

  /// Конфигурация для mock окружения (моки)
  factory AppConfigSimple.mock() {
    return const AppConfigSimple(
      baseUrl: 'https://api-mock.example.com',
      useMocks: true,
      requestTimeout: 30,
      environmentName: 'Mock',
    );
  }

  /// Получить конфигурацию для текущего flavor
  factory AppConfigSimple.fromFlavor(String flavor) {
    switch (flavor) {
      case 'prod':
        return AppConfigSimple.prod();
      case 'mock':
        return AppConfigSimple.mock();
      default:
        return AppConfigSimple.mock();
    }
  }

  /// Получить flavor из глобальной переменной appFlavor или из dart-define
  /// Flutter автоматически передает flavor name при использовании --flavor
  /// Использует appFlavor из package:flutter/services.dart
  /// Если appFlavor не установлен, читает из String.fromEnvironment('FLAVOR')
  static String getFlavor() {
    // Flutter автоматически передает flavor name через appFlavor при использовании --flavor
    // appFlavor доступен глобально из package:flutter/services.dart
    // Если appFlavor не установлен (например, при использовании --dart-define), читаем из environment
    return appFlavor ?? String.fromEnvironment('FLAVOR', defaultValue: 'mock');
  }
}
