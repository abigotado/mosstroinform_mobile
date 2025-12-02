import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    debugPrint('=== CameraViewScreen initState ===');
    debugPrint('Камера: ${widget.camera.name}');
    debugPrint('ID: ${widget.camera.id}');
    debugPrint('isActive: ${widget.camera.isActive}');
    debugPrint('URL: ${widget.camera.streamUrl}');
    _initializeVideo();
  }

  void _addVideoListener() {
    _controller?.addListener(() {
      if (_controller != null) {
        final value = _controller!.value;
        debugPrint('=== Состояние видео изменилось ===');
        debugPrint('isInitialized: ${value.isInitialized}');
        debugPrint('isPlaying: ${value.isPlaying}');
        debugPrint('isBuffering: ${value.isBuffering}');
        debugPrint('hasError: ${value.hasError}');
        if (value.hasError) {
          debugPrint('Ошибка видео: ${value.errorDescription}');
        }
        debugPrint('position: ${value.position}');
        debugPrint('duration: ${value.duration}');
        debugPrint('buffered: ${value.buffered}');
        debugPrint('size: ${value.size}');
        debugPrint('aspectRatio: ${value.aspectRatio}');
        
        // Определяем тип потока
        final isLiveStream = value.duration == Duration.zero || 
                            value.duration.inHours > 1000; // Live потоки обычно имеют очень большую или нулевую длительность
        debugPrint('Тип потока: ${isLiveStream ? "LIVE (реальное время)" : "VOD (потоковое видео)"}');

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
    });
  }

  Future<void> _initializeVideo() async {
    debugPrint('=== Начало инициализации видео ===');
    debugPrint('isActive: ${widget.camera.isActive}');

    if (!widget.camera.isActive) {
      debugPrint('Камера неактивна, показываем ошибку');
      setState(() {
        _hasError = true;
      });
      return;
    }

    try {
      debugPrint('=== Создание VideoPlayerController ===');
      debugPrint('URL: ${widget.camera.streamUrl}');

      // VideoPlayerController.networkUrl поддерживает потоковое видео:
      // - HLS потоки (.m3u8) - стандарт для потокового видео (поддерживается из коробки)
      //   Используется для live streaming и адаптивного потокового видео
      // - DASH потоки
      // - Обычные видеофайлы через HTTP
      // Примечание: Для RTSP потоков может потребоваться дополнительный пакет
      // (например, flutter_vlc_player или media_kit)
      debugPrint(
        'Тип потока: ${widget.camera.streamUrl.endsWith('.m3u8') ? 'HLS (потоковое)' : 'HTTP (файл)'}',
      );
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.camera.streamUrl),
      );

      // Добавляем слушатель изменений состояния
      _addVideoListener();

      debugPrint('=== Начало инициализации контроллера ===');
      await _controller!.initialize();
      debugPrint('=== Контроллер инициализирован ===');

      debugPrint('Длительность: ${_controller!.value.duration}');
      debugPrint('Разрешение: ${_controller!.value.size}');
      debugPrint('AspectRatio: ${_controller!.value.aspectRatio}');
      debugPrint('isInitialized: ${_controller!.value.isInitialized}');

      if (mounted) {
        debugPrint('=== Widget mounted, обновляем состояние ===');
        setState(() {
          _isInitialized = true;
        });
        // Автоматически запускаем воспроизведение
        debugPrint('=== Запуск воспроизведения ===');
        await _controller!.play();
        debugPrint('=== Воспроизведение запущено ===');
        debugPrint('isPlaying: ${_controller!.value.isPlaying}');
      } else {
        debugPrint('=== Widget не mounted, пропускаем обновление ===');
      }
    } catch (e, stackTrace) {
      debugPrint('=== ОШИБКА инициализации видео ===');
      debugPrint('Ошибка: $e');
      debugPrint('Тип ошибки: ${e.runtimeType}');
      debugPrint('Stack trace: $stackTrace');
      debugPrint('URL потока: ${widget.camera.streamUrl}');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
