import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/notifier/final_document_notifier.dart';

/// Экран детального просмотра финального документа
class FinalDocumentDetailScreen extends ConsumerStatefulWidget {
  final String projectId;
  final String documentId;

  const FinalDocumentDetailScreen({
    super.key,
    required this.projectId,
    required this.documentId,
  });

  @override
  ConsumerState<FinalDocumentDetailScreen> createState() =>
      _FinalDocumentDetailScreenState();
}

class _FinalDocumentDetailScreenState
    extends ConsumerState<FinalDocumentDetailScreen> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(finalDocumentNotifierProvider((
            widget.projectId,
            widget.documentId,
          )).notifier)
          .loadFinalDocument();
    });
  }

  Future<void> _handleSign() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      await ref
          .read(finalDocumentNotifierProvider((
            widget.projectId,
            widget.documentId,
          )).notifier)
          .signFinalDocument();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.documentSigned),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentAsync = ref.watch(finalDocumentNotifierProvider((
      widget.projectId,
      widget.documentId,
    )));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.finalDocument),
      ),
      body: documentAsync.when(
        data: (state) {
          // Если документ не загружен и нет ошибки - это начальное состояние, показываем шиммер
          if (state.document == null && state.error == null) {
            return const DocumentDetailShimmer();
          }

          // Если документ не найден и есть ошибка - показываем ошибку
          if (state.document == null) {
            return Center(child: Text(l10n.finalDocumentNotFound));
          }

          final document = state.document!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и статус
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        document.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _StatusChip(status: document.status),
                  ],
                ),
                const SizedBox(height: 16),

                // Описание
                Text(
                  l10n.description,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  document.description,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),

                // Информация о датах
                if (document.submittedAt != null) ...[
                  _InfoRow(
                    icon: Icons.access_time,
                    label: l10n.submitted,
                    value: _formatDateTime(document.submittedAt!),
                  ),
                  const SizedBox(height: 8),
                ],
                if (document.signedAt != null) ...[
                  _InfoRow(
                    icon: Icons.check_circle,
                    label: l10n.signedAt,
                    value: _formatDateTime(document.signedAt!),
                  ),
                  const SizedBox(height: 8),
                ],

                // Подпись
                if (document.signatureUrl != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.verified,
                          color: colorScheme.onTertiaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.signature,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onTertiaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                document.signatureUrl!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Ссылка на файл
                if (document.fileUrl != null) ...[
                  OutlinedButton.icon(
                    onPressed: () {
                      final l10n = AppLocalizations.of(context)!;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.openFile(document.fileUrl!)),
                        ),
                      );
                    },
                    icon: const Icon(Icons.file_download),
                    label: Text(l10n.downloadDocument),
                  ),
                  const SizedBox(height: 24),
                ],

                // Кнопка подписания
                if (document.status == FinalDocumentStatus.pending) ...[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isProcessing ? null : _handleSign,
                      icon: _isProcessing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.edit),
                      label: Text(l10n.signDocument),
                    ),
                  ),
                ],
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
                l10n.errorLoadingFinalDocument,
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
                      .read(finalDocumentNotifierProvider((
                        widget.projectId,
                        widget.documentId,
                      )).notifier)
                      .loadFinalDocument();
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Виджет строки информации
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Виджет статуса финального документа
class _StatusChip extends StatelessWidget {
  final FinalDocumentStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    Color backgroundColor;
    Color textColor;
    String label;
    IconData icon;

    switch (status) {
      case FinalDocumentStatus.pending:
        backgroundColor = colorScheme.surfaceContainerHighest;
        textColor = colorScheme.onSurface;
        label = l10n.documentStatusPending;
        icon = Icons.pending;
        break;
      case FinalDocumentStatus.signed:
        backgroundColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.onTertiaryContainer;
        label = l10n.signed;
        icon = Icons.check_circle;
        break;
      case FinalDocumentStatus.rejected:
        backgroundColor = colorScheme.errorContainer;
        textColor = colorScheme.onErrorContainer;
        label = l10n.documentStatusRejected;
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

