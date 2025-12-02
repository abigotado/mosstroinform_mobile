import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

import 'core/config/app_config_simple.dart';
import 'core/theme/app_theme.dart';
import 'features/chat/ui/screens/chat_detail_screen.dart';
import 'features/chat/ui/screens/chat_list_screen.dart';
import 'features/construction_completion/ui/screens/completion_status_screen.dart';
import 'features/construction_completion/ui/screens/final_document_detail_screen.dart';
import 'features/construction_stage/ui/screens/construction_site_screen.dart';
import 'features/document_approval/ui/screens/document_detail_screen.dart';
import 'features/document_approval/ui/screens/document_list_screen.dart';
import 'features/project_selection/ui/screens/project_detail_screen.dart';
import 'features/project_selection/ui/screens/project_list_screen.dart';

void main() {
  // Получаем flavor из константы компиляции или используем dev по умолчанию
  final flavor = AppConfigSimple.getFlavor();
  
  // Инициализируем конфигурацию
  final config = AppConfigSimple.fromFlavor(flavor);
  
  // В production можно логировать текущее окружение
  AppLogger.info('Запуск приложения с flavor: $flavor');
  AppLogger.info('Окружение: ${config.environmentName}');
  AppLogger.info('Использование моков: ${config.useMocks}');
  AppLogger.info('Base URL: ${config.baseUrl}');

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
    GoRoute(
      path: '/documents',
      builder: (context, state) => const DocumentListScreen(),
    ),
    GoRoute(
      path: '/documents/:id',
      builder: (context, state) {
        final documentId = state.pathParameters['id']!;
        return DocumentDetailScreen(documentId: documentId);
      },
    ),
    GoRoute(
      path: '/construction/:projectId',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        return ConstructionSiteScreen(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/completion/:projectId',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        return CompletionStatusScreen(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/completion/:projectId/documents/:documentId',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        final documentId = state.pathParameters['documentId']!;
        return FinalDocumentDetailScreen(
          projectId: projectId,
          documentId: documentId,
        );
      },
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: '/chats/:chatId',
      builder: (context, state) {
        final chatId = state.pathParameters['chatId']!;
        return ChatDetailScreen(chatId: chatId);
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
