import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/projects_mock_data.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/requested_projects_state.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран запрошенных проектов
class RequestedProjectsScreen extends ConsumerWidget {
  const RequestedProjectsScreen({super.key});

  List<Project> _getRequestedProjects(Set<String> requestedIds) {
    // Получаем все проекты из мок-данных
    final mockData = ProjectsMockData.projects;
    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    final allAvailableProjects = models.map((model) => model.toEntity()).toList();
    
    // Фильтруем проекты: оставляем только запрошенные
    return allAvailableProjects.where((project) => requestedIds.contains(project.id)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final requestedIds = ref.watch(requestedProjectsStateProvider);
    final requestedProjects = _getRequestedProjects(requestedIds);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestedProjectsTitle)),
      body: requestedProjects.isEmpty
          ? Center(
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
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Обновление происходит автоматически через watch
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
            ),
    );
  }
}
