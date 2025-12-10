# Настройка WebRTC для RTSP потоков на вебе

## Обзор

Для воспроизведения RTSP потоков на вебе необходимо использовать WebRTC, так как браузеры не поддерживают RTSP напрямую. Это требует сервер, который конвертирует RTSP поток в WebRTC.

## Бесплатные решения

### 1. Развертывание собственного сервера на бесплатном хостинге

#### Вариант A: Janus Gateway (рекомендуется)

**Janus Gateway** - это open-source WebRTC сервер с поддержкой RTSP to WebRTC.

**Бесплатные хостинги:**
- **Railway** (railway.app) - бесплатный план с $5 кредитами/месяц
- **Render** (render.com) - бесплатный план с ограничениями
- **Fly.io** (fly.io) - бесплатный план для небольших приложений

**Быстрый старт с Railway:**
1. Создайте аккаунт на railway.app
2. Создайте новый проект
3. Используйте готовый шаблон Janus Gateway или Docker образ
4. Получите URL вашего сервера (например: `wss://your-janus.railway.app/janus`)

**Конфигурация:**
```dart
webrtcSignalingUrl: 'wss://your-janus.railway.app/janus',
```

#### Вариант B: Собственный Node.js/Python сервер

Можно развернуть простой signaling сервер на Node.js или Python.

**Пример минимального Node.js сервера:**
```javascript
// server.js
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
  ws.on('message', (message) => {
    // Обработка signaling сообщений
    // Конвертация RTSP в WebRTC через библиотеку типа node-rtsp-stream
  });
});
```

Разверните на Railway/Render/Fly.io и используйте полученный URL.

### 2. Cloudflare Calls (бесплатный план)

**Cloudflare Calls** предоставляет управляемые TURN/SFU серверы.

**Особенности:**
- Бесплатно до 1000 ГБ передачи данных/месяц
- Высокая надежность
- Глобальное масштабирование

**Настройка:**
1. Зарегистрируйтесь на cloudflare.com
2. Создайте проект в Cloudflare Calls
3. Получите API ключи
4. Настройте signaling через Cloudflare API

**Ограничения:**
- Требует настройки через API
- Не предоставляет готовый RTSP to WebRTC конвертер
- Нужна дополнительная серверная логика

### 3. Альтернатива: HLS потоки для веба

Вместо WebRTC можно использовать HLS потоки, которые поддерживаются браузерами из коробки.

**Преимущества:**
- Не требует дополнительных серверов
- Работает напрямую в браузере
- Проще в настройке

**Недостатки:**
- Больше задержка, чем у WebRTC
- Требует конвертации RTSP в HLS на сервере

**Реализация:**
Если ваш API предоставляет HLS версию потока, можно использовать её для веба:

```dart
// В camera_view_screen.dart
if (kIsWeb && isRTSP) {
  // Попробовать использовать HLS альтернативу
  final hlsUrl = widget.camera.hlsUrl ?? widget.camera.streamUrl.replaceAll('rtsp://', 'https://').replaceAll(':8554', '/hls/stream.m3u8');
  // Использовать стандартный VideoPlayerController с HLS
}
```

## Настройка в приложении

### 1. Добавьте URL signaling сервера в конфигурацию

Отредактируйте `lib/core/config/app_config_simple.dart`:

```dart
factory AppConfigSimple.prod() {
  return AppConfigSimple(
    baseUrl: 'https://mosstroiinform.vasmarfas.com/api/v1',
    useMocks: false,
    requestTimeout: 30,
    environmentName: 'Production',
    webrtcSignalingUrl: 'wss://your-webrtc-server.railway.app/janus', // Ваш URL
  );
}
```

### 2. Проверьте работу

1. Запустите приложение на вебе: `flutter run -d chrome`
2. Откройте экран с камерой
3. Если signaling сервер настроен правильно, видео должно воспроизводиться

## Рекомендации

1. **Для разработки/тестирования:** Используйте Railway или Render для быстрого развертывания Janus Gateway
2. **Для production:** Рассмотрите платные решения для большей надежности и производительности
3. **Альтернатива:** Если возможно, используйте HLS потоки для веба вместо RTSP

## Полезные ссылки

- [Janus Gateway Documentation](https://janus.conf.meetecho.com/docs/)
- [Railway Documentation](https://docs.railway.app/)
- [Render Documentation](https://render.com/docs)
- [Cloudflare Calls](https://developers.cloudflare.com/calls/)

