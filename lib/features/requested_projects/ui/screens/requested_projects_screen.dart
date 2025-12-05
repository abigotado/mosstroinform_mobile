import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/requested_projects_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран запрошенных проектов
class RequestedProjectsScreen extends ConsumerWidget {
  const RequestedProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final requestedProjectsAsync = ref.watch(requestedProjectsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestedProjectsTitle)),
      body: requestedProjectsAsync.when(
        data: (requestedProjects) {
          if (requestedProjects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pending_actions,
                    size: 64,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noRequestedProjects,
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(requestedProjectsProvider.notifier)
                  .loadRequestedProjects();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requestedProjects.length,
              itemBuilder: (context, index) {
                final project = requestedProjects[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ProjectCard(
                    project: project,
                    onTap: () {
                      context.push('/projects/${project.id}');
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                '${l10n.error}: $error',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(requestedProjectsProvider.notifier)
                      .loadRequestedProjects();
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
