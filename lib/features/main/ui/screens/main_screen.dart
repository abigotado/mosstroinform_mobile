import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Главный экран приложения с адаптивной навигацией
/// Использует NavigationRail для десктопных платформ и NavigationBar для мобильных
class MainScreen extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      // Fallback если локализация еще не загружена
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Определяем, использовать ли десктопную навигацию (ширина > 600px)
    final isDesktop = MediaQuery.of(context).size.width > 600;

    // Создаем дестinations один раз
    final destinations = [
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
    ];

    if (isDesktop) {
      // Десктопная версия с NavigationRail
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              labelType: NavigationRailLabelType.all,
              destinations: destinations.map((dest) {
                return NavigationRailDestination(
                  icon: dest.icon,
                  selectedIcon: dest.selectedIcon,
                  label: Text(dest.label),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    } else {
      // Мобильная версия с NavigationBar
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
          destinations: destinations,
        ),
      );
    }
  }
}
