/// Хелперы для работы с URL видеопотоков.
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
  static String toMediaMtxIframeUrl(String rtspUrl) {
    final httpUrl = toHttpWebUrl(rtspUrl);
    return '$httpUrl?autoplay=true&muted=true&controls=false&playsinline=true';
  }
}
