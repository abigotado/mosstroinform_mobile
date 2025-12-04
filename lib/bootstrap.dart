import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/app.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';

/// Функция инициализации и запуска приложения
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Получаем flavor из константы компиляции или используем mock по умолчанию
  final flavor = AppConfigSimple.getFlavor();

  // Инициализируем конфигурацию
  final config = AppConfigSimple.fromFlavor(flavor);

  // Инициализируем логгер перед использованием
  await AppLogger.init(showLogs: kDebugMode || config.useMocks);

  // В production можно логировать текущее окружение
  AppLogger.log('Запуск приложения с flavor: $flavor');
  AppLogger.log('Окружение: ${config.environmentName}');
  AppLogger.log('Использование моков: ${config.useMocks}');
  AppLogger.log('Base URL: ${config.baseUrl}');

  runApp(
    ProviderScope(
      observers: [AppLogger.riverpodObserver],
      child: MosstroinformApp(config: config),
    ),
  );
}
