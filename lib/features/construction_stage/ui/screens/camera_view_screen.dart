import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
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

  @override
  void initState() {
    super.initState();
    AppLogger.debug('CameraViewScreen initState');
    AppLogger.debug('Камера: ${widget.camera.name}');
    AppLogger.debug('ID: ${widget.camera.id}');
    AppLogger.debug('isActive: ${widget.camera.isActive}');
    AppLogger.debug('URL: ${widget.camera.streamUrl}');
    _initializeVideo();
  }

  void _addVideoListener() {
    _videoListener = () {
      if (_controller != null && mounted) {
        final value = _controller!.value;
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
            value.duration.inHours >
                1000; // Live потоки обычно имеют очень большую или нулевую длительность
        AppLogger.debug(
          'Тип потока: ${isLiveStream ? "LIVE (реальное время)" : "VOD (потоковое видео)"}',
        );

        // Обновляем состояние при изменении
        if (mounted && value.isInitialized && !_isInitialized) {
          setState(() {
            _isInitialized = true;
          });
        }

        if (mounted && value.hasError && !_hasError) {
          setState(() {
            _hasError = true;
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
      // Примечание: Для RTSP потоков может потребоваться дополнительный пакет
      // (например, flutter_vlc_player или media_kit)
      AppLogger.debug(
        'Тип потока: ${widget.camera.streamUrl.endsWith('.m3u8') ? 'HLS (потоковое)' : 'HTTP (файл)'}',
      );
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.camera.streamUrl),
      );

      // Добавляем слушатель изменений состояния
      _addVideoListener();

      AppLogger.debug('Начало инициализации контроллера');
      await _controller!.initialize();
      AppLogger.debug('Контроллер инициализирован');

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
        await _controller!.play();
        AppLogger.debug('Воспроизведение запущено');
        AppLogger.debug('isPlaying: ${_controller!.value.isPlaying}');
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

    return Scaffold(
      appBar: AppBar(title: Text(widget.camera.name)),
      body: _hasError || (_controller?.value.hasError ?? false)
          ? _VideoErrorWidget(
              camera: widget.camera,
              l10n: l10n,
              errorDescription: _controller?.value.hasError == true
                  ? _controller?.value.errorDescription
                  : null,
            )
          : _isInitialized &&
                _controller != null &&
                _controller!.value.isInitialized
          ? _VideoPlayerWidget(controller: _controller!)
          : const _VideoLoadingWidget(),
    );
  }
}

/// Виджет видеоплеера для live потока
/// Для live потоков не нужны кнопки паузы/запуска и прогресс-бар
class _VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const _VideoPlayerWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    // Используем aspectRatio из контроллера, если он доступен, иначе 16/9 по умолчанию
    final aspectRatio = controller.value.aspectRatio > 0
        ? controller.value.aspectRatio
        : 16 / 9;

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.buffering,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
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

  const _VideoErrorWidget({
    required this.camera,
    required this.l10n,
    this.errorDescription,
  });

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
            camera.isActive
                ? l10n.errorLoadingVideoStream
                : l10n.cameraNotActive,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (camera.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                camera.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
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
