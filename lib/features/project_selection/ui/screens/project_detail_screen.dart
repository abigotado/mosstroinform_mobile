import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/requested_projects_state.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
// import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_stage_item.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран детального просмотра проекта
class ProjectDetailScreen extends ConsumerStatefulWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends ConsumerState<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем проект при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(projectProvider.notifier).loadProject(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projectAsync = ref.watch(projectProvider);
    final theme = Theme.of(context);
    final requestedIds = ref.watch(requestedProjectsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.projectDetails),
        actions: [
          Builder(
            builder: (context) {
              // Проверяем статус проекта и документов
              final projectState = projectAsync.maybeWhen(
                data: (state) => state.project,
                orElse: () => null,
              );

              if (projectState == null) return const SizedBox.shrink();

              // TODO: Проверять через ConstructionObjectRepository, существует ли объект для этого проекта
              // TODO: Показывать кнопки навигации к объекту строительства
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: projectAsync.when(
          data: (state) {
            // Если проект не загружен и нет ошибки - это начальное состояние, показываем шиммер
            if (state.project == null && state.error == null) {
              return const ProjectDetailShimmer(key: ValueKey('shimmer'));
            }

            // Если проект не найден и есть ошибка - показываем ошибку
            if (state.project == null) {
              return Center(
                key: const ValueKey('error'),
                child: Text(l10n.projectNotFound),
              );
            }

            final project = state.project!;

            return SingleChildScrollView(
              key: const ValueKey('content'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Изображение проекта
                  if (project.imageUrl != null)
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        project.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Ошибка загрузки изображения: $error');
                          debugPrint('URL: ${project.imageUrl}');
                          return Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 64),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Center(child: Icon(Icons.home, size: 64)),
                      ),
                    ),

                  // Информация о проекте
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Название и адрес
                        Text(
                          project.name,
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.address,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Описание
                        Text(
                          project.description,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),

                        // Характеристики
                        _CharacteristicsSection(project: project),
                        const SizedBox(height: 24),

                        // Цена
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.price,
                                style: theme.textTheme.titleLarge,
                              ),
                              Text(
                                _formatPrice(project.price),
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const ProjectDetailShimmer(),
          error: (error, stack) {
            final errorTheme = Theme.of(context);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.error}: $error',
                    style: errorTheme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(projectProvider.notifier)
                          .loadProject(widget.projectId);
                    },
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: projectAsync.when(
        data: (state) {
          if (state.project == null) return const SizedBox.shrink();

          // Проверяем, запрошен ли проект
          final isRequested = requestedIds.contains(widget.projectId);
          final isRequesting = state.isRequestingConstruction;

          return AppAnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isRequested
                ? const SizedBox.shrink(key: ValueKey('hidden'))
                : SafeArea(
                    key: const ValueKey('button'),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Tooltip(
                          message: l10n.sendConstructionRequest,
                          child: ElevatedButton(
                            onPressed: isRequesting
                                ? null
                                : () async {
                                    AppLogger.debug(
                                      'Нажата кнопка "Отправить запрос на строительство"',
                                    );
                                    AppLogger.debug(
                                      'projectId: ${widget.projectId}',
                                    );
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );

                                    try {
                                      await ref
                                          .read(projectProvider.notifier)
                                          .requestConstruction(
                                            widget.projectId,
                                          );
                                      AppLogger.info(
                                        'Запрос на строительство отправлен успешно',
                                      );

                                      if (mounted) {
                                        messenger.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              l10n.constructionRequestSent,
                                            ),
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      AppLogger.error(
                                        'Ошибка при отправке запроса',
                                        e,
                                      );
                                      if (mounted) {
                                        messenger.showSnackBar(
                                          SnackBar(
                                            content: Text('${l10n.error}: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: AppAnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: isRequesting
                                  ? SizedBox(
                                      key: const ValueKey('loading'),
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              theme.colorScheme.onPrimary,
                                            ),
                                      ),
                                    )
                                  : Text(
                                      l10n.requestConstruction,
                                      key: const ValueKey('text'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }

  static String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} млн';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} тыс';
    }
    return price.toString();
  }
}

/// Виджет секции характеристик проекта
class _CharacteristicsSection extends StatelessWidget {
  final Project project;

  const _CharacteristicsSection({required this.project});

  String _getBedroomsText(int bedrooms) {
    if (bedrooms == 1) return 'спальня';
    if (bedrooms >= 2 && bedrooms <= 4) return 'спальни';
    return 'спален';
  }

  String _getBathroomsText(int bathrooms) {
    if (bathrooms == 1) return 'ванная';
    if (bathrooms >= 2 && bathrooms <= 4) return 'ванные';
    return 'ванных';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _CharacteristicRow(
              label: l10n.area,
              value: '${project.area.toInt()} м²',
              icon: Icons.square_foot,
            ),
            const Divider(),
            _CharacteristicRow(
              label: l10n.floors,
              value:
                  '${project.floors} ${project.floors > 1 ? l10n.floorsPlural : l10n.floor}',
              icon: Icons.layers,
            ),
            const Divider(),
            _CharacteristicRow(
              label: 'Спальни',
              value:
                  '${project.bedrooms} ${_getBedroomsText(project.bedrooms)}',
              icon: Icons.bed,
            ),
            const Divider(),
            _CharacteristicRow(
              label: 'Ванные',
              value:
                  '${project.bathrooms} ${_getBathroomsText(project.bathrooms)}',
              icon: Icons.bathtub,
            ),
          ],
        ),
      ),
    );
  }
}

/// Виджет строки характеристики
class _CharacteristicRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _CharacteristicRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 24, color: theme.colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
