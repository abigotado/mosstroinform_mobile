import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/features/document_approval/notifier/document_notifier.dart';
import 'package:mosstroinform_mobile/features/document_approval/ui/widgets/document_card.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран списка документов
class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  @override
  void initState() {
    super.initState();
    // Загружаем документы при открытии экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(documentsNotifierProvider.notifier).loadDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentsAsync = ref.watch(documentsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.documentApprovalTitle)),
      body: documentsAsync.when(
        data: (documents) {
          if (documents.isEmpty) {
            return Center(child: Text(l10n.noDocumentsToApprove));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(documentsNotifierProvider.notifier)
                  .loadDocuments();
            },
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
                l10n.errorLoadingDocuments,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(documentsNotifierProvider.notifier).loadDocuments();
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
