import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

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
                      _buildInfoChip(
                        context,
                        Icons.square_foot,
                        '${project.area.toInt()} м²',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        context,
                        Icons.layers,
                        '${project.floors} этаж${project.floors > 1 ? 'а' : ''}',
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
                      'Этапы строительства:',
                      style: theme.textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildStagesIndicator(context, project.stages),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String text) {
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

  Widget _buildStagesIndicator(
    BuildContext context,
    List<ConstructionStage> stages,
  ) {
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

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} млн';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} тыс';
    }
    return price.toString();
  }
}

