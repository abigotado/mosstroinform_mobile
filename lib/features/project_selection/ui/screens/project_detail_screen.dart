import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/notifier/project_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/project_stage_item.dart';

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
    final projectAsync = ref.watch(projectNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Детали проекта')),
      body: projectAsync.when(
        data: (state) {
          if (state.project == null) {
            return const Center(child: Text('Проект не найден'));
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
                      errorBuilder: (context, error, stackTrace) {
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
                        'Этапы строительства',
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
                  'Ошибка: $error',
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
                  child: const Text('Повторить'),
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
                        final messenger = ScaffoldMessenger.of(context);
                        await ref
                            .read(projectNotifierProvider.notifier)
                            .requestConstruction(widget.projectId);

                        if (mounted) {
                          messenger.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Запрос на строительство отправлен',
                              ),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Отправить запрос на строительство'),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCharacteristicRow(
              context,
              'Площадь',
              '${project.area.toInt()} м²',
              Icons.square_foot,
            ),
            const Divider(),
            _buildCharacteristicRow(
              context,
              'Этажность',
              '${project.floors} этаж${project.floors > 1 ? 'а' : ''}',
              Icons.layers,
            ),
            const Divider(),
            _buildCharacteristicRow(
              context,
              'Стоимость',
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
