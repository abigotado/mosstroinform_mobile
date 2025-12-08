import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/features/auth/ui/screens/login_screen.dart';
import 'package:mosstroinform_mobile/features/auth/ui/screens/register_screen.dart';
import 'package:mosstroinform_mobile/features/chat/ui/screens/chat_detail_screen.dart';
import 'package:mosstroinform_mobile/features/chat/ui/screens/chat_list_screen.dart';
import 'package:mosstroinform_mobile/features/chat/ui/screens/object_chat_screen.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/screens/completion_status_screen.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/screens/final_document_detail_screen.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/screens/construction_site_screen.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/screens/document_detail_screen.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/screens/document_list_screen.dart';
import 'package:mosstroinform_mobile/features/main/ui/screens/main_screen.dart';
import 'package:mosstroinform_mobile/features/my_objects/ui/screens/my_objects_screen.dart';
import 'package:mosstroinform_mobile/features/profile/ui/screens/profile_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/project_detail_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/project_list_screen.dart';
import 'package:mosstroinform_mobile/features/requested_projects/ui/screens/requested_projects_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

/// ChangeNotifier для уведомления GoRouter об изменениях авторизации
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(this.ref) {
    // Слушаем изменения authProvider и уведомляем роутер
    ref.listen<AsyncValue<AuthState>>(authProvider, (previous, next) {
      _currentState = next;
      notifyListeners();
    });
    // Инициализируем текущее состояние
    _currentState = ref.read(authProvider);
  }

  final Ref ref;
  AsyncValue<AuthState> _currentState = const AsyncValue.loading();

  AsyncValue<AuthState> get currentState => _currentState;
}

/// Провайдер роутера с защитой роутов
/// Использует refreshListenable для обновления redirect логики без пересоздания роутера
@riverpod
GoRouter router(Ref ref) {
  // Создаем ChangeNotifier для refreshListenable
  final authChangeNotifier = AuthChangeNotifier(ref);

  // Получаем начальное состояние для initialLocation
  final initialAuthState = ref.read(authProvider);

  AppLogger.log(
    'RouterProvider.build: создание роутера, '
    'authState.isLoading=${initialAuthState.isLoading}, '
    'authState.hasValue=${initialAuthState.hasValue}, '
    'isAuthenticated=${initialAuthState.value?.isAuthenticated ?? false}',
  );

  // Определяем начальный роут на основе состояния авторизации
  // Важно: если не авторизован, сразу устанавливаем /login, чтобы не создавать защищенные экраны
  String initialLocation = '/login';
  if (initialAuthState.hasValue) {
    final isAuthenticated = initialAuthState.value?.isAuthenticated ?? false;
    if (isAuthenticated) {
      initialLocation = '/';
    } else {
      initialLocation = '/login';
    }
  } else if (initialAuthState.isLoading) {
    // Пока загружается, показываем логин (будет редирект на / если авторизован)
    initialLocation = '/login';
  } else {
    // Если ошибка или не авторизован, показываем логин
    initialLocation = '/login';
  }

  AppLogger.log('RouterProvider.build: initialLocation=$initialLocation');

  return GoRouter(
    debugLogDiagnostics: false, // Отключаем debug логи GoRouter
    observers: [AppLogger.routeObserver],
    initialLocation: initialLocation,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      // Читаем текущее состояние из AuthChangeNotifier
      final authState = authChangeNotifier.currentState;

      // Если авторизация еще загружается, не делаем редирект
      if (authState.isLoading) {
        AppLogger.log('Router.redirect: авторизация загружается, ожидание...');
        return null;
      }

      // Используем текущее значение из AuthChangeNotifier
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      final isLoginRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';
      final isDevConsoleRoute = state.matchedLocation == '/dev-console';
      final isMainRoute =
          state.matchedLocation == '/' ||
          state.matchedLocation == '/requested' ||
          state.matchedLocation == '/objects' ||
          state.matchedLocation == '/profile';

      AppLogger.log(
        'Router.redirect: matchedLocation=${state.matchedLocation}, '
        'isAuthenticated=$isAuthenticated, isLoginRoute=$isLoginRoute, '
        'isDevConsoleRoute=$isDevConsoleRoute, isMainRoute=$isMainRoute, '
        'authState.hasValue=${authState.hasValue}',
      );

      // Dev console доступна без авторизации
      if (isDevConsoleRoute) {
        AppLogger.log('Router.redirect: dev console доступна без авторизации');
        return null;
      }

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
      // Маршруты авторизации без bottom navigation
      ShellRoute(
        pageBuilder: (context, state, child) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
          child: Stack(
            children: [
              child,
              if (AppLogger.showDebugFeatures) const DebugLoggerOverlay(),
            ],
          ),
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
        ],
      ),
      // Главный экран с bottom navigation используя StatefulShellRoute
      // Все остальные маршруты вложены внутрь для сохранения bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Stack(
            children: [
              MainScreen(navigationShell: navigationShell),
              if (AppLogger.showDebugFeatures) const DebugLoggerOverlay(),
            ],
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const ProjectListScreen(),
              ),
              // Вложенные маршруты для первого таба
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
                path: '/construction/:objectId',
                builder: (context, state) {
                  final objectId = state.pathParameters['objectId']!;
                  return ConstructionSiteScreen(objectId: objectId);
                },
              ),
              GoRoute(
                path: '/construction/:projectId/chat',
                builder: (context, state) {
                  final projectId = state.pathParameters['projectId']!;
                  return ObjectChatScreen(projectId: projectId);
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/requested',
                builder: (context, state) => const RequestedProjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/objects',
                builder: (context, state) => const MyObjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
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
          ),
        ],
      ),
      // Dev console вне bottom navigation
      ShellRoute(
        pageBuilder: (context, state, child) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
          child: Stack(
            children: [
              child,
              if (AppLogger.showDebugFeatures) const DebugLoggerOverlay(),
            ],
          ),
        ),
        routes: [
          GoRoute(
            path: '/dev-console',
            builder: (context, state) => const DevConsolePage(),
          ),
        ],
      ),
    ],
  );
}
