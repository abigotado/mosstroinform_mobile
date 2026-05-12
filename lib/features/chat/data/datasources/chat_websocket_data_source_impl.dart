import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/chat/data/models/chat_model.dart';
import 'package:mosstroinform_mobile/features/chat/domain/datasources/chat_websocket_data_source.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat.dart';
import 'package:mosstroinform_mobile/features/chat/domain/entities/chat_action.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Реализация WebSocket клиента для чата
class ChatWebSocketDataSourceImpl implements IChatWebSocketDataSource {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _isConnected = false;
  String? _currentChatId;

  @override
  bool get isConnected => _isConnected && _channel != null;

  /// Получить WebSocket URL для чата
  String _getWebSocketUrl(String baseUrl, String chatId) {
    // Преобразуем https://api.dev.msitech.ru/api/v1
    // в wss://api.dev.msitech.ru/chat/{chatId}
    final uri = Uri.parse(baseUrl);
    final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';
    final host = uri.host;
    final port = uri.hasPort ? ':${uri.port}' : '';

    // Убираем /api/v1 из пути, оставляем только /chat/{chatId}
    return '$wsScheme://$host$port/chat/$chatId';
  }

  @override
  Future<void> connect(
    String chatId,
    void Function(Message message) onMessage,
    void Function(Object error) onError,
  ) async {
    AppLogger.info('[WebSocket] connect: начало подключения к чату $chatId');

    // Если уже подключены к этому чату, ничего не делаем
    if (_isConnected && _currentChatId == chatId) {
      AppLogger.info('[WebSocket] connect: уже подключен к чату $chatId, пропускаем');
      return;
    }

    // Отключаемся от предыдущего соединения, если есть
    if (_isConnected) {
      AppLogger.info('[WebSocket] connect: отключение от предыдущего чата $_currentChatId');
      await disconnect();
    }

    try {
      // Получаем baseUrl из конфигурации
      // Для WebSocket используем тот же хост, но другой путь
      final baseUrl = AppConstants.baseUrl;
      final wsUrl = _getWebSocketUrl(baseUrl, chatId);

      AppLogger.info('[WebSocket] connect: формирование URL из baseUrl=$baseUrl');
      AppLogger.info('[WebSocket] connect: WebSocket URL=$wsUrl');
      AppLogger.info('[WebSocket] connect: подключение к чату $chatId...');

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _currentChatId = chatId;

      AppLogger.info('[WebSocket] connect: WebSocketChannel создан, подписка на поток...');

      // Подписываемся на сообщения
      AppLogger.info('[WebSocket] connect: подписка на поток сообщений...');
      _subscription = _channel!.stream.listen(
        (data) {
          try {
            AppLogger.info(
              '[WebSocket] ← получено сообщение (тип: ${data.runtimeType}, длина: ${data is String ? data.length : 'N/A'})',
            );
            // В дебаг режиме показываем полное содержимое сообщения
            if (kDebugMode) {
              AppLogger.info('[WebSocket] ← raw data: $data');
            }

            // Парсим JSON
            final json = jsonDecode(data as String) as Map<String, dynamic>;
            // В дебаг режиме показываем распарсенный JSON
            if (kDebugMode) {
              AppLogger.info('[WebSocket] ← parsed JSON: $json');
            }

            // Проверяем тип действия
            final actionType = json['type'] as String?;

            // Если есть поле 'type', это action (CREATE или READ)
            // Если нет поля 'type', но есть 'id' и 'text', это ChatMessage (транслированное сообщение)
            if (actionType == 'CREATE' || (actionType == null && json['id'] != null && json['text'] != null)) {
              // Сервер отправляет либо CREATE action, либо ChatMessage (транслированное сообщение)
              // Оптимизированная обработка без лишних логов в production
              try {
                // Поддерживаем оба формата: camelCase и snake_case (оптимизированная проверка)
                final fromSpecialist = json['fromSpecialist'] ?? json['is_from_specialist'] ?? false;
                final isRead = json['isRead'] ?? json['is_read'] ?? json['read'] ?? false;
                
                // Поддерживаем оба формата для даты (оптимизированная проверка)
                final sentAtStr = json['sentAt'] ?? json['sent_at'];
                final createdAtStr = json['createdAt'] ?? json['created_at'];
                
                final messageModel = MessageModel(
                  id: json['id'] ?? json['messageId'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  chatId: chatId,
                  text: json['text'] as String,
                  sentAt: sentAtStr != null
                      ? DateTime.parse(sentAtStr as String)
                      : (createdAtStr != null ? DateTime.parse(createdAtStr as String) : DateTime.now()),
                  isFromSpecialist: fromSpecialist as bool? ?? false,
                  isRead: isRead as bool? ?? false,
                );

                // Конвертируем модель в entity и передаем в callback
                onMessage(messageModel.toEntity());
              } catch (e, stackTrace) {
                AppLogger.error('[WebSocket] ← ошибка создания сообщения: $e', stackTrace);
                onError(e);
              }
            } else if (actionType == 'READ') {
              // Действие READ - сообщение прочитано (игнорируем для мобилки)
              // Можно обновить статус сообщения, но для мобилки это не критично
            } else if (kDebugMode) {
              AppLogger.warning('[WebSocket] ← неизвестный тип действия или формат: $actionType');
              AppLogger.info('[WebSocket] ← полный JSON: $json');
            }
          } catch (e, stackTrace) {
            AppLogger.error('[WebSocket] ← ошибка обработки сообщения: $e', stackTrace);
            AppLogger.error('[WebSocket] ← stackTrace: $stackTrace');
            onError(e);
          }
        },
        onError: (error) {
          AppLogger.error('[WebSocket] ✗ ошибка в потоке WebSocket: $error');
          AppLogger.error('[WebSocket] ✗ тип ошибки: ${error.runtimeType}');
          _isConnected = false;
          AppLogger.warning('[WebSocket] ✗ статус соединения изменен на: disconnected');
          onError(error);
        },
        onDone: () {
          AppLogger.info('[WebSocket] ✓ WebSocket соединение закрыто (onDone)');
          AppLogger.info('[WebSocket] ✓ chatId: $_currentChatId');
          _isConnected = false;
          AppLogger.warning('[WebSocket] ✓ статус соединения изменен на: disconnected');
        },
        cancelOnError: false,
      );

      _isConnected = true;
      AppLogger.info('[WebSocket] ✓ успешно подключен к чату $chatId');
      AppLogger.info('[WebSocket] ✓ URL: $_getWebSocketUrl(AppConstants.baseUrl, chatId)');
      AppLogger.info('[WebSocket] ✓ статус соединения: connected');
    } catch (e, stackTrace) {
      AppLogger.error('[WebSocket] ✗ ошибка подключения: $e', stackTrace);
      AppLogger.error('[WebSocket] ✗ тип ошибки: ${e.runtimeType}');
      AppLogger.error('[WebSocket] ✗ chatId: $chatId');
      AppLogger.error('[WebSocket] ✗ stackTrace: $stackTrace');
      _isConnected = false;
      AppLogger.warning('[WebSocket] ✗ статус соединения: failed');
      onError(e);
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    if (!_isConnected) {
      AppLogger.info('[WebSocket] disconnect: уже отключен, пропускаем');
      return;
    }

    try {
      AppLogger.info('[WebSocket] disconnect: начало отключения от чата $_currentChatId');
      AppLogger.debug('[WebSocket] disconnect: отмена подписки...');

      await _subscription?.cancel();
      AppLogger.debug('[WebSocket] disconnect: подписка отменена');

      AppLogger.debug('[WebSocket] disconnect: закрытие канала...');
      await _channel?.sink.close();
      AppLogger.debug('[WebSocket] disconnect: канал закрыт');

      _subscription = null;
      _channel = null;
      _isConnected = false;
      final disconnectedChatId = _currentChatId;
      _currentChatId = null;

      AppLogger.info('[WebSocket] ✓ успешно отключен от чата $disconnectedChatId');
      AppLogger.info('[WebSocket] ✓ статус соединения: disconnected');
    } catch (e, stackTrace) {
      AppLogger.error('[WebSocket] ✗ ошибка отключения: $e', stackTrace);
      AppLogger.error('[WebSocket] ✗ тип ошибки: ${e.runtimeType}');
      AppLogger.error('[WebSocket] ✗ stackTrace: $stackTrace');
    }
  }

  @override
  Future<void> sendAction(ChatAction action) async {
    AppLogger.info('[WebSocket] sendAction: начало отправки действия типа ${action.type}');

    if (!_isConnected || _channel == null) {
      AppLogger.error('[WebSocket] ✗ sendAction: WebSocket не подключен');
      AppLogger.error('[WebSocket] ✗ sendAction: isConnected=$_isConnected, channel=${_channel != null}');
      throw Exception('WebSocket не подключен');
    }

    try {
      Map<String, dynamic> json;
      if (action is CreateMessageAction) {
        AppLogger.info('[WebSocket] → отправка CREATE action');
        AppLogger.info('[WebSocket] → text: ${action.text}');
        AppLogger.info('[WebSocket] → fromSpecialist: ${action.fromSpecialist}');
        json = action.toJson();
      } else if (action is ReadMessageAction) {
        AppLogger.info('[WebSocket] → отправка READ action');
        AppLogger.info('[WebSocket] → messageId: ${action.messageId}');
        json = action.toJson();
      } else {
        AppLogger.error('[WebSocket] ✗ sendAction: неизвестный тип действия: ${action.type}');
        throw Exception('Неизвестный тип действия: ${action.type}');
      }

      final jsonString = jsonEncode(json);
      AppLogger.info('[WebSocket] → отправка действия: $jsonString');
      if (kDebugMode) {
        AppLogger.info('[WebSocket] → длина JSON: ${jsonString.length} символов');
      }

      _channel!.sink.add(jsonString);
      AppLogger.info('[WebSocket] ✓ действие успешно отправлено');
    } catch (e, stackTrace) {
      AppLogger.error('[WebSocket] ✗ ошибка отправки действия: $e', stackTrace);
      AppLogger.error('[WebSocket] ✗ тип ошибки: ${e.runtimeType}');
      AppLogger.error('[WebSocket] ✗ тип действия: ${action.type}');
      AppLogger.error('[WebSocket] ✗ stackTrace: $stackTrace');
      rethrow;
    }
  }
}
