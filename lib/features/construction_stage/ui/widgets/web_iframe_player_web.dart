// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

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
      ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final iframe = html.IFrameElement()
          ..src = widget.url
          ..style.border = 'none'
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

