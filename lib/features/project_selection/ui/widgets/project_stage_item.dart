import 'package:flutter/material.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

/// Виджет элемента этапа строительства
class ProjectStageItem extends StatelessWidget {
  final ConstructionStage stage;

  const ProjectStageItem({
    super.key,
    required this.stage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (stage.status) {
      case StageStatus.completed:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Завершён';
        break;
      case StageStatus.inProgress:
        statusColor = Colors.blue;
        statusIcon = Icons.radio_button_checked;
        statusText = 'В процессе';
        break;
      case StageStatus.pending:
        statusColor = Colors.grey;
        statusIcon = Icons.radio_button_unchecked;
        statusText = 'Ожидает';
        break;
    }

    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
        ),
        title: Text(
          stage.name,
          style: theme.textTheme.bodyLarge,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            statusText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

