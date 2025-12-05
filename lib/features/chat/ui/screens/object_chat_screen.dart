import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/extensions/localize_error_extension.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/providers/chat_repository_provider.dart';
import 'package:mosstroinform_mobile/features/chat/notifier/chat_notifier.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/construction_object_repository_provider.dart';
import 'package:mosstroinform_mobile/l10n/app_localizations.dart';

/// Экран чата для конкретного объекта строительства
/// Доступен только со страницы объекта
class ObjectChatScreen extends ConsumerStatefulWidget {
  final String projectId;

  const ObjectChatScreen({super.key, required this.projectId});

  @override
  ConsumerState<ObjectChatScreen> createState() => _ObjectChatScreenState();
}

class _ObjectChatScreenState extends ConsumerState<ObjectChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Chat? _chat;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChat();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChat() async {
    try {
      // Получаем объект строительства по projectId
      final objectRepository = ref.read(constructionObjectRepositoryProvider);
      final objects = await objectRepository.getObjects();
      final object = objects.firstWhere(
        (obj) => obj.projectId == widget.projectId,
        orElse: () => throw UnknownFailure('Объект строительства не найден'),
      );

      // Получаем chatId из объекта
      final chatId = object.chatId;
      if (chatId == null) {
        throw UnknownFailure('У объекта строительства нет чата');
      }

      // Загружаем чат по ID
      final chatRepository = ref.read(chatRepositoryProvider);
      final chat = await chatRepository.getChatById(chatId);

      setState(() {
        _chat = chat;
      });

      // Загружаем сообщения чата
      ref.read(messagesProvider(chat.id).notifier).loadMessages();
      ref.read(messagesProvider(chat.id).notifier).markAsRead();
    } catch (e, stackTrace) {
      AppLogger.error(
        'ObjectChatScreen._loadChat: ошибка загрузки чата: $e',
        stackTrace,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is Failure ? e.message : AppLocalizations.of(context)!.error,
            ),
          ),
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    if (_chat == null) return;
    
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    _messageController.clear();
    await ref.read(messagesProvider(_chat!.id).notifier).sendMessage(text);

    // Прокрутить вниз после отправки
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_chat == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.chat)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final messagesAsync = ref.watch(messagesProvider(_chat!.id));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chat),
            Text(
              _chat!.specialistName,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withAlpha((255 * 0.7).round()),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Список сообщений
          Expanded(
            child: messagesAsync.when(
              data: (state) {
                // Если идет загрузка и сообщений нет - показываем индикатор
                if (state.isLoading && state.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Если список пустой после загрузки - показываем сообщение
                if (state.messages.isEmpty) {
                  return Center(child: Text(l10n.noMessages));
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _MessageBubble(message: message),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.errorLoadingMessages,
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
                            .read(messagesProvider(_chat!.id).notifier)
                            .loadMessages();
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Поле ввода сообщения
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((255 * 0.1).round()),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: l10n.typeMessage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    messagesAsync.when(
                      data: (state) => IconButton(
                        onPressed: state.isSending ? null : _sendMessage,
                        icon: state.isSending
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(Icons.send, color: colorScheme.primary),
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.primaryContainer,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (error, stackTrace) => IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(Icons.send, color: colorScheme.primary),
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.primaryContainer,
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет пузырька сообщения
class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: message.isFromSpecialist
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isFromSpecialist
              ? colorScheme.surfaceContainerHighest
              : colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: message.isFromSpecialist
                    ? colorScheme.onSurface
                    : colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.sentAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: message.isFromSpecialist
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onPrimaryContainer.withAlpha(
                        (255 * 0.7).round(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

