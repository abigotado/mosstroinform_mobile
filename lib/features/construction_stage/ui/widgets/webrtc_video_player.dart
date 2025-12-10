import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';

/// WebRTC видеоплеер для веб-платформы
/// Используется для воспроизведения RTSP потоков через WebRTC на вебе
class WebRTCVideoPlayer extends StatefulWidget {
  final String streamUrl;
  final String? signalingServerUrl;
  final bool autoplay;
  final bool muted;

  const WebRTCVideoPlayer({
    super.key,
    required this.streamUrl,
    this.signalingServerUrl,
    this.autoplay = true,
    this.muted = false,
  });

  @override
  State<WebRTCVideoPlayer> createState() => _WebRTCVideoPlayerState();
}

class _WebRTCVideoPlayerState extends State<WebRTCVideoPlayer> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  RTCVideoRenderer? _renderer;
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 3;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _initializeWebRTC();
    } else {
      AppLogger.warning('WebRTCVideoPlayer используется только на вебе');
      setState(() {
        _hasError = true;
        _errorMessage = 'WebRTC поддерживается только на вебе';
      });
    }
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    _disposeWebRTC();
    super.dispose();
  }

  Future<void> _initializeWebRTC() async {
    try {
      AppLogger.debug('Инициализация WebRTC для веба');
      AppLogger.debug('Stream URL: ${widget.streamUrl}');

      // Создаем renderer для отображения видео
      _renderer = RTCVideoRenderer();
      await _renderer!.initialize();

      // Создаем peer connection
      _peerConnection = await createPeerConnection({
        'iceServers': [
          {'urls': 'stun:stun.l.google.com:19302'},
        ],
      });

      // Обработка ICE кандидатов
      _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
        AppLogger.debug('ICE candidate: ${candidate.candidate}');
        // Здесь можно отправить кандидата на signaling сервер
      };

      // Обработка получения remote stream
      _peerConnection!.onTrack = (RTCTrackEvent event) {
        AppLogger.debug('Received remote track: ${event.track.kind}');
        if (event.track.kind == 'video' && _renderer != null) {
          _renderer!.srcObject = event.streams[0];
          setState(() {
            _isInitialized = true;
            _hasError = false;
          });
        }
      };

      // Обработка изменения состояния соединения
      _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
        AppLogger.debug('PeerConnection state: $state');
        if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
            state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
          _handleConnectionError('Соединение потеряно');
        } else if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
          setState(() {
            _hasError = false;
            _reconnectAttempts = 0;
          });
        }
      };

      // Если есть signaling сервер, подключаемся через него
      if (widget.signalingServerUrl != null) {
        await _connectViaSignalingServer();
      } else {
        // Прямое подключение (требует, чтобы сервер предоставлял WebRTC endpoint)
        await _connectDirectly();
      }
    } catch (e, stackTrace) {
      AppLogger.error('Ошибка инициализации WebRTC: $e', e, stackTrace);
      setState(() {
        _hasError = true;
        _errorMessage = 'Ошибка инициализации WebRTC: $e';
      });
    }
  }

  Future<void> _connectViaSignalingServer() async {
    try {
      AppLogger.debug('Подключение через signaling сервер: ${widget.signalingServerUrl}');

      // Создаем offer
      final offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);

      // Отправляем offer на signaling сервер
      // В реальном приложении здесь должен быть WebSocket запрос к signaling серверу
      // с передачей RTSP URL и получением answer
      AppLogger.debug('Sending offer to signaling server');
      
      // TODO: Реализовать WebSocket соединение с signaling сервером
      // Пример реализации:
      // 1. Подключиться к WebSocket: final ws = WebSocket(widget.signalingServerUrl!);
      // 2. Отправить RTSP URL и offer: ws.send(jsonEncode({'rtspUrl': widget.streamUrl, 'offer': offer.toMap()}));
      // 3. Получить answer от сервера
      // 4. Установить remote description: await _peerConnection!.setRemoteDescription(answer);
      
      AppLogger.warning('Signaling server integration not fully implemented. '
          'See WEBRTC_SETUP.md for setup instructions with free hosting options.');

      // Для демонстрации: если signaling сервер не реализован,
      // показываем ошибку с инструкцией
      setState(() {
        _hasError = true;
        _errorMessage =
            'Signaling сервер не настроен.\n\n'
            'Для работы RTSP на вебе необходимо:\n'
            '1. Развернуть WebRTC сервер (Janus Gateway) на бесплатном хостинге (Railway, Render)\n'
            '2. Добавить URL в AppConfigSimple.webrtcSignalingUrl\n'
            '3. Реализовать WebSocket соединение в _connectViaSignalingServer()\n\n'
            'Подробнее: см. xdocs/WEBRTC_SETUP.md';
      });
    } catch (e, stackTrace) {
      AppLogger.error('Ошибка подключения через signaling сервер: $e', e, stackTrace);
      setState(() {
        _hasError = true;
        _errorMessage = 'Ошибка подключения: $e';
      });
    }
  }

  Future<void> _connectDirectly() async {
    try {
      AppLogger.debug('Прямое подключение к WebRTC endpoint');

      // Для прямого подключения RTSP URL должен быть преобразован в WebRTC endpoint
      // Например: rtsp://camera -> wss://webrtc-server/stream?rtsp=...
      // Это требует серверной части, которая конвертирует RTSP в WebRTC

      AppLogger.warning(
          'Прямое подключение требует WebRTC endpoint. RTSP URL не может быть использован напрямую.');

      setState(() {
        _hasError = true;
        _errorMessage =
            'Для воспроизведения RTSP на вебе необходим сервер, который конвертирует RTSP в WebRTC. '
            'Используйте signaling сервер или HLS альтернативу.';
      });
    } catch (e, stackTrace) {
      AppLogger.error('Ошибка прямого подключения: $e', e, stackTrace);
      setState(() {
        _hasError = true;
        _errorMessage = 'Ошибка подключения: $e';
      });
    }
  }

  void _handleConnectionError(String message) {
    AppLogger.warning('Ошибка соединения: $message');
    setState(() {
      _hasError = true;
      _errorMessage = message;
    });

    // Попытка переподключения
    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnectAttempts++;
      AppLogger.debug('Попытка переподключения $_reconnectAttempts/$_maxReconnectAttempts');
      _reconnectTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          _initializeWebRTC();
        }
      });
    }
  }

  Future<void> _disposeWebRTC() async {
    _reconnectTimer?.cancel();
    await _localStream?.dispose();
    await _peerConnection?.dispose();
    await _renderer?.dispose();
    _localStream = null;
    _peerConnection = null;
    _renderer = null;
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const Center(
        child: Text('WebRTC поддерживается только на вебе'),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Ошибка воспроизведения',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 8),
            const Text(
              'Для воспроизведения RTSP на вебе необходим сервер, который конвертирует RTSP в WebRTC.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (!_isInitialized || _renderer == null) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Подключение к видеопотоку...'),
          ],
        ),
      );
    }

    return RTCVideoView(
      _renderer!,
      objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
      mirror: false,
    );
  }
}

