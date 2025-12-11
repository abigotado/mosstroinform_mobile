import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/utils/stream_url.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/screens/video_fullscreen_screen.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/widgets/web_iframe_player_stub.dart'
    if (dart.library.html) 'package:mosstroinform_mobile/features/construction_stage/ui/widgets/web_iframe_player_web.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

/// Экран просмотра видеопотока камеры
class CameraViewScreen extends StatefulWidget {
  final Camera camera;

  const CameraViewScreen({super.key, required this.camera});

  @override
  State<CameraViewScreen> createState() => _CameraViewScreenState();
}

class _CameraViewScreenState extends State<CameraViewScreen> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  VoidCallback? _videoListener;
  int _reinitAttempts = 0;
  static const int _maxReinitAttempts = 2;

  @override
  void initState() {
    super.initState();
    AppLogger.debug('CameraViewScreen initState');
    AppLogger.debug('Камера: ${widget.camera.name}');
    AppLogger.debug('ID: ${widget.camera.id}');
    AppLogger.debug('isActive: ${widget.camera.isActive}');
    AppLogger.debug('URL: ${widget.camera.streamUrl}');
    final isRTSP = StreamUrl.isRtsp(widget.camera.streamUrl);
    if (kIsWeb && isRTSP) {
      // Для веба показываем iframe с WebRTC/HLS страницей MediaMTX, не инициализируем VideoPlayer
      AppLogger.debug('Веб + RTSP: пропускаем инициализацию VideoPlayer, используем iframe');
      return;
    }
    _initializeVideo();
  }

  void _addVideoListener() {
    _videoListener = () {
      if (_controller != null && mounted) {
        final value = _controller!.value;

        // Определяем тип ошибки для фильтрации повторяющихся логов
        final errorDescription = value.errorDescription?.toLowerCase() ?? '';
        final isAudioError =
            errorDescription.contains('audio') ||
            errorDescription.contains('sound') ||
            errorDescription.contains('audio device');
        final isSeekError =
            errorDescription.contains('cannot seek') ||
            errorDescription.contains('seek in this stream') ||
            errorDescription.contains('force-seekable') ||
            errorDescription.contains('seekable');
        final streamUrl = widget.camera.streamUrl.toLowerCase();
        final isRTSP = streamUrl.startsWith('rtsp://');

        // Логируем только важные изменения состояния, не логируем повторяющиеся ошибки аудио/seek для RTSP
        final shouldLogState = !(isRTSP && (isAudioError || isSeekError) && _isInitialized);

        if (shouldLogState) {
          AppLogger.debug('Состояние видео изменилось');
          AppLogger.debug('isInitialized: ${value.isInitialized}');
          AppLogger.debug('isPlaying: ${value.isPlaying}');
          AppLogger.debug('isBuffering: ${value.isBuffering}');
          AppLogger.debug('hasError: ${value.hasError}');
          if (value.hasError) {
            AppLogger.warning('Ошибка видео: ${value.errorDescription}');
          }
          AppLogger.debug('position: ${value.position}');
          AppLogger.debug('duration: ${value.duration}');
          AppLogger.debug('buffered: ${value.buffered}');
          AppLogger.debug('size: ${value.size}');
          AppLogger.debug('aspectRatio: ${value.aspectRatio}');

          // Определяем тип потока
          final isLiveStream =
              value.duration == Duration.zero ||
              value.duration.inHours > 1000; // Live потоки обычно имеют очень большую или нулевую длительность
          AppLogger.debug('Тип потока: ${isLiveStream ? "LIVE (реальное время)" : "VOD (потоковое видео)"}');
        } else if (value.hasError && (isAudioError || isSeekError)) {
          // Логируем только первую ошибку аудио/seek, затем игнорируем повторяющиеся
          // Это уменьшает спам логов на симуляторе
        }

        // Обновляем состояние при изменении
        if (mounted && value.isInitialized && !_isInitialized) {
          setState(() {
            _isInitialized = true;
            // Сбрасываем ошибку, если видео инициализировано
            _hasError = false;
            // Сбрасываем счетчик попыток переинициализации при успешной инициализации
            _reinitAttempts = 0;
          });
        }

        // Игнорируем ошибки аудио и seek, если видео работает
        // Ошибки типа "Could not open/initialize audio device -> no sound"
        // и "Cannot seek in this stream" не должны останавливать воспроизведение видео
        // (isAudioError и isSeekError уже определены выше)

        // Если это ошибка аудио или seek, но видео инициализировано и имеет правильный размер,
        // игнорируем ошибку и продолжаем воспроизведение
        if (mounted && value.hasError && (isAudioError || isSeekError)) {
          if (value.isInitialized && value.size.width > 0 && value.size.height > 0) {
            AppLogger.debug('Игнорируем ошибку ${isAudioError ? "аудио" : "seek"}, видео продолжает работать');
            // Не устанавливаем _hasError = true для ошибок аудио и seek
            return;
          }
        }

        // Если это ошибка аудио для RTSP потока, и видео уже было инициализировано,
        // игнорируем ошибку (RTSP потоки могут работать без аудио)
        // Не переинициализируем, так как ошибка аудио не критична для видео
        if (mounted && value.hasError && isAudioError) {
          if (isRTSP && _isInitialized) {
            // Просто игнорируем ошибку - состояние уже восстановлено (_isInitialized = true)
            // Не вызываем setState, чтобы избежать лишних перерисовок и логов
            // Не устанавливаем _hasError = true для ошибок аудио в RTSP потоках
            // Не переинициализируем, так как ошибка аудио не критична
            return;
          }
        }

        // Если это ошибка seek для RTSP потока, но видео буферизуется,
        // игнорируем ошибку (RTSP потоки не поддерживают seek, но работают)
        // Если видео было инициализировано ранее, просто игнорируем ошибку
        if (mounted && value.hasError && isSeekError) {
          if (isRTSP && (value.buffered.isNotEmpty || _isInitialized)) {
            // Просто игнорируем ошибку - состояние уже восстановлено или видео буферизуется
            // Не вызываем setState, чтобы избежать лишних перерисовок и логов
            // Не устанавливаем _hasError = true для ошибок seek в RTSP потоках
            return;
          }
        }

        if (mounted && value.hasError && !_hasError && !isAudioError && !isSeekError) {
          setState(() {
            _hasError = true;
          });
        }

        // Для RTSP потоков ошибки аудио не критичны - видео может работать без аудио
        // Не переинициализируем для ошибок аудио на RTSP потоках, так как это создает бесконечный цикл
        // на симуляторах, где аудио устройство недоступно
        // (isRTSP уже определен выше)

        // Переинициализация только для не-RTSP потоков или если это не ошибка аудио/seek
        if (mounted &&
            !value.isInitialized &&
            _isInitialized &&
            !isRTSP && // Не переинициализируем RTSP потоки для ошибок аудио
            !isAudioError && // Не переинициализируем для ошибок аудио
            !isSeekError && // Не переинициализируем для ошибок seek
            value.size.width == 0 &&
            value.size.height == 0 &&
            _reinitAttempts < _maxReinitAttempts) {
          AppLogger.warning(
            'Видео потеряло инициализацию, пытаемся переинициализировать (попытка ${_reinitAttempts + 1}/$_maxReinitAttempts)',
          );
          _reinitAttempts++;
          // Не устанавливаем ошибку, попробуем переинициализировать
          setState(() {
            _isInitialized = false;
            _hasError = false;
          });
          // Переинициализируем видео
          // Удаляем слушатель перед dispose
          if (_controller != null && _videoListener != null) {
            _controller!.removeListener(_videoListener!);
          }
          _controller?.dispose();
          _controller = null;
          _videoListener = null;
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              _initializeVideo();
            }
          });
        } else if (mounted && !value.isInitialized && _isInitialized && (isAudioError || isSeekError) && isRTSP) {
          // Для RTSP потоков с ошибками аудио/seek просто игнорируем ошибку
          // и восстанавливаем состояние инициализации, если видео было инициализировано
          AppLogger.debug(
            'Игнорируем ошибку ${isAudioError ? "аудио" : "seek"} для RTSP потока, восстанавливаем состояние',
          );
          setState(() {
            _isInitialized = true;
            _hasError = false;
          });
        }
      }
    };
    _controller?.addListener(_videoListener!);
  }

  Future<void> _initializeVideo() async {
    AppLogger.debug('Начало инициализации видео');
    AppLogger.debug('isActive: ${widget.camera.isActive}');

    if (!widget.camera.isActive) {
      AppLogger.warning('Камера неактивна, показываем ошибку');
      setState(() {
        _hasError = true;
      });
      return;
    }

    try {
      AppLogger.debug('Создание VideoPlayerController');
      AppLogger.debug('URL: ${widget.camera.streamUrl}');

      // VideoPlayerController.networkUrl поддерживает потоковое видео:
      // - HLS потоки (.m3u8) - стандарт для потокового видео (поддерживается из коробки)
      //   Используется для live streaming и адаптивного потокового видео
      // - DASH потоки
      // - Обычные видеофайлы через HTTP
      // - RTSP потоки - поддерживаются через video_player_media_kit (media_kit)
      final streamUrl = widget.camera.streamUrl.toLowerCase();
      final isRTSP = streamUrl.startsWith('rtsp://');
      final isHLS = streamUrl.endsWith('.m3u8');
      final streamType = isRTSP
          ? 'RTSP (потоковое)'
          : isHLS
          ? 'HLS (потоковое)'
          : 'HTTP (файл)';
      AppLogger.debug('Тип потока: $streamType');

      // VideoPlayerController.networkUrl автоматически использует media_kit для RTSP
      // благодаря VideoPlayerMediaKit.ensureInitialized() в bootstrap
      // Для HLS и HTTP используется стандартный video_player
      // На вебе преобразуем RTSP URL в HTTP URL для прямого воспроизведения
      String urlToUse = widget.camera.streamUrl;
      if (kIsWeb && isRTSP) {
        // Для веба заменяем RTSP на HTTP и порт 8554 на 8889
        urlToUse = urlToUse.replaceAll('rtsp://', 'http://');
        // Заменяем порт 8554 на 8889 (работает с разными форматами URL)
        urlToUse = urlToUse.replaceAll(':8554/', ':8889/');
        urlToUse = urlToUse.replaceAll(':8554', ':8889');
        AppLogger.info('Преобразован RTSP URL для веба:');
        AppLogger.info('  Исходный: ${widget.camera.streamUrl}');
        AppLogger.info('  Новый: $urlToUse');
      }
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(urlToUse),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true, // не блокируем звук других источников
          allowBackgroundPlayback: false,
        ),
      );

      // Добавляем слушатель изменений состояния
      _addVideoListener();

      AppLogger.debug('Начало инициализации контроллера');
      await _controller!.initialize();
      AppLogger.debug('Контроллер инициализирован');

      // Проверяем, что контроллер все еще существует после инициализации
      if (_controller == null) {
        AppLogger.warning('Контроллер стал null после инициализации');
        if (mounted) {
          setState(() {
            _hasError = true;
          });
        }
        return;
      }

      AppLogger.debug('Длительность: ${_controller!.value.duration}');
      AppLogger.debug('Разрешение: ${_controller!.value.size}');
      AppLogger.debug('AspectRatio: ${_controller!.value.aspectRatio}');
      AppLogger.debug('isInitialized: ${_controller!.value.isInitialized}');

      if (mounted) {
        AppLogger.debug('Widget mounted, обновляем состояние');
        setState(() {
          _isInitialized = true;
        });
        // Автоматически запускаем воспроизведение
        AppLogger.debug('Запуск воспроизведения');
        // Проверяем контроллер еще раз перед использованием
        if (_controller != null) {
          // На вебе Chrome/Firefox блокируют автостарт без жеста, если звук включен.
          // Глушим звук перед autoplay, чтобы разрешить автозапуск потока.
          if (kIsWeb) {
            await _controller!.setVolume(0);
          }
          await _controller!.play();
          AppLogger.debug('Воспроизведение запущено');
          if (_controller != null) {
            AppLogger.debug('isPlaying: ${_controller!.value.isPlaying}');
          }
        } else {
          AppLogger.warning('Контроллер стал null перед запуском воспроизведения');
        }
      } else {
        AppLogger.debug('Widget не mounted, пропускаем обновление');
      }
    } catch (e, stackTrace) {
      AppLogger.error('ОШИБКА инициализации видео', e, stackTrace);
      AppLogger.error('URL потока: ${widget.camera.streamUrl}');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    AppLogger.debug('CameraViewScreen dispose');
    // Сбрасываем счетчик попыток переинициализации
    _reinitAttempts = 0;
    // Останавливаем воспроизведение перед освобождением ресурсов
    if (_controller != null) {
      try {
        if (_controller!.value.isInitialized && _controller!.value.isPlaying) {
          AppLogger.debug('Останавливаем воспроизведение видео');
          _controller!.pause();
        }
        // Удаляем слушатель перед dispose
        if (_videoListener != null) {
          _controller!.removeListener(_videoListener!);
          AppLogger.debug('Слушатель удален');
        }
        AppLogger.debug('Освобождаем ресурсы видеоплеера');
        _controller!.dispose();
        _controller = null;
      } catch (e) {
        AppLogger.error('Ошибка при освобождении видеоплеера', e);
        // Все равно пытаемся освободить ресурсы
        _controller?.dispose();
        _controller = null;
      }
    }
    super.dispose();
    AppLogger.debug('CameraViewScreen dispose завершен');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final streamUrl = widget.camera.streamUrl.toLowerCase();
    final isRTSP = StreamUrl.isRtsp(streamUrl);

    // На вебе для RTSP показываем встроенный iframe с HTML-плеером MediaMTX (WHEP)
    if (kIsWeb && isRTSP) {
      final iframeUrl = StreamUrl.toMediaMtxIframeUrl(widget.camera.streamUrl);

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.camera.name),
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: WebIframePlayer(url: iframeUrl),
      );
    }

    // Для нативных платформ используем стандартную логику
    // Проверяем, является ли ошибка seek или аудио ошибкой для RTSP потока
    // Если да, и видео буферизуется или было инициализировано, не показываем ошибку
    final hasRealError = _hasError || (_controller?.value.hasError ?? false);
    final errorDescription = _controller?.value.errorDescription?.toLowerCase() ?? '';
    final isSeekError = errorDescription.contains('seek') || errorDescription.contains('force-seekable');
    final isAudioError =
        errorDescription.contains('audio') ||
        errorDescription.contains('sound') ||
        errorDescription.contains('audio device');
    final isBuffering = _controller?.value.buffered.isNotEmpty ?? false;

    // Для RTSP потоков с ошибками seek/аудио, но с активной буферизацией или инициализацией, не показываем ошибку
    final shouldShowError =
        hasRealError && !(isRTSP && (isSeekError || isAudioError) && (isBuffering || _isInitialized));

    // Для RTSP потоков с ошибками seek/аудио, но с активной буферизацией или инициализацией, считаем видео работающим
    final isVideoWorking =
        (_isInitialized && _controller != null && _controller!.value.isInitialized) ||
        (isRTSP && (isSeekError || isAudioError) && (isBuffering || _isInitialized) && _controller != null);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.camera.name),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: shouldShowError
          ? _VideoErrorWidget(
              camera: widget.camera,
              l10n: l10n,
              errorDescription: _controller?.value.hasError == true ? _controller?.value.errorDescription : null,
            )
          : isVideoWorking
          ? _VideoPlayerWidget(controller: _controller!, camera: widget.camera)
          : const _VideoLoadingWidget(),
    );
  }
}

