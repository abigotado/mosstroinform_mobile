import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/ui/widgets/construction_object_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_objects_screen.g.dart';

/// Провайдер для списка объектов строительства
@riverpod
Future<List<ConstructionObject>> myObjects(Ref ref) async {
  final repository = ref.read(constructionObjectRepositoryProvider);
  return repository.getObjects();
}

/// Экран моих объектов
class MyObjectsScreen extends ConsumerWidget {
  const MyObjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final objectsAsync = ref.watch(myObjectsProvider);

    // Определяем, использовать ли GridView для больших экранов
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final crossAxisCount = isDesktop
        ? (screenWidth / 500).floor().clamp(2, 3)
        : 1; // Для мобильных используем 1 колонку

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myObjectsTitle)),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: objectsAsync.when(
          data: (objects) {
            if (objects.isEmpty) {
              return Center(
                key: const ValueKey('empty'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home_outlined, size: 64, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                    const SizedBox(height: 16),
                    Text(l10n.noMyObjects, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              key: ValueKey('list-${objects.length}'),
              onRefresh: () async {
                ref.invalidate(myObjectsProvider);
              },
              child: isDesktop
                  ? Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85, // Учитываем высоту карточки с изображением
                          ),
                          itemCount: objects.length,
                          itemBuilder: (context, index) {
                            final object = objects[index];
                            return ConstructionObjectCard(
                              object: object,
                              onTap: () {
                                // Переход на страницу объекта (строительной площадки) по objectId
                                context.push('/construction/${object.id}');
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: objects.length,
                          itemBuilder: (context, index) {
                            final object = objects[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ConstructionObjectCard(
                                object: object,
                                onTap: () {
                                  // Переход на страницу объекта (строительной площадки) по objectId
                                  context.push('/construction/${object.id}');
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            );
          },
          loading: () => isDesktop
              ? Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: GridView.builder(
                      key: const ValueKey('loading'),
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const ProjectCardShimmer();
                      },
                    ),
                  ),
                )
              : ListView.builder(
                  key: const ValueKey('loading'),
                  padding: const EdgeInsets.all(16),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 16), child: ProjectCardShimmer());
                  },
                ),
          error: (error, stackTrace) => Center(
            key: const ValueKey('error'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(l10n.error, style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  error.toLocalizedMessage(context),
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(myObjectsProvider);
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
}
