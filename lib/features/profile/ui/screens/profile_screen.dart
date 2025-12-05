import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/theme/theme_provider.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран профиля пользователя
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: authState.when(
        data: (state) {
          final user = state.user;
          if (user == null) {
            return Center(
              child: Text(
                l10n.errorOccurred('Пользователь не найден'),
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Аватар и основная информация
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : 'U',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(user.name, style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      if (user.phone != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          user.phone!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Переключатель темы
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.brightness_6),
                      title: Text('Тема приложения'),
                      subtitle: Text(_getThemeModeText(ref.watch(themeModeProvider))),
                    ),
                    Divider(height: 1),
                    // ignore: deprecated_member_use
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.light,
                      // ignore: deprecated_member_use
                      groupValue: ref.watch(themeModeProvider),
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                      title: Text('Светлая'),
                      secondary: Icon(Icons.light_mode),
                    ),
                    // ignore: deprecated_member_use
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.dark,
                      // ignore: deprecated_member_use
                      groupValue: ref.watch(themeModeProvider),
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                      title: Text('Темная'),
                      secondary: Icon(Icons.dark_mode),
                    ),
                    // ignore: deprecated_member_use
                    RadioListTile<ThemeMode>(
                      value: ThemeMode.system,
                      // ignore: deprecated_member_use
                      groupValue: ref.watch(themeModeProvider),
                      // ignore: deprecated_member_use
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                      title: Text('Системная'),
                      secondary: Icon(Icons.brightness_auto),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Кнопка выхода
              Card(
                child: ListTile(
                  leading: Icon(Icons.logout, color: theme.colorScheme.error),
                  title: Text(
                    l10n.logout,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  onTap: () async {
                    AppLogger.info('ProfileScreen: нажата кнопка выхода');
                    try {
                      await ref.read(authProvider.notifier).logout();
                      AppLogger.info('ProfileScreen: выход выполнен успешно');
                      if (context.mounted) {
                        context.go('/login');
                      }
                    } catch (e) {
                      AppLogger.error('ProfileScreen: ошибка при выходе: $e');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ошибка при выходе: $e'),
                            backgroundColor: theme.colorScheme.error,
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                error.toLocalizedMessage(context),
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Темная';
      case ThemeMode.system:
        return 'Системная (следует настройкам устройства)';
    }
  }
}
