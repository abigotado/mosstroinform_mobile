import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/notifier/document_notifier.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/widgets/document_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран списка документов
class DocumentListScreen extends ConsumerStatefulWidget {
  final String? projectId;

  const DocumentListScreen({super.key, this.projectId});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем документы при открытии экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.projectId != null) {
        ref
            .read(documentsProvider.notifier)
            .loadDocumentsForProject(widget.projectId!);
      } else {
        ref.read(documentsProvider.notifier).loadDocuments();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentsAsync = ref.watch(documentsProvider);

    // Проверяем, все ли документы одобрены для показа кнопки перехода к строительству
    documentsAsync.maybeWhen(
      data: (docs) =>
          docs.isNotEmpty &&
          docs.every((doc) => doc.status == DocumentStatus.approved),
      orElse: () => false,
    );

    // Получаем projectId из первого документа (все документы относятся к одному проекту)
    documentsAsync.maybeWhen(
      data: (docs) => docs.isNotEmpty ? docs.first.projectId : null,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.documentApprovalTitle),
        actions: [
          // Ничего не показываем - кнопка "Начать строительство" теперь на экране проекта
        ],
      ),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: documentsAsync.when(
          data: (documents) {
            // Если список пустой после загрузки - показываем пустое состояние
            if (documents.isEmpty) {
              return Center(
                key: const ValueKey('empty'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noDocumentsToApprove,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              key: ValueKey('list-${documents.length}'),
              onRefresh: () async {
                if (widget.projectId != null) {
                  await ref
                      .read(documentsProvider.notifier)
                      .loadDocumentsForProject(widget.projectId!);
                } else {
                  await ref.read(documentsProvider.notifier).loadDocuments();
                }
              },
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DocumentCard(
                          document: document,
                          onTap: () {
                            context.push('/documents/${document.id}');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          loading: () => ListView.builder(
            key: const ValueKey('loading'),
            padding: const EdgeInsets.all(16),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: DocumentCardShimmer(),
              );
            },
          ),
          error: (error, stackTrace) => Center(
            key: const ValueKey('error'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  l10n.errorLoadingDocuments,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toLocalizedMessage(context),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (widget.projectId != null) {
                      ref
                          .read(documentsProvider.notifier)
                          .loadDocumentsForProject(widget.projectId!);
                    } else {
                      ref.read(documentsProvider.notifier).loadDocuments();
                    }
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