/// Виджет видеоплеера для live потока
/// Для live потоков не нужны кнопки паузы/запуска и прогресс-бар
class _VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final Camera camera;

  const _VideoPlayerWidget({required this.controller, required this.camera});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    // Используем aspectRatio из контроллера, если он доступен, иначе 16/9 по умолчанию
    final aspectRatio = controller.value.aspectRatio > 0 ? controller.value.aspectRatio : 16 / 9;

    return Center(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(controller),
            // Индикатор "LIVE" для потокового видео
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'LIVE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Индикатор буферизации (показывается только при буферизации)
            if (controller.value.isBuffering)
              Positioned(
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(l10n.buffering, style: theme.textTheme.labelSmall?.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            // Кнопка полноэкранного режима
            Positioned(
              bottom: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            VideoFullscreenScreen(controller: controller, cameraName: camera.name),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.fullscreen, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Виджет загрузки видеопотока
class _VideoLoadingWidget extends StatelessWidget {
  const _VideoLoadingWidget();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(l10n.loadingVideoStream, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}

/// Виджет ошибки загрузки видеопотока
class _VideoErrorWidget extends StatelessWidget {
  final Camera camera;
  final AppLocalizations l10n;
  final String? errorDescription;

  const _VideoErrorWidget({required this.camera, required this.l10n, this.errorDescription});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            camera.isActive ? l10n.errorLoadingVideoStream : l10n.cameraNotActive,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (camera.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                camera.description,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
          if (errorDescription != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Ошибка: $errorDescription',
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Показываем URL для отладки
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'URL: ${camera.streamUrl}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
