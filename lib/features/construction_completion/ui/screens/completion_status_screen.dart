import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:mosstroinform_mobile/features/construction_completion/notifier/final_document_notifier.dart';
import 'package:mosstroinform_mobile/features/construction_completion/ui/widgets/final_document_card.dart';

/// Экран статуса завершения строительства
class CompletionStatusScreen extends ConsumerStatefulWidget {
  final String projectId;

  const CompletionStatusScreen({
    super.key,
    required this.projectId,
  });

  @override
  ConsumerState<CompletionStatusScreen> createState() =>
      _CompletionStatusScreenState();
}

class _CompletionStatusScreenState extends ConsumerState<CompletionStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(completionStatusNotifierProvider(widget.projectId).notifier)
          .loadCompletionStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusAsync =
        ref.watch(completionStatusNotifierProvider(widget.projectId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.constructionCompletion)),
      body: statusAsync.when(
        data: (state) {
          if (state.status == null) {
            return Center(child: Text(l10n.errorLoadingCompletionStatus));
          }

          final status = state.status!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Статус завершения
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    color: status.isCompleted
                        ? theme.colorScheme.tertiaryContainer
                        : theme.colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                status.isCompleted
                                    ? Icons.check_circle
                                    : Icons.construction,
                                color: status.isCompleted
                                    ? theme.colorScheme.onTertiaryContainer
                                    : theme.colorScheme.onSurface,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  status.isCompleted
                                      ? l10n.constructionCompleted
                                      : l10n.completionStatus,
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: status.isCompleted
                                        ? theme.colorScheme.onTertiaryContainer
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Прогресс
                          Text(
                            l10n.progress,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: status.isCompleted
                                  ? theme.colorScheme.onTertiaryContainer
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: status.progress,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(status.progress * 100).toInt()}%',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: status.isCompleted
                                  ? theme.colorScheme.onTertiaryContainer
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          if (status.completionDate != null) ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.event,
                                  size: 16,
                                  color: status.isCompleted
                                      ? theme.colorScheme.onTertiaryContainer
                                      : theme.colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${l10n.completionDate}: ${_formatDate(status.completionDate!)}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: status.isCompleted
                                        ? theme.colorScheme.onTertiaryContainer
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (status.allDocumentsSigned) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      l10n.allDocumentsSigned,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                  ...List.generate(3, (index) => const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: FinalDocumentCardShimmer(),
                      )),
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
                error.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(completionStatusNotifierProvider(widget.projectId)
                          .notifier)
                      .loadCompletionStatus();
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

