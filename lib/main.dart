import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/ui/screens/login_screen.dart';
import 'features/auth/ui/screens/register_screen.dart';
import 'features/chat/ui/screens/chat_detail_screen.dart';
import 'features/chat/ui/screens/chat_list_screen.dart';
import 'features/construction_completion/ui/screens/completion_status_screen.dart';
import 'features/construction_completion/ui/screens/final_document_detail_screen.dart';
import 'features/construction_stage/ui/screens/construction_site_screen.dart';
import 'features/document_approval/ui/screens/document_detail_screen.dart';
import 'features/document_approval/ui/screens/document_list_screen.dart';
import 'features/main/ui/screens/main_screen.dart';
import 'features/project_selection/ui/screens/project_detail_screen.dart';

void main() async {
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

/// Провайдер роутера с защитой роутов
/// Использует ref.watch для отслеживания изменений авторизации
final routerProvider = Provider<GoRouter>((ref) {
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
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
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
      GoRoute(
        path: '/dev-console',
        builder: (context, state) => const DevConsolePage(),
      ),
    ],
  );
});

class MosstroinformApp extends ConsumerWidget {
  final AppConfigSimple config;

  const MosstroinformApp({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: config.environmentName == 'Production'
          ? 'Стройконтроль Онлайн'
          : 'Стройконтроль ${config.environmentName}',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        LoggerL10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', ''), Locale('en', '')],
      routerConfig: router,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            // Кнопка открытия dev console в debug режиме
            if (kDebugMode)
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 8,
                child: _DevConsoleButton(),
              ),
          ],
        );
      },
    );
  }
}

/// Кнопка для открытия dev console в debug режиме
class _DevConsoleButton extends ConsumerWidget {
  const _DevConsoleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final router = ref.read(routerProvider);
          router.push('/dev-console');
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.bug_report, color: Colors.white, size: 12),
        ),
      ),
    );
  }
}
