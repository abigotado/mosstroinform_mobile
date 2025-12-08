import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/auth/notifier/auth_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_card.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

/// Экран списка проектов с поиском и пагинацией
class ProjectListScreen extends ConsumerStatefulWidget {
  const ProjectListScreen({super.key});

  @override
  ConsumerState<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends ConsumerState<ProjectListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  int _currentPage = 0;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    // Загружаем проекты при инициализации только если пользователь авторизован
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authProvider);
      if (authState.value?.isAuthenticated == true) {
        ref.read(projectsProvider.notifier).loadProjects();
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // Загружаем следующую страницу при достижении 80% прокрутки
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    final projectsAsync = ref.read(projectsProvider);
    projectsAsync.maybeWhen(
      data: (state) {
        final filteredProjects = _filterProjects(state.projects);
        final totalPages = (filteredProjects.length / _itemsPerPage).ceil();
        if (_currentPage < totalPages - 1) {
          setState(() {
            _currentPage++;
          });
        }
      },
      orElse: () {},
    );
  }

  List<Project> _filterProjects(List<Project> projects) {
    if (_searchQuery.isEmpty) {
      return projects;
    }
    final query = _searchQuery.toLowerCase();
    return projects.where((project) {
      return project.name.toLowerCase().contains(query) ||
          project.description.toLowerCase().contains(query);
    }).toList();
  }

  List<Project> _getPaginatedProjects(List<Project> projects) {
    final filtered = _filterProjects(projects);
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, filtered.length);
    return filtered.sublist(0, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final projectsAsync = ref.watch(projectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectsTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                            _currentPage = 0;
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _currentPage = 0;
                });
              },
            ),
          ),
        ),
      ),
      body: projectsAsync.when(
        data: (state) {
          // Если список пустой и загружается - показываем шиммер
          if (state.projects.isEmpty && state.isLoading) {
            return AppAnimatedSwitcher(
              key: const ValueKey('shimmer-empty'),
              child: ListView.builder(
                key: const ValueKey('shimmer-list'),
                padding: const EdgeInsets.all(16),
                itemCount: 3, // Фиксированное количество для шиммеров
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: ProjectCardShimmer(),
                  );
                },
              ),
            );
          }

          // Если список пустой после загрузки (с ошибкой) - показываем сообщение
          if (state.projects.isEmpty && !state.isLoading) {
            return AppAnimatedSwitcher(
              key: const ValueKey('empty-state'),
              child: Center(
                key: const ValueKey('empty-content'),
                child: Text(l10n.projectsNotFound),
              ),
            );
          }

          if (state.error != null) {
            return AppAnimatedSwitcher(
              key: const ValueKey('error-state'),
              child: Center(
                key: const ValueKey('error-content'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
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
              ),
            );
          }

          final paginatedProjects = _getPaginatedProjects(state.projects);
          final filteredProjects = _filterProjects(state.projects);
          final hasMore = paginatedProjects.length < filteredProjects.length;

          return AppAnimatedSwitcher(
            key: ValueKey('list-${paginatedProjects.length}-${state.isLoading}'),
            child: RefreshIndicator(
              key: ValueKey('refresh-${paginatedProjects.length}'),
              onRefresh: () async {
                setState(() {
                  _currentPage = 0;
                });
                await ref.read(projectsProvider.notifier).loadProjects();
              },
              child: state.isLoading && paginatedProjects.isEmpty
                  ? ListView.builder(
                      key: const ValueKey('shimmer-list-inner'),
                      padding: const EdgeInsets.all(16),
                      itemCount: 3, // Фиксированное количество для шиммеров
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: ProjectCardShimmer(),
                        );
                      },
                    )
                  : paginatedProjects.isEmpty
                  ? Center(
                      key: const ValueKey('empty-inner'),
                      child: Text(l10n.projectsNotFound),
                    )
                  : ListView.builder(
                      key: ValueKey('projects-list-${paginatedProjects.length}'),
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: paginatedProjects.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == paginatedProjects.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final project = paginatedProjects[index];
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
        },
        loading: () => AppAnimatedSwitcher(
          key: const ValueKey('loading-initial'),
          child: ListView.builder(
            key: const ValueKey('loading-list'),
            padding: const EdgeInsets.all(16),
            itemCount: 3, // Фиксированное количество для шиммеров
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ProjectCardShimmer(),
              );
            },
          ),
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
