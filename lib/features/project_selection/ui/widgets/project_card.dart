import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Виджет карточки проекта (компактная версия для GridView)
class ProjectCard extends ConsumerWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          InkWell(
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
                            child: Icon(Icons.image_not_supported, size: 32),
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
                      child: const Center(child: Icon(Icons.home, size: 32)),
                    ),
                  ),

                // Информация о проекте
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Название
                      Text(
                        project.name,
                        style: theme.textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const SizedBox(height: 8),

                      // Описание
                      Text(
                        project.description,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Параметры
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _InfoChip(
                            icon: Icons.square_foot,
                            text: '${project.area.toInt()} м²',
                          ),
                          _InfoChip(
                            icon: Icons.layers,
                            text:
                                '${project.floors} ${l10n.floors(project.floors)}',
                          ),
                          _InfoChip(
                            icon: Icons.bed,
                            text:
                                '${project.bedrooms} ${l10n.bedrooms(project.bedrooms)}',
                          ),
                          _InfoChip(
                            icon: Icons.bathtub,
                            text:
                                '${project.bathrooms} ${l10n.bathrooms(project.bathrooms)}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Цена
                      Text(
                        _formatPrice(project.price, l10n),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Наклейка статуса
          Positioned(
            top: 8,
            right: 8,
            child: AppAnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildStatusBadge(project, theme, colorScheme, l10n),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price, AppLocalizations l10n) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} ${l10n.million} ${l10n.ruble}';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ${l10n.thousand} ${l10n.ruble}';
    }
    return '$price ${l10n.ruble}';
  }

  Widget _buildStatusBadge(
    Project project,
    ThemeData theme,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    switch (project.status) {
      case ProjectStatus.requested:
        // Оранжевый цвет для статуса "запрошен"
        return Container(
          key: const ValueKey('requested'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.tertiary, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pending_actions,
                size: 14,
                color: colorScheme.onTertiaryContainer,
              ),
              const SizedBox(width: 4),
              Text(
                l10n.requested,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      case ProjectStatus.construction:
        // Синий/зеленый цвет для статуса "строительство"
        return Container(
          key: const ValueKey('construction'),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.primary, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.construction,
                size: 14,
                color: colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 4),
              Text(
                l10n.underConstruction,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      case ProjectStatus.available:
        return const SizedBox.shrink(key: ValueKey('empty'));
    }
  }
}

/// Виджет информационного чипа
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(text, style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
      ],
    );
  }
}
