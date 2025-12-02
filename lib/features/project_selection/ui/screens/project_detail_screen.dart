import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_stage_item.dart';
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
      ref.read(projectNotifierProvider.notifier).loadProject(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projectAsync = ref.watch(projectNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.projectDetails)),
      body: projectAsync.when(
        data: (state) {
          if (state.project == null) {
            return Center(child: Text(l10n.projectNotFound));
          }

          final project = state.project!;

          return SingleChildScrollView(
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
                              value: loadingProgress.expectedTotalBytes != null
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
                      Text(project.name, style: theme.textTheme.headlineMedium),
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
                      _buildCharacteristicsSection(context, project),
                      const SizedBox(height: 24),

                      // Этапы строительства
                      Text(
                        l10n.constructionStages,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      ...project.stages.map(
                        (stage) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ProjectStageItem(stage: stage),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
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
                        .read(projectNotifierProvider.notifier)
                        .loadProject(widget.projectId);
                  },
                  child: Text(l10n.retry),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: projectAsync.when(
        data: (state) {
          if (state.project == null) return const SizedBox.shrink();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        debugPrint(
                          '=== Нажата кнопка "Отправить запрос на строительство" ===',
                        );
                        debugPrint('projectId: ${widget.projectId}');
                        final l10n = AppLocalizations.of(context)!;
                        final messenger = ScaffoldMessenger.of(context);

                        try {
                          await ref
                              .read(projectNotifierProvider.notifier)
                              .requestConstruction(widget.projectId);
                          debugPrint(
                            'Запрос на строительство отправлен успешно',
                          );

                          if (mounted) {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(l10n.constructionRequestSent),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            // Обновляем UI для показа кнопки перехода к документам
                            setState(() {});
                          }
                        } catch (e) {
                          debugPrint('Ошибка при отправке запроса: $e');
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
                child: Text(l10n.sendConstructionRequest),
              ),
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (error, stackTrace) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildCharacteristicsSection(BuildContext context, Project project) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCharacteristicRow(
              context,
              l10n.area,
              '${project.area.toInt()} м²',
              Icons.square_foot,
            ),
            const Divider(),
            _buildCharacteristicRow(
              context,
              l10n.floors,
              '${project.floors} ${project.floors > 1 ? l10n.floorsPlural : l10n.floor}',
              Icons.layers,
            ),
            const Divider(),
            _buildCharacteristicRow(
              context,
              l10n.price,
              '${_formatPrice(project.price)} ₽',
              Icons.attach_money,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacteristicRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
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

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} млн';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} тыс';
    }
    return price.toString();
  }
}
