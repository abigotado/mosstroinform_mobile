import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

/// Экран запрошенных проектов
class RequestedProjectsScreen extends ConsumerStatefulWidget {
  const RequestedProjectsScreen({super.key});

  @override
  ConsumerState<RequestedProjectsScreen> createState() =>
      _RequestedProjectsScreenState();
}

class _RequestedProjectsScreenState
    extends ConsumerState<RequestedProjectsScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем проекты при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(projectsProvider.notifier).loadProjects();
    });
  }

  List<Project> _getRequestedProjects(List<Project> projects) {
    return projects.where((project) {
      // Проект считается запрошенным, если хотя бы один этап имеет статус inProgress или completed
      return project.stages.any(
        (stage) => stage.status != StageStatus.pending,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final projectsAsync = ref.watch(projectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.requestedProjectsTitle),
      ),
      body: projectsAsync.when(
        data: (state) {
          final requestedProjects = _getRequestedProjects(state.projects);

          if (state.isLoading && requestedProjects.isEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: ProjectCardShimmer(),
                );
              },
            );
          }

          if (requestedProjects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pending_actions,
                    size: 64,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
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

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.error}: ${state.error!.message}',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(projectsProvider.notifier).loadProjects();
                    },
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(projectsProvider.notifier).loadProjects();
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
        loading: () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: ProjectCardShimmer(),
            );
          },
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                '${l10n.error}: $error',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(projectsProvider.notifier).loadProjects();
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

