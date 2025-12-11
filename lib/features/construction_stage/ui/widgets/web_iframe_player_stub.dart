import 'package:flutter/widgets.dart';

/// Заглушка для не-веб платформ.
class WebIframePlayer extends StatelessWidget {
  final String url;

  const WebIframePlayer({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // На нативных платформах не используется.
    return const SizedBox.shrink();
  }
}
