import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

import 'core/config/app_config_simple.dart';
import 'core/theme/app_theme.dart';
import 'features/project_selection/ui/screens/project_detail_screen.dart';
import 'features/project_selection/ui/screens/project_list_screen.dart';

void main() {
  // Получаем flavor из константы компиляции или используем dev по умолчанию
  final flavor = AppConfigSimple.getFlavor();
  
  // Инициализируем конфигурацию
  final config = AppConfigSimple.fromFlavor(flavor);
  
  // В production можно логировать текущее окружение
  debugPrint('Запуск приложения с flavor: $flavor');
  debugPrint('Окружение: ${config.environmentName}');
  debugPrint('Использование моков: ${config.useMocks}');
  debugPrint('Base URL: ${config.baseUrl}');

  runApp(
    ProviderScope(
      child: MosstroinformApp(config: config),
    ),
  );
}

/// Роутер приложения
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProjectListScreen(),
    ),
    GoRoute(
      path: '/projects/:id',
      builder: (context, state) {
        final projectId = state.pathParameters['id']!;
        return ProjectDetailScreen(projectId: projectId);
      },
    ),
  ],
);

class MosstroinformApp extends StatelessWidget {
  final AppConfigSimple config;

  const MosstroinformApp({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: config.environmentName == 'Production'
          ? 'Стройконтроль Онлайн'
          : 'Стройконтроль ${config.environmentName}',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
          ],
      routerConfig: _router,
    );
  }
}
