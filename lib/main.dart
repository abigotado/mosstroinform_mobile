import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MosstroinformApp(),
    ),
  );
}

class MosstroinformApp extends StatelessWidget {
  const MosstroinformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Стройконтроль Онлайн',
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
      home: const Scaffold(
        body: Center(
          child: Text('Стройконтроль Онлайн'),
        ),
      ),
    );
  }
}
