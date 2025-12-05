import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

/// Полноэкранный экран просмотра видео с возможностью смены ориентации
class VideoFullscreenScreen extends StatefulWidget {
  final VideoPlayerController controller;
  final String cameraName;

  const VideoFullscreenScreen({
    super.key,
    required this.controller,
    required this.cameraName,
  });

  @override
  State<VideoFullscreenScreen> createState() => _VideoFullscreenScreenState();
}

class _VideoFullscreenScreenState extends State<VideoFullscreenScreen> {
  @override
  void initState() {
    super.initState();
    // Разрешаем все ориентации в полноэкранном режиме
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Скрываем системную панель навигации и статус-бар
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // Восстанавливаем только вертикальную ориентацию при выходе
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Восстанавливаем системную панель
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final aspectRatio = widget.controller.value.aspectRatio > 0
        ? widget.controller.value.aspectRatio
        : 16 / 9;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Видео на весь экран
            Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),
            // Индикатор "LIVE"
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
            // Кнопка закрытия полноэкранного режима
            Positioned(
              top: 16,
              right: 16,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            // Индикатор буферизации
            if (widget.controller.value.isBuffering)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
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
              ),
          ],
        ),
      ),
    );
  }
}

