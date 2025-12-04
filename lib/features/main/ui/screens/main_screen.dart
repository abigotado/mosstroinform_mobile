import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

import 'package:mosstroinform_mobile/features/main/ui/providers/main_navigation_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/project_list_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/requested_projects_screen.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/screens/my_objects_screen.dart';
import 'package:mosstroinform_mobile/features/auth/ui/screens/profile_screen.dart';

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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.search),
            selectedIcon: const Icon(Icons.search),
            label: l10n.projectsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.pending_actions),
            selectedIcon: const Icon(Icons.pending_actions),
            label: l10n.requestedProjectsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.home),
            selectedIcon: const Icon(Icons.home),
            label: l10n.myObjectsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profileTitle,
          ),
        ],
      ),
    );
  }
}
