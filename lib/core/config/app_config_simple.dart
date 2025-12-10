import 'package:flutter/services.dart';

/// Упрощённая конфигурация приложения для разных окружений
/// Используется когда envied не настроен или для быстрого старта
class AppConfigSimple {
  final String baseUrl;
  final bool useMocks;
  final int requestTimeout;
  final String environmentName;
  final String? webrtcSignalingUrl;

  const AppConfigSimple({
    required this.baseUrl,
    required this.useMocks,
    required this.requestTimeout,
    required this.environmentName,
    this.webrtcSignalingUrl,
  });

  /// Конфигурация для production окружения (реальные данные)
  factory AppConfigSimple.prod() {
    return AppConfigSimple(
      baseUrl: 'https://mosstroiinform.vasmarfas.com/api/v1',
      useMocks: false,
      requestTimeout: 30,
      environmentName: 'Production',
      // WebRTC signaling сервер для конвертации RTSP в WebRTC на вебе
      // Варианты бесплатных решений:
      // 1. Развернуть Janus Gateway на бесплатном хостинге (Railway, Render, Fly.io)
      //    Пример: 'wss://your-janus-server.railway.app/janus'
      // 2. Использовать собственный сервер на Node.js/Python с бесплатным хостингом
      //    Пример: 'wss://your-webrtc-server.onrender.com'
      // 3. Использовать Cloudflare Calls (бесплатно до 1000 ГБ/месяц)
      //    Требует настройки через Cloudflare API
      // 4. Альтернатива: использовать HLS потоки для веба вместо RTSP
      webrtcSignalingUrl: null,
    );
  }

  /// Конфигурация для mock окружения (моки)
  factory AppConfigSimple.mock() {
    return AppConfigSimple(
      baseUrl: 'https://api-mock.example.com',
      useMocks: true,
      requestTimeout: 30,
      environmentName: 'Mock',
      // Для mock окружения можно использовать тот же signaling сервер
      // или отдельный тестовый сервер
      webrtcSignalingUrl: null,
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
  /// По умолчанию используется 'prod' для платформ, которые не поддерживают flavors
  static String getFlavor() {
    // Flutter автоматически передает flavor name через appFlavor при использовании --flavor
    // appFlavor доступен глобально из package:flutter/services.dart
    // Если appFlavor не установлен (например, при использовании --dart-define), читаем из environment
    // По умолчанию используем 'prod' для платформ без поддержки flavors (Linux, Windows, Web)
    return appFlavor ?? String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  }
}
