import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/app.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/core/database/hive_service.dart';

/// Функция инициализации и запуска приложения
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Получаем flavor из константы компиляции или используем mock по умолчанию
  final flavor = AppConfigSimple.getFlavor();

  // Инициализируем конфигурацию
  final config = AppConfigSimple.fromFlavor(flavor);

  // Инициализируем логгер перед использованием
  await AppLogger.init(showLogs: kDebugMode || config.useMocks);

  // Устанавливаем только вертикальную ориентацию для всего приложения
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // В production можно логировать текущее окружение
  AppLogger.log('Запуск приложения с flavor: $flavor');
  AppLogger.log('Окружение: ${config.environmentName}');
  AppLogger.log('Использование моков: ${config.useMocks}');
  AppLogger.log('Base URL: ${config.baseUrl}');

  // Инициализируем Hive базу данных в моковом режиме
  if (config.useMocks) {
    try {
      await HiveService.initialize();
      AppLogger.log('Hive база данных инициализирована');
    } catch (e) {
      AppLogger.error('Ошибка при инициализации Hive: $e');
      // Не прерываем запуск приложения, даже если Hive не удалось инициализировать
    }
  }

  runApp(
    ProviderScope(
      observers: [AppLogger.riverpodObserver],
      child: MosstroinformApp(config: config),
    ),
  );
}
