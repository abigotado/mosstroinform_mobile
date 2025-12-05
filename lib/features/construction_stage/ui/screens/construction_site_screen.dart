import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/construction_completion/notifier/final_document_notifier.dart';
import 'package:mosstroinform_mobile/features/construction_stage/notifier/construction_site_notifier.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/screens/camera_view_screen.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/widgets/camera_grid_item.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_by_project_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран строительной площадки с камерами
class ConstructionSiteScreen extends ConsumerStatefulWidget {
  final String objectId;

  const ConstructionSiteScreen({super.key, required this.objectId});

  @override
  ConsumerState<ConstructionSiteScreen> createState() =>
      _ConstructionSiteScreenState();
}

class _ConstructionSiteScreenState
    extends ConsumerState<ConstructionSiteScreen> {
  @override
  void initState() {
    super.initState();
    AppLogger.debug('ConstructionSiteScreen.initState');
    AppLogger.debug('objectId: ${widget.objectId}');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppLogger.debug('ConstructionSiteScreen: загружаем площадку');
      ref
          .read(constructionSiteProvider(widget.objectId).notifier)
          .loadConstructionSite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final siteAsync = ref.watch(constructionSiteProvider(widget.objectId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.constructionStage),
        actions: [
          // Кнопки навигации (projectId получаем из загруженного объекта)
          Builder(
            builder: (context) {
              final siteState = siteAsync.maybeWhen(
                data: (state) => state.site,
                orElse: () => null,
              );
              final projectId = siteState?.projectId;

              if (projectId == null) {
                return const SizedBox.shrink();
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Кнопка перехода к проекту
                  IconButton(
                    icon: const Icon(Icons.home),
                    tooltip: l10n.projectDetails,
                    onPressed: () {
                      context.push('/projects/$projectId');
                    },
                  ),
                  // Кнопка перехода к завершению строительства
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    tooltip: l10n.completionTooltip,
                    onPressed: () {
                      context.push('/completion/$projectId');
                    },
                  ),
                  // Кнопка перехода к чату объекта (только если объект не завершен)
                  if (siteState == null ||
                      siteAsync.hasError ||
                      (ref
                              .read(
                                constructionObjectByProjectProvider(projectId),
                              )
                              .value
                              ?.isCompleted ??
                          false))
                    const SizedBox.shrink()
                  else
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      tooltip: l10n.chatTooltip,
                      onPressed: () {
                        context.push('/construction/$projectId/chat');
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: siteAsync.when(
          data: (state) {
            // Если площадка не загружена и нет ошибки - это начальное состояние, показываем шиммер
            if (state.site == null && state.error == null) {
              return const CameraGridShimmer(key: ValueKey('shimmer'));
            }

            // Если площадка не найдена и есть ошибка - показываем ошибку
            if (state.site == null) {
              return Center(
                key: const ValueKey('error'),
                child: Text(l10n.errorLoadingConstructionSite),
              );
            }

            final site = state.site!;
            final projectId = site.projectId;
            final objectAsync = ref.watch(
              constructionObjectByProjectProvider(projectId),
            );
            final isCompleted = objectAsync.value?.isCompleted ?? false;

            return SingleChildScrollView(
              key: const ValueKey('content'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Информация о стройке
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          site.projectName,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          site.address,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Прогресс строительства
                        Text(
                          l10n.progress,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: site.progress,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(site.progress * 100).toInt()}%',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Даты
                        if (site.startDate != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${l10n.startDate}: ${_formatDate(site.startDate!)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                        if (site.expectedCompletionDate != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.event,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${l10n.expectedCompletion}: ${_formatDate(site.expectedCompletionDate!)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Кнопка завершения строительства (показывается когда все документы подписаны)
                  Builder(
                    builder: (context) {
                      final projectId = site.projectId;
                      final objectAsync = ref.watch(
                        constructionObjectByProjectProvider(projectId),
                      );
                      // Следим за статусом финальных документов
                      final completionStatusAsync = ref.watch(
                        completionStatusProvider(projectId),
                      );

                      return objectAsync.when(
                        data: (object) {
                          // Проверяем статус подписания финальных документов
                          final areFinalDocumentsSigned =
                              completionStatusAsync
                                  .value
                                  ?.status
                                  ?.allDocumentsSigned ??
                              false;

                          // Если документы не подписаны, кнопку не показываем
                          if (!areFinalDocumentsSigned) {
                            return const SizedBox.shrink();
                          }

                          // Проверяем, не завершено ли уже строительство (кнопка нажата)
                          // Получаем статус напрямую из completionStatusAsync, так как object может быть старым
                          final isCompleted =
                              completionStatusAsync
                                  .value
                                  ?.status
                                  ?.isCompleted ??
                              object.isCompleted;

                          if (isCompleted) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color:
                                          theme.colorScheme.onTertiaryContainer,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        l10n.constructionCompleted,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                              color: theme
                                                  .colorScheme
                                                  .onTertiaryContainer,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () =>
                                    _completeConstruction(context, projectId),
                                icon: const Icon(Icons.check_circle),
                                label: Text(l10n.completeConstruction),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, _) => const SizedBox.shrink(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  const Divider(),

                  // Список камер
                  if (!isCompleted) ...[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        l10n.cameras,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (site.cameras.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            l10n.noCameras,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: site.cameras.length,
                        itemBuilder: (context, index) {
                          final camera = site.cameras[index];
                          return CameraGridItem(
                            camera: camera,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CameraViewScreen(camera: camera),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ],
              ),
            );
          },
          loading: () => const CameraGridShimmer(),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  l10n.errorLoadingConstructionSite,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toLocalizedMessage(context),
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(
                          constructionSiteProvider(widget.objectId).notifier,
                        )
                        .loadConstructionSite();
                  },
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }

  Future<void> _completeConstruction(
    BuildContext context,
    String projectId,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Получаем объект строительства по projectId
      final object = await ref.read(
        constructionObjectByProjectProvider(projectId).future,
      );

      // Завершаем строительство
      final objectRepository = ref.read(constructionObjectRepositoryProvider);
      await objectRepository.completeConstruction(object.id);

      // Обновляем статус завершения
      ref.invalidate(completionStatusProvider(projectId));
      ref.invalidate(constructionSiteProvider(widget.objectId));
      ref.invalidate(constructionObjectByProjectProvider(projectId));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.constructionCompletedSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toLocalizedMessage(context)),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
