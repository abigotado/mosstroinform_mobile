// platformViewRegistry доступен в dart:ui_web на вебе
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

class WebIframePlayer extends StatefulWidget {
  final String url;

  const WebIframePlayer({super.key, required this.url});

  @override
  State<WebIframePlayer> createState() => _WebIframePlayerState();
}

class _WebIframePlayerState extends State<WebIframePlayer> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'web-iframe-player-${widget.url.hashCode}';
    // Регистрируем фабрику для iframe
    // Игнорируем повторную регистрацию через try/catch
    try {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src = widget.url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allow = 'autoplay; fullscreen; picture-in-picture'
          ..allowFullscreen = true;
        // Глушим звук по умолчанию для автозапуска
        iframe.setAttribute('muted', 'true');
        return iframe;
      });
    } catch (_) {
      // viewType уже зарегистрирован
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
