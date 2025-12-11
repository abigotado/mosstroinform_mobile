import 'package:flutter/foundation.dart' show kIsWeb;

/// Хелперы для работы с URL видеопотоков и изображений.
class StreamUrl {
  /// Проверка на RTSP.
  static bool isRtsp(String url) => url.toLowerCase().startsWith('rtsp://');

  /// Заменяем протокол RTSP на HTTPS и порт 8554 на 8889.
  /// Используется для MediaMTX, где RTSP и WHEP/HTTPS доступны на разных портах.
  /// HTTPS нужен на вебе, чтобы избежать Mixed Content в браузере.
  static String toHttpWebUrl(String url) {
    var result = url.replaceAll('rtsp://', 'https://');
    result = result.replaceAll(':8554/', ':8889/').replaceAll(':8554', ':8889');
    if (!result.endsWith('/')) {
      result = '$result/';
    }
    return result;
  }

  /// Формируем URL для iframe MediaMTX (WHEP) с автозапуском и mute.
  /// Гарантирует HTTPS на вебе для избежания Mixed Content.
  static String toMediaMtxIframeUrl(String rtspUrl) {
    var httpUrl = toHttpWebUrl(rtspUrl);
    // Дополнительная проверка: если URL всё ещё HTTP на вебе, конвертируем в HTTPS
    if (kIsWeb && httpUrl.toLowerCase().startsWith('http://')) {
      httpUrl = httpUrl.replaceFirst('http://', 'https://');
    }
    return '$httpUrl?autoplay=true&muted=true&controls=false&playsinline=true';
  }

  /// Конвертирует HTTP URL в HTTPS для веба, чтобы избежать Mixed Content.
  /// На нативных платформах возвращает исходный URL без изменений.
  static String toSecureUrl(String url) {
    if (!kIsWeb) {
      return url;
    }
    
    // Конвертируем http:// в https:// для веба
    if (url.toLowerCase().startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    
    return url;
  }
}
