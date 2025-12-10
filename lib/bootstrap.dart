import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/app.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';

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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // В production можно логировать текущее окружение
  AppLogger.log('Запуск приложения с flavor: $flavor');
  AppLogger.log('Окружение: ${config.environmentName}');
  AppLogger.log('Использование моков: ${config.useMocks}');
  AppLogger.log('Base URL: ${config.baseUrl}');

  // Инициализируем settings box для хранения настроек (тема и т.д.) в любом режиме
  try {
    await HiveService.initializeSettings();
    AppLogger.log('Hive settings box инициализирован');
  } catch (e) {
    AppLogger.error('Ошибка при инициализации Hive settings: $e');
    // Не прерываем запуск приложения, даже если Hive не удалось инициализировать
  }

  // Инициализируем полную Hive базу данных в моковом режиме
  if (config.useMocks) {
    try {
      await HiveService.initialize();
      AppLogger.log('Hive база данных инициализирована');
    } catch (e) {
      AppLogger.error('Ошибка при инициализации Hive: $e');
      // Не прерываем запуск приложения, даже если Hive не удалось инициализировать
    }
  }

  // Создаем контейнер для предзагрузки авторизации
  // Этот контейнер будет использоваться на протяжении всего жизненного цикла приложения
  final container = ProviderContainer(
    observers: [AppLogger.riverpodObserver],
  );

  // Предзагружаем состояние авторизации до запуска приложения
  // Это позволяет роутеру сразу определить правильный initialLocation
  AppLogger.log('Bootstrap: проверка авторизации...');
  try {
    final authState = await container.read(authProvider.future);
    AppLogger.log(
      'Bootstrap: авторизация проверена, isAuthenticated=${authState.isAuthenticated}, '
      'user=${authState.user?.email ?? "null"}',
    );
  } catch (e) {
    AppLogger.error('Bootstrap: ошибка при проверке авторизации: $e');
    // Продолжаем запуск даже при ошибке - роутер покажет экран логина
  }

  // Запускаем приложение с предзагруженным контейнером
  // UncontrolledProviderScope позволяет использовать предзагруженный контейнер
  // Контейнер будет автоматически dispose при закрытии приложения через Flutter
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MosstroinformApp(config: config),
    ),
  );
}
