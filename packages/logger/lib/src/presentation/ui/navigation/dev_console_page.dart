import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/src/presentation/notifier/dev_console_notifier.dart';
import 'package:logger/src/presentation/ui/screen/dev_console_screen.dart';

/// Страница dev console для go_router
class DevConsolePage extends ConsumerWidget {
  const DevConsolePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Загружаем информацию при открытии страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devConsoleProvider.notifier).fetchDebugInfo();
    });

    return const DevConsoleScreen();
  }
}
