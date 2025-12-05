import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/notifier/document_notifier.dart';
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
      // Загружаем документы для проверки статуса одобрения
      ref
          .read(documentsProvider.notifier)
          .loadDocumentsForProject(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final projectAsync = ref.watch(projectProvider);
    final theme = Theme.of(context);

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

              // Показываем кнопку перехода к объекту, если проект в статусе строительства и есть objectId
              if (projectState.status == ProjectStatus.construction &&
                  projectState.objectId != null) {
                return IconButton(
                  icon: const Icon(Icons.construction),
                  tooltip: l10n.toConstruction,
                  onPressed: () {
                    // Навигация к объекту строительства по projectId
                    // (роутер использует projectId для поиска объекта)
                    context.push('/construction/${projectState.id}');
                  },
                );
              }

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
                        // Название
                        Text(
                          project.name,
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),

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
                                _formatPrice(project.price, l10n),
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

          final project = state.project!;
          final isRequested = project.status == ProjectStatus.requested;
          final isUnderConstruction =
              project.status == ProjectStatus.construction;
          final isRequesting = state.isRequestingConstruction;

          // Проверяем, все ли документы одобрены для запрошенных проектов
          final documentsAsync = isRequested
              ? ref.watch(documentsProvider)
              : null;
          final allDocumentsApproved =
              documentsAsync?.maybeWhen(
                data: (docs) =>
                    docs.isNotEmpty &&
                    docs.every((doc) => doc.status == DocumentStatus.approved),
                orElse: () => false,
              ) ??
              false;

          // Для проектов в строительстве показываем только кнопку "К документам"
          if (isUnderConstruction) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: Tooltip(
                    message: l10n.toDocuments,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push(
                          '/documents?projectId=${widget.projectId}',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      icon: const Icon(Icons.description),
                      label: Text(
                        l10n.toDocuments,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return AppAnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: SafeArea(
              key: ValueKey(isRequested ? 'requested' : 'available'),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Для запрошенных проектов показываем кнопки
                    if (isRequested) ...[
                      // Кнопка "К документам"
                      SizedBox(
                        width: double.infinity,
                        child: Tooltip(
                          message: l10n.toDocuments,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.push(
                                '/documents?projectId=${widget.projectId}',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: const Icon(Icons.description),
                            label: Text(
                              l10n.toDocuments,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      // Кнопка "Начать" показывается только если все документы одобрены
                      if (allDocumentsApproved) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: Tooltip(
                            message: l10n.startConstruction,
                            child: ElevatedButton.icon(
                              onPressed: () => _showAddressInputDialog(context),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.onSecondaryContainer,
                              ),
                              icon: const Icon(Icons.construction),
                              label: Text(
                                l10n.startConstruction,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ] else
                      // Для доступных проектов - кнопка запроса строительства
                      SizedBox(
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
                                            content: Text(
                                              e.toLocalizedMessage(context),
                                            ),
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
                  ],
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

  /// Показать диалог ввода адреса строительства
  void _showAddressInputDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final addressController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.constructionAddressTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: l10n.enterConstructionAddress,
                  hintText: 'ул. Ленина, д. 1',
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final address = addressController.text.trim();
                        if (address.isNotEmpty) {
                          Navigator.of(context).pop();
                          await _startConstruction(address);
                        }
                      },
                      child: Text(l10n.startConstruction),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// Начать строительство с указанным адресом
  Future<void> _startConstruction(String address) async {
    try {
      await ref
          .read(projectProvider.notifier)
          .startConstruction(widget.projectId, address);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.constructionStarted),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toLocalizedMessage(context)),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static String _formatPrice(int price, AppLocalizations l10n) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} ${l10n.million}';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ${l10n.thousand}';
    }
    return '$price ${l10n.ruble}';
  }
}

/// Виджет секции характеристик проекта
class _CharacteristicsSection extends StatelessWidget {
  final Project project;

  const _CharacteristicsSection({required this.project});

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
              label: l10n.floorsLabel,
              value: '${project.floors} ${l10n.floors(project.floors)}',
              icon: Icons.layers,
            ),
            const Divider(),
            _CharacteristicRow(
              label: 'Спальни',
              value: '${project.bedrooms} ${l10n.bedrooms(project.bedrooms)}',
              icon: Icons.bed,
            ),
            const Divider(),
            _CharacteristicRow(
              label: 'Ванные',
              value:
                  '${project.bathrooms} ${l10n.bathrooms(project.bathrooms)}',
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
