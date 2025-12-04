import 'package:flutter/material.dart';

import 'package:logger/l10n/generated/l10n.dart';
import 'package:logger/src/app_logger.dart';

const _buttonSize = 24.0;
const _defaultOffset = Offset(16.0, 48.0);

class DebugLoggerOverlay extends StatefulWidget {
  const DebugLoggerOverlay({this.initialPosition, super.key});

  final Offset? initialPosition;

  @override
  State<DebugLoggerOverlay> createState() => _DebugLoggerOverlayState();
}

class _DebugLoggerOverlayState extends State<DebugLoggerOverlay> {
  late Offset _position = widget.initialPosition ?? _defaultOffset;

  bool get _isVisible => AppLogger.showDebugFeatures;

  @override
  void didUpdateWidget(DebugLoggerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPosition != null && widget.initialPosition != oldWidget.initialPosition) {
      _position = widget.initialPosition!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: _position.dy,
      right: _position.dx,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) {
          final size = MediaQuery.of(context).size;
          setState(() {
            final newRight = (_position.dx - details.delta.dx).clamp(0.0, size.width - _buttonSize);
            final newTop = (_position.dy + details.delta.dy).clamp(0.0, size.height - _buttonSize);
            _position = Offset(newRight, newTop);
          });
        },
        child: _LoggerButton(
          icon: Icons.terminal,
          tooltip: LoggerL10n.of(context).devConsoleOpenConsole,
          onTap: () => AppLogger.openConsole(context),
          size: _buttonSize,
        ),
      ),
    );
  }
}

class _LoggerButton extends StatelessWidget {
  const _LoggerButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.size,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: SizedBox.square(
      dimension: size,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: Size.square(size),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: Colors.black,
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    ),
  );
}
