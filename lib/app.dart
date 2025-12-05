import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/l10n/generated/l10n.dart';
import 'package:mosstroinform_mobile/core/config/app_config_simple.dart';
import 'package:mosstroinform_mobile/core/router/router_provider.dart';
import 'package:mosstroinform_mobile/core/theme/app_theme.dart';
import 'package:mosstroinform_mobile/core/theme/theme_provider.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

class MosstroinformApp extends ConsumerWidget {
  final AppConfigSimple config;

  const MosstroinformApp({super.key, required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: config.environmentName == 'Production'
          ? 'Стройконтроль Онлайн'
          : 'Стройконтроль ${config.environmentName}',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        LoggerL10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', ''), Locale('en', '')],
      routerConfig: router,
    );
  }
}
