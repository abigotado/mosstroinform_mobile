/// Хелперы для работы с URL видеопотоков.
class StreamUrl {
  /// Проверка на RTSP.
  static bool isRtsp(String url) => url.toLowerCase().startsWith('rtsp://');

  /// Заменяем протокол RTSP на HTTP и порт 8554 на 8889.
  /// Используется для MediaMTX, где RTSP и WHEP/HTTP доступны на разных портах.
  static String toHttpWebUrl(String url) {
    var result = url.replaceAll('rtsp://', 'http://');
    result = result.replaceAll(':8554/', ':8889/').replaceAll(':8554', ':8889');
    if (!result.endsWith('/')) {
      result = '$result/';
    }
    return result;
  }

  /// Формируем URL для iframe MediaMTX (WHEP) с автозапуском и mute.
  static String toMediaMtxIframeUrl(String rtspUrl) {
    final httpUrl = toHttpWebUrl(rtspUrl);
    return '$httpUrl?autoplay=true&muted=true&controls=false&playsinline=true';
  }
}
