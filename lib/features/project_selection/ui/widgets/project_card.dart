import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Виджет карточки проекта
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
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
                      color: colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(
                      Icons.home,
                      size: 48,
                    ),
                  ),
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
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.address,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Описание
                  Text(
                    project.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Характеристики
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.square_foot,
                        text: '${project.area.toInt()} м²',
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.layers,
                        text: '${project.floors} ${project.floors > 1 ? l10n.floors : l10n.floor}',
                      ),
                      const Spacer(),
                      Text(
                        '${_formatPrice(project.price)} ₽',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Этапы строительства
                  if (project.stages.isNotEmpty) ...[
                    Text(
                      l10n.constructionStagesLabel,
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    _StagesIndicator(stages: project.stages),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
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

/// Виджет информационного чипа
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

/// Виджет индикатора этапов строительства
class _StagesIndicator extends StatelessWidget {
  final List<ConstructionStage> stages;

  const _StagesIndicator({required this.stages});

  @override
  Widget build(BuildContext context) {
    final completedCount = stages.where((s) => s.status == StageStatus.completed).length;
    final inProgressCount = stages.where((s) => s.status == StageStatus.inProgress).length;
    final totalCount = stages.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Прогресс бар
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: completedCount / totalCount,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        // Текущий этап
        if (inProgressCount > 0)
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                stages.firstWhere((s) => s.status == StageStatus.inProgress).name,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
      ],
    );
  }
}

