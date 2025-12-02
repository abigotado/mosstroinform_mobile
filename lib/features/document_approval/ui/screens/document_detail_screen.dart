import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/notifier/document_notifier.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран детального просмотра документа
class DocumentDetailScreen extends ConsumerStatefulWidget {
  final String documentId;

  const DocumentDetailScreen({super.key, required this.documentId});

  @override
  ConsumerState<DocumentDetailScreen> createState() =>
      _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends ConsumerState<DocumentDetailScreen> {
  final _rejectionReasonController = TextEditingController();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(documentNotifierProvider(widget.documentId).notifier)
          .loadDocument(widget.documentId);
    });
  }

  @override
  void dispose() {
    _rejectionReasonController.dispose();
    super.dispose();
  }

  Future<void> _handleApprove(String documentId) async {
    if (_isProcessing) {
      debugPrint('Обработка уже идет, пропускаем');
      return;
    }

    debugPrint('=== _handleApprove ===');
    debugPrint('documentId: $documentId');
    setState(() => _isProcessing = true);

    try {
      debugPrint('Вызываем approveDocument');
      await ref
          .read(documentNotifierProvider(documentId).notifier)
          .approveDocument(documentId);
      debugPrint('approveDocument выполнен успешно');

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        final messenger = ScaffoldMessenger.of(context);

        // Перезагружаем список документов для проверки статуса
        await ref.read(documentsNotifierProvider.notifier).loadDocuments();

        if (!mounted) return;

        // Проверяем, все ли документы одобрены
        final allDocuments = ref.read(documentsNotifierProvider);
        final allApproved = allDocuments.maybeWhen(
          data: (docs) =>
              docs.isNotEmpty &&
              docs.every((doc) => doc.status == DocumentStatus.approved),
          orElse: () => false,
        );

        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.documentApproved),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Обновляем UI для показа кнопки перехода к стройке
        if (mounted) {
          setState(() {});
        }
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

  Future<void> _handleReject(String documentId) async {
    if (_isProcessing) return;

    final reason = _rejectionReasonController.text.trim();
    if (reason.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.specifyRejectionReason),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      await ref
          .read(documentNotifierProvider(documentId).notifier)
          .rejectDocument(documentId, reason);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        _rejectionReasonController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.documentRejected),
            backgroundColor: Colors.orange,
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

  void _showRejectDialog(String documentId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.rejectDocumentTitle),
        content: TextField(
          controller: _rejectionReasonController,
          decoration: InputDecoration(
            labelText: l10n.rejectionReason,
            hintText: l10n.rejectReasonHint,
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _rejectionReasonController.clear();
            },
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _handleReject(documentId);
            },
            child: Text(l10n.reject),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentAsync = ref.watch(
      documentNotifierProvider(widget.documentId),
    );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Проверяем, все ли документы одобрены для показа кнопки перехода
    final allDocuments = ref.watch(documentsNotifierProvider);
    final allApproved = allDocuments.maybeWhen(
      data: (docs) =>
          docs.isNotEmpty &&
          docs.every((doc) => doc.status == DocumentStatus.approved),
      orElse: () => false,
    );
    
    // Получаем projectId из текущего документа
    final currentDocument = ref.read(documentNotifierProvider(widget.documentId));
    final projectId = currentDocument.maybeWhen(
      data: (doc) => doc?.projectId,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.documentTitle),
        actions: [
          // Кнопка перехода к стройке (показывается когда все документы одобрены)
          if (allApproved && projectId != null)
            IconButton(
              icon: const Icon(Icons.construction),
              tooltip: l10n.toConstruction,
              onPressed: () {
                if (mounted) {
                  context.push('/construction/$projectId');
                }
              },
            ),
        ],
      ),
      body: documentAsync.when(
        data: (document) {
          if (document == null) {
            return Center(child: Text(l10n.documentNotFound));
          }

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
                Text(document.description, style: theme.textTheme.bodyLarge),
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
                if (document.approvedAt != null) ...[
                  _InfoRow(
                    icon: Icons.check_circle,
                    label: l10n.approved,
                    value: _formatDateTime(document.approvedAt!),
                  ),
                  const SizedBox(height: 8),
                ],

                // Причина отклонения
                if (document.rejectionReason != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.rejectionReason,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                document.rejectionReason!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onErrorContainer,
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
                      // В реальном приложении здесь была бы открыта ссылка на файл
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

                // Кнопки действий
                // Показываем кнопки для pending, underReview и rejected документов
                // (rejected документы можно одобрить после исправлений)
                if (document.status == DocumentStatus.pending ||
                    document.status == DocumentStatus.underReview ||
                    document.status == DocumentStatus.rejected) ...[
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isProcessing
                              ? null
                              : () => _showRejectDialog(document.id),
                          icon: const Icon(Icons.close),
                          label: Text(l10n.reject),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _isProcessing
                              ? null
                              : () => _handleApprove(document.id),
                          icon: _isProcessing
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.check),
                          label: Text(l10n.approve),
                        ),
                      ),
                    ],
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
                l10n.errorLoadingDocument,
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
                      .read(
                        documentNotifierProvider(widget.documentId).notifier,
                      )
                      .loadDocument(widget.documentId);
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

/// Виджет статуса документа
class _StatusChip extends StatelessWidget {
  final DocumentStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color textColor;
    String label;
    IconData icon;

    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case DocumentStatus.pending:
        backgroundColor = colorScheme.surfaceContainerHighest;
        textColor = colorScheme.onSurface;
        label = l10n.documentStatusPending;
        icon = Icons.pending;
        break;
      case DocumentStatus.underReview:
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        label = l10n.documentStatusUnderReview;
        icon = Icons.rate_review;
        break;
      case DocumentStatus.approved:
        backgroundColor = colorScheme.tertiaryContainer;
        textColor = colorScheme.onTertiaryContainer;
        label = l10n.documentStatusApproved;
        icon = Icons.check_circle;
        break;
      case DocumentStatus.rejected:
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
