import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран моих объектов
class MyObjectsScreen extends ConsumerWidget {
  const MyObjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // TODO: Реализовать получение завершенных объектов через ConstructionObjectRepository
    // Пока возвращаем пустой список
    final myObjects = <dynamic>[];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myObjectsTitle)),
      body: myObjects.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noMyObjects,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // TODO: Обновление через ConstructionObjectRepository
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: myObjects.length,
                itemBuilder: (context, index) {
                  // TODO: Использовать ConstructionObject вместо Project
                  return const SizedBox.shrink();
                },
              ),
            ),
    );
  }
}
