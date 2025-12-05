import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/widgets/app_animated_switcher.dart';
import 'package:mosstroinform_mobile/core/widgets/shimmer_widgets.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';
import 'package:mosstroinform_mobile/features/chat/notifier/chat_notifier.dart';
import 'package:mosstroinform_mobile/features/chat/ui/widgets/chat_card.dart';

/// Экран списка чатов
class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatsProvider.notifier).loadChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final chatsAsync = ref.watch(chatsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.chats)),
      body: AppAnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: chatsAsync.when(
          data: (state) {
            // Если список пустой и нет ошибки - это начальное состояние, показываем шиммер
            // (начальное состояние возвращается как data с пустым списком)
            if (state.chats.isEmpty && state.error == null) {
              return ListView.builder(
                key: const ValueKey('shimmer'),
                padding: const EdgeInsets.all(16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: ChatCardShimmer(),
                  );
                },
              );
            }

            // Если список пустой после загрузки (с ошибкой) - показываем сообщение
            if (state.chats.isEmpty) {
              return Center(
                key: const ValueKey('empty'),
                child: Text(l10n.noChats),
              );
            }

            return RefreshIndicator(
              key: ValueKey('list-${state.chats.length}'),
              onRefresh: () async {
                await ref.read(chatsProvider.notifier).loadChats();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final chat = state.chats[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ChatCard(
                      chat: chat,
                      onTap: () {
                        context.push('/chats/${chat.id}');
                      },
                    ),
                  );
                },
              ),
            );
          },
          loading: () => ListView.builder(
            key: const ValueKey('loading'),
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ChatCardShimmer(),
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
                  l10n.errorLoadingChats,
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
                  ref.read(chatsProvider.notifier).loadChats();
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
