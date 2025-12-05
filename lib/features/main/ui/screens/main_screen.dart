import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Главный экран приложения с bottom navigation bar
class MainScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: Tooltip(
              message: l10n.projectsTitle,
              child: const Icon(Icons.home),
            ),
            selectedIcon: Tooltip(
              message: l10n.projectsTitle,
              child: const Icon(Icons.home),
            ),
            label: l10n.projectsTitle,
          ),
          NavigationDestination(
            icon: Tooltip(
              message: l10n.requestedProjectsTitle,
              child: const Icon(Icons.pending_actions),
            ),
            selectedIcon: Tooltip(
              message: l10n.requestedProjectsTitle,
              child: const Icon(Icons.pending_actions),
            ),
            label: l10n.requestedProjectsTitle,
          ),
          NavigationDestination(
            icon: Tooltip(
              message: l10n.myObjectsTitle,
              child: const Icon(Icons.construction),
            ),
            selectedIcon: Tooltip(
              message: l10n.myObjectsTitle,
              child: const Icon(Icons.construction),
            ),
            label: l10n.myObjectsTitle,
          ),
          NavigationDestination(
            icon: Tooltip(
              message: l10n.profileTitle,
              child: const Icon(Icons.person),
            ),
            selectedIcon: Tooltip(
              message: l10n.profileTitle,
              child: const Icon(Icons.person),
            ),
            label: l10n.profileTitle,
          ),
        ],
      ),
    );
  }
}
