import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:mosstroinform_mobile/features/construction_completion/notifier/final_document_notifier.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/widgets/final_document_card.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';

/// Экран статуса завершения строительства
class CompletionStatusScreen extends ConsumerStatefulWidget {
  final String projectId;

  const CompletionStatusScreen({super.key, required this.projectId});

  @override
  ConsumerState<CompletionStatusScreen> createState() =>
      _CompletionStatusScreenState();
}

class _CompletionStatusScreenState
    extends ConsumerState<CompletionStatusScreen> {
  // Убрали вызов loadCompletionStatus из initState,
  // так как build метод провайдера теперь сам загружает данные

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusAsync = ref.watch(completionStatusProvider(widget.projectId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.constructionCompletion)),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: statusAsync.when(
          data: (state) {
            // Если статус не загружен и нет ошибки - это начальное состояние, показываем шиммер
            if (state.status == null && state.error == null && !state.isLoading) {
              return const CompletionStatusShimmer(key: ValueKey('shimmer'));
            }

            // Если статус не найден и есть ошибка - показываем ошибку
            if (state.status == null && state.error != null) {
              return Center(
                key: const ValueKey('error'),
                child: Text(l10n.errorLoadingCompletionStatus),
              );
            }

            // Если статус не загружен, но идет загрузка - показываем предыдущие данные или шиммер
            if (state.status == null) {
              return const CompletionStatusShimmer(key: ValueKey('shimmer'));
            }

            final status = state.status!;
            
            // Подсчитываем количество подписанных документов
            final signedCount = status.documents
                .where((doc) => doc.status == FinalDocumentStatus.signed)
                .length;
            final totalCount = status.documents.length;

            return SingleChildScrollView(
              key: const ValueKey('content'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Статус подписания документов (упрощенный виджет)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            signedCount == totalCount
                                ? Icons.check_circle
                                : Icons.description,
                            color: signedCount == totalCount
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.documentsSignedCount(signedCount, totalCount),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: signedCount == totalCount
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Divider(),

                // Список финальных документов
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.finalDocuments,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (status.documents.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        l10n.noFinalDocuments,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: status.documents.length,
                    itemBuilder: (context, index) {
                      final document = status.documents[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FinalDocumentCard(
                          document: document,
                          onTap: () {
                            context.push(
                              '/completion/${widget.projectId}/documents/${document.id}',
                            );
                          },
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
        loading: () {
          // При переходе из data в loading показываем шиммер только если нет предыдущих данных
          // В противном случае данные должны оставаться видимыми с индикатором загрузки
          final theme = Theme.of(context);
          return Shimmer.fromColors(
            baseColor: theme.colorScheme.surfaceContainerHighest,
            highlightColor: theme.colorScheme.surface,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Shimmer для статуса
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Shimmer для документов
                  ...List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: FinalDocumentCardShimmer(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                l10n.errorLoadingCompletionStatus,
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
                      .read(completionStatusProvider(widget.projectId).notifier)
                      .loadCompletionStatus();
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
