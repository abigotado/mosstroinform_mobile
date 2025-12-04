import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/features/auth/ui/screens/login_screen.dart';
import 'package:mosstroinform_mobile/features/auth/ui/screens/register_screen.dart';
import 'package:mosstroinform_mobile/features/chat/ui/screens/chat_detail_screen.dart';
import 'package:mosstroinform_mobile/features/chat/ui/screens/chat_list_screen.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/screens/completion_status_screen.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/screens/final_document_detail_screen.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/screens/construction_site_screen.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/screens/document_detail_screen.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/screens/document_list_screen.dart';
import 'package:mosstroinform_mobile/features/main/ui/screens/main_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/project_detail_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

/// Провайдер роутера с защитой роутов
/// Использует ref.watch для отслеживания изменений авторизации
@riverpod
GoRouter router(Ref ref) {
  // Подписываемся на изменения авторизации, чтобы роутер пересоздавался при изменении
  final authState = ref.watch(authProvider);

  AppLogger.log(
    'RouterProvider.build: создание роутера, '
    'authState.isLoading=${authState.isLoading}, '
    'authState.hasValue=${authState.hasValue}, '
    'isAuthenticated=${authState.value?.isAuthenticated ?? false}',
  );

  // Определяем начальный роут на основе состояния авторизации
  String initialLocation = '/';
  if (authState.hasValue) {
    final isAuthenticated = authState.value?.isAuthenticated ?? false;
    initialLocation = isAuthenticated ? '/' : '/login';
  } else if (authState.isLoading) {
    // Пока загружается, показываем главную (будет редирект если не авторизован)
    initialLocation = '/';
  } else {
    // Если ошибка или не авторизован, показываем логин
    initialLocation = '/login';
  }

  AppLogger.log('RouterProvider.build: initialLocation=$initialLocation');

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    redirect: (context, state) {
      // Если авторизация еще загружается, не делаем редирект
      if (authState.isLoading) {
        AppLogger.log('Router.redirect: авторизация загружается, ожидание...');
        return null;
      }

      // Используем текущее значение из замыкания
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      final isLoginRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      AppLogger.log(
        'Router.redirect: matchedLocation=${state.matchedLocation}, '
        'isAuthenticated=$isAuthenticated, isLoginRoute=$isLoginRoute, '
        'authState.hasValue=${authState.hasValue}',
      );

      // Если пользователь не авторизован и пытается попасть на защищённый роут
      if (!isAuthenticated && !isLoginRoute) {
        AppLogger.log('Router.redirect: не авторизован, редирект на /login');
        return '/login';
      }

      // Если пользователь авторизован и пытается попасть на страницу входа
      if (isAuthenticated && isLoginRoute) {
        AppLogger.log(
          'Router.redirect: авторизован на странице входа, редирект на /',
        );
        return '/';
      }

      AppLogger.log(
        'Router.redirect: разрешена навигация на ${state.matchedLocation}',
      );
      return null; // Разрешаем навигацию
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => Stack(
          children: [
            child,
            if (AppLogger.showDebugFeatures) const DebugLoggerOverlay(),
          ],
        ),
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterScreen(),
          ),
          GoRoute(path: '/', builder: (context, state) => const MainScreen()),
          GoRoute(
            path: '/projects/:id',
            builder: (context, state) {
              final projectId = state.pathParameters['id']!;
              return ProjectDetailScreen(projectId: projectId);
            },
          ),
          GoRoute(
            path: '/documents',
            builder: (context, state) {
              final projectId = state.uri.queryParameters['projectId'];
              return DocumentListScreen(projectId: projectId);
            },
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
          GoRoute(
            path: '/dev-console',
            builder: (context, state) => const DevConsolePage(),
          ),
        ],
      ),
    ],
  );
}
