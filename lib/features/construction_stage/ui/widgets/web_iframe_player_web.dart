// platformViewRegistry доступен в dart:ui_web на вебе
import 'dart:ui_web' as ui_web;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class WebIframePlayer extends StatefulWidget {
  final String url;

  const WebIframePlayer({super.key, required this.url});

  @override
  State<WebIframePlayer> createState() => _WebIframePlayerState();
}

class _WebIframePlayerState extends State<WebIframePlayer> {
  late final String _viewType;
  late final String _secureUrl;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Убеждаемся, что URL использует HTTPS для избежания Mixed Content
    _secureUrl = widget.url.toLowerCase().startsWith('http://')
        ? widget.url.replaceFirst('http://', 'https://')
        : widget.url;
    
    if (kDebugMode) {
      debugPrint('WebIframePlayer: Original URL: ${widget.url}');
      debugPrint('WebIframePlayer: Secure URL: $_secureUrl');
    }
    
    _viewType = 'web-iframe-player-${_secureUrl.hashCode}';
    // Регистрируем фабрику для iframe
    // Игнорируем повторную регистрацию через try/catch
    try {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src = _secureUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allow = 'autoplay; fullscreen; picture-in-picture'
          ..allowFullscreen = true;
        // Глушим звук по умолчанию для автозапуска
        iframe.setAttribute('muted', 'true');
        
        // Добавляем обработчики ошибок для отладки
        iframe.onError.listen((event) {
          if (kDebugMode) {
            debugPrint('WebIframePlayer: Error loading iframe: $event');
          }
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
        
        iframe.onLoad.listen((event) {
          if (kDebugMode) {
            debugPrint('WebIframePlayer: Iframe loaded successfully');
          }
        });
        
        return iframe;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('WebIframePlayer: Error registering view factory: $e');
      }
      // viewType уже зарегистрирован или произошла ошибка
      _hasError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Не удалось загрузить видео',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Сервер не поддерживает HTTPS или недоступен.\nПроверьте настройки сервера MediaMTX.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 16),
                Text(
                  'URL: $_secureUrl',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    }
    
    return HtmlElementView(viewType: _viewType);
  }
}
