import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';

/// Экран списка проектов
class ProjectListScreen extends ConsumerStatefulWidget {
  const ProjectListScreen({super.key});

  @override
  ConsumerState<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends ConsumerState<ProjectListScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем проекты при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(projectsProvider.notifier).loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projectsAsync = ref.watch(projectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectsTitle),
        // Кнопка для быстрого перехода к экрану камер (для тестирования)
        actions: [
          Builder(
            builder: (context) {
              final projectsAsync = ref.watch(projectsProvider);
              return projectsAsync.maybeWhen(
                data: (state) {
                  final firstProject = state.projects.isNotEmpty
                      ? state.projects.first
                      : null;
                  return IconButton(
                    icon: const Icon(Icons.videocam),
                    tooltip: firstProject != null
                        ? 'Перейти к камерам: ${firstProject.name}'
                        : 'Перейти к камерам',
                    onPressed: firstProject != null
                        ? () {
                            context.push('/construction/${firstProject.id}');
                          }
                        : null,
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: projectsAsync.when(
        data: (state) {
          // Если список пустой и нет ошибки - это начальное состояние, показываем шиммер
          // (начальное состояние возвращается как data с пустым списком)
          if (state.projects.isEmpty && state.error == null) {
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

          // Если список пустой после загрузки (с ошибкой) - показываем сообщение
          if (state.projects.isEmpty && !state.isLoading) {
            return Center(child: Text(l10n.projectsNotFound));
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
                    style: Theme.of(context).textTheme.bodyLarge,
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
            child: state.isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: ProjectCardShimmer(),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.projects.length,
                    itemBuilder: (context, index) {
                      final project = state.projects[index];
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
                style: Theme.of(context).textTheme.bodyLarge,
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
