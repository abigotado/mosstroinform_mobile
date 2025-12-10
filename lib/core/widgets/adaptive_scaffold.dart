import 'package:flutter/material.dart';

/// Виджет для ограничения ширины контента на больших экранах
/// Центрирует контент и устанавливает максимальную ширину
class AdaptiveScaffold extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;

  const AdaptiveScaffold({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // По умолчанию используем 1200px для больших экранов
    final effectiveMaxWidth = maxWidth ?? 1200.0;
    final screenWidth = MediaQuery.of(context).size.width;

    // Если экран меньше максимальной ширины, используем всю ширину
    if (screenWidth < effectiveMaxWidth) {
      return Padding(padding: padding ?? EdgeInsets.zero, child: child);
    }

    // На больших экранах центрируем контент
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}
