import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:mosstroinform_mobile/features/construction_stage/notifier/construction_site_notifier.dart';
import 'package:mosstroinform_mobile/features/construction_stage/ui/widgets/camera_grid_item.dart';

/// Экран строительной площадки с камерами
class ConstructionSiteScreen extends ConsumerStatefulWidget {
  final String projectId;

  const ConstructionSiteScreen({
    super.key,
    required this.projectId,
  });

  @override
  ConsumerState<ConstructionSiteScreen> createState() =>
      _ConstructionSiteScreenState();
}

class _ConstructionSiteScreenState
    extends ConsumerState<ConstructionSiteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(constructionSiteNotifierProvider(widget.projectId).notifier)
          .loadConstructionSite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final siteAsync =
        ref.watch(constructionSiteNotifierProvider(widget.projectId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.constructionStage)),
      body: siteAsync.when(
        data: (state) {
          if (state.site == null) {
            return Center(child: Text(l10n.errorLoadingConstructionSite));
          }

          final site = state.site!;

          return SingleChildScrollView(
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

                const Divider(),

                // Список камер
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
                          // TODO: Навигация к экрану просмотра камеры
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
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
                error.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(constructionSiteNotifierProvider(widget.projectId)
                          .notifier)
                      .loadConstructionSite();
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}

