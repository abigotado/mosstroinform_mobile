import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/features/main/ui/providers/main_navigation_provider.dart';
import 'package:mosstroinform_mobile/features/my_objects/ui/screens/my_objects_screen.dart';
import 'package:mosstroinform_mobile/features/profile/ui/screens/profile_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/project_list_screen.dart';
import 'package:mosstroinform_mobile/features/requested_projects/ui/screens/requested_projects_screen.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Главный экран приложения с bottom navigation bar
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = ref.watch(mainNavigationIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          const ProjectListScreen(),
          const RequestedProjectsScreen(),
          const MyObjectsScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(mainNavigationIndexProvider.notifier).setIndex(index);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: Tooltip(
              message: l10n.projectsTitle,
              child: const Icon(Icons.search),
            ),
            selectedIcon: Tooltip(
              message: l10n.projectsTitle,
              child: const Icon(Icons.search),
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
              child: const Icon(Icons.home),
            ),
            selectedIcon: Tooltip(
              message: l10n.myObjectsTitle,
              child: const Icon(Icons.home),
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
