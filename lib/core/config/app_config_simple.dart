import 'package:flutter/foundation.dart';

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

  /// Конфигурация для разработки (dev flavor)
  factory AppConfigSimple.dev() {
    return const AppConfigSimple(
      baseUrl: 'https://api-dev.example.com',
      useMocks: true,
      requestTimeout: 30,
      environmentName: 'Development',
    );
  }

  /// Конфигурация для staging окружения
  factory AppConfigSimple.staging() {
    return const AppConfigSimple(
      baseUrl: 'https://api-staging.example.com',
      useMocks: false,
      requestTimeout: 30,
      environmentName: 'Staging',
    );
  }

  /// Конфигурация для production окружения
  factory AppConfigSimple.prod() {
    return const AppConfigSimple(
      baseUrl: 'https://api.example.com',
      useMocks: false,
      requestTimeout: 30,
      environmentName: 'Production',
    );
  }

  /// Получить конфигурацию для текущего flavor
  factory AppConfigSimple.fromFlavor(String flavor) {
    switch (flavor) {
      case 'dev':
        return AppConfigSimple.dev();
      case 'staging':
        return AppConfigSimple.staging();
      case 'prod':
        return AppConfigSimple.prod();
      default:
        return AppConfigSimple.dev();
    }
  }

  /// Получить flavor из константы компиляции
  static String getFlavor() {
    // В production сборке kDebugMode будет false
    if (kDebugMode) {
      // Можно использовать String.fromEnvironment для передачи flavor
      const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
      return flavor;
    }
    return 'prod';
  }
}

