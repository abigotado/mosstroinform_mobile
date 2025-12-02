import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
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
      ref.read(documentsProvider.notifier).loadDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentsAsync = ref.watch(documentsProvider);

    // Проверяем, все ли документы одобрены для показа кнопки перехода к строительству
    final allApproved = documentsAsync.maybeWhen(
      data: (docs) =>
          docs.isNotEmpty &&
          docs.every((doc) => doc.status == DocumentStatus.approved),
      orElse: () => false,
    );

    // Получаем projectId из первого документа (все документы относятся к одному проекту)
    final projectId = documentsAsync.maybeWhen(
      data: (docs) => docs.isNotEmpty ? docs.first.projectId : null,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.documentApprovalTitle),
        actions: [
          // Кнопка перехода к строительству (показывается когда все документы одобрены)
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
      body: documentsAsync.when(
        data: (documents) {
          // Если список пустой - это начальное состояние, показываем шиммер
          // (начальное состояние возвращается как data с пустым списком)
          if (documents.isEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: DocumentCardShimmer(),
                );
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(documentsProvider.notifier).loadDocuments();
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
        loading: () => ListView.builder(
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
                  ref.read(documentsProvider.notifier).loadDocuments();
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
