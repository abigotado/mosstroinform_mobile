import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/requested_projects_state.dart';
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
    
    // Проверяем, запрошен ли проект
    final requestedIds = ref.watch(requestedProjectsStateProvider);
    final isRequested = requestedIds.contains(project.id);

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
                  
                  // Адрес
                  Text(
                    project.address,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                        text: '${project.floors} ${_getFloorsText(project.floors)}',
                      ),
                      _InfoChip(
                        icon: Icons.bed,
                        text: '${project.bedrooms} ${_getBedroomsText(project.bedrooms)}',
                      ),
                      _InfoChip(
                        icon: Icons.bathtub,
                        text: '${project.bathrooms} ${_getBathroomsText(project.bathrooms)}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Цена
                  Text(
                    _formatPrice(project.price),
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
          // Наклейка статуса "запрошен"
          Positioned(
            top: 8,
            right: 8,
            child: AppAnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isRequested
                  ? Container(
                      key: const ValueKey('requested'),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.pending_actions,
                            size: 14,
                            color: colorScheme.onPrimaryContainer,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.requested,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} млн ₽';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} тыс ₽';
    }
    return '$price ₽';
  }

  String _getFloorsText(int floors) {
    if (floors == 1) return 'этаж';
    if (floors >= 2 && floors <= 4) return 'этажа';
    return 'этажей';
  }

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
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
