import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран входа в систему
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    // Очищаем креды только при закрытии экрана (после успешного входа)
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Сохраняем значения перед блокировкой полей
    final emailValue = _emailController.text;
    final passwordValue = _passwordController.text;

    AppLogger.info('LoginScreen._handleLogin: начало, email=$emailValue');

    try {
      AppLogger.info(
        'LoginScreen._handleLogin: вызов authProvider.notifier.login',
      );
      await ref
          .read(authProvider.notifier)
          .login(emailValue.trim(), passwordValue);
      AppLogger.info('LoginScreen._handleLogin: login завершен успешно');

      // Роутер автоматически перенаправит благодаря refreshListenable и redirect логике
      // Не нужно вызывать context.go('/') вручную
    } on Failure catch (e) {
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: theme.colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toLocalizedMessage(context)),
            backgroundColor: theme.colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Логотип или заголовок
                      Icon(
                        Icons.home,
                        size: 80,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        l10n.loginTitle,
                        style: theme.textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Email поле
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: l10n.emailLabel,
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.enterEmail;
                          }
                          if (!value.contains('@')) {
                            return l10n.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Пароль поле
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          if (!isLoading) {
                            _handleLogin();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: l10n.passwordLabel,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: isLoading
                                ? null
                                : () {
                                    setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    );
                                  },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.enterPassword;
                          }
                          if (value.length < 6) {
                            return l10n.passwordMinLength;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Кнопка входа
                      ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.loginButton),
                      ),
                      const SizedBox(height: 16),

                      // Ссылка на регистрацию
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                context.push('/register');
                              },
                        child: Text(l10n.noAccount),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
