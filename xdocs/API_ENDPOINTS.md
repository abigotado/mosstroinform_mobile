# API Endpoints Documentation

Документация всех эндпойнтов API для мобильного приложения "Стройконтроль Онлайн".

## Базовый URL

```
https://mosstroiinform.vasmarfas.com/api/v1
```

Все запросы требуют авторизации через Bearer токен в заголовке `Authorization`, кроме эндпойнтов `/auth/login` и `/auth/register`.

## Аутентификация

### POST /auth/login
Вход в систему.

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "access_token": "string",
  "refresh_token": "string",
  "user": {
    "id": "string",
    "email": "string",
    "name": "string",
    "phone": "string | null"
  }
}
```

### POST /auth/register
Регистрация нового пользователя.

**Request Body:**
```json
{
  "email": "string",
  "password": "string",
  "name": "string",
  "phone": "string | null"
}
```

**Response:**
```json
{
  "access_token": "string",
  "refresh_token": "string",
  "user": {
    "id": "string",
    "email": "string",
    "name": "string",
    "phone": "string | null"
  }
}
```

### GET /auth/me
Получить информацию о текущем пользователе.

**Response:**
```json
{
  "id": "string",
  "email": "string",
  "name": "string",
  "phone": "string | null"
}
```

### POST /auth/refresh
Обновить access token.

**Request Body:**
```json
{
  "refresh_token": "string"
}
```

**Response:**
```json
{
  "access_token": "string",
  "refresh_token": "string",
  "user": {
    "id": "string",
    "email": "string",
    "name": "string",
    "phone": "string | null"
  }
}
```

## Проекты

### GET /projects
Получить список всех доступных проектов.

**Query Parameters:**
- `page` (int, optional) - номер страницы (начиная с 0)
- `limit` (int, optional) - количество элементов на странице

**Response:**
```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "area": 0.0,
    "floors": 0,
    "bedrooms": 0,
    "bathrooms": 0,
    "price": 0,
    "imageUrl": "string | null",
    "status": "available | requested | construction",
    "objectId": "string | null"
  }
]
```

### GET /projects/{id}
Получить информацию о конкретном проекте.

**Path Parameters:**
- `id` (string) - ID проекта

**Response:**
```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "area": 0.0,
  "floors": 0,
  "bedrooms": 0,
  "bathrooms": 0,
  "price": 0,
  "imageUrl": "string | null",
  "status": "available | requested | construction",
  "objectId": "string | null"
}
```

### POST /projects/{id}/request
Отправить запрос на строительство проекта.

**Path Parameters:**
- `id` (string) - ID проекта

**Response:**
```
204 No Content
```

### POST /projects/{id}/start
Начать строительство проекта (после подписания всех документов).

**Path Parameters:**
- `id` (string) - ID проекта

**Request Body:**
```json
{
  "address": "string"
}
```

**Response:**
```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "area": 0.0,
  "floors": 0,
  "bedrooms": 0,
  "bathrooms": 0,
  "price": 0,
  "imageUrl": "string | null",
  "status": "construction",
  "objectId": "string"
}
```

**Примечание:** При начале строительства автоматически создается объект строительства и чат для этого объекта. `objectId` возвращается в ответе.

## Документы (согласование)

### GET /documents
Получить список всех документов для согласования.

**Response:**
```json
[
  {
    "id": "string",
    "projectId": "string",
    "title": "string",
    "description": "string",
    "fileUrl": "string | null",
    "status": "pending | under_review | approved | rejected",
    "submittedAt": "ISO 8601 datetime | null",
    "approvedAt": "ISO 8601 datetime | null",
    "rejectionReason": "string | null"
  }
]
```

### GET /documents/{id}
Получить информацию о конкретном документе.

**Path Parameters:**
- `id` (string) - ID документа

**Response:**
```json
{
  "id": "string",
  "projectId": "string",
  "title": "string",
  "description": "string",
  "fileUrl": "string | null",
  "status": "pending | under_review | approved | rejected",
  "submittedAt": "ISO 8601 datetime | null",
  "approvedAt": "ISO 8601 datetime | null",
  "rejectionReason": "string | null"
}
```

### POST /documents/{id}/approve
Одобрить документ.

**Path Parameters:**
- `id` (string) - ID документа

**Response:**
```
204 No Content
```

### POST /documents/{id}/reject
Отклонить документ.

**Path Parameters:**
- `id` (string) - ID документа

**Request Body:**
```json
{
  "reason": "string"
}
```

**Response:**
```
204 No Content
```

## Объекты строительства

### GET /construction-sites/object/{objectId}
Получить информацию о строительной площадке по ID объекта строительства.

**Path Parameters:**
- `objectId` (string) - ID объекта строительства

**Response:**
```json
{
  "id": "string",
  "projectId": "string",
  "projectName": "string",
  "address": "string",
  "cameras": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "streamUrl": "string",
      "isActive": true,
      "thumbnailUrl": "string | null"
    }
  ],
  "startDate": "ISO 8601 datetime | null",
  "expectedCompletionDate": "ISO 8601 datetime | null",
  "progress": 0.0
}
```

**Примечание:** `progress` - значение от 0.0 до 1.0 (0% - 100%).

### GET /construction-sites/project/{projectId}
**Deprecated:** Используйте `/construction-sites/object/{objectId}`.

Получить информацию о строительной площадке по ID проекта.

**Path Parameters:**
- `projectId` (string) - ID проекта

**Response:** Аналогично `/construction-sites/object/{objectId}`

### GET /construction-sites/{siteId}/cameras
Получить список всех камер на строительной площадке.

**Path Parameters:**
- `siteId` (string) - ID строительной площадки (objectId)

**Response:**
```json
[
  {
    "id": "string",
    "name": "string",
    "description": "string",
    "streamUrl": "string",
    "isActive": true,
    "thumbnailUrl": "string | null"
  }
]
```

### GET /construction-sites/{siteId}/cameras/{cameraId}
Получить информацию о конкретной камере.

**Path Parameters:**
- `siteId` (string) - ID строительной площадки (objectId)
- `cameraId` (string) - ID камеры

**Response:**
```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "streamUrl": "string",
  "isActive": true,
  "thumbnailUrl": "string | null"
}
```

## Объекты строительства (CRUD)

### GET /construction-objects
Получить список всех объектов строительства текущего пользователя.

**Response:**
```json
[
  {
    "id": "string",
    "projectId": "string",
    "name": "string",
    "address": "string",
    "description": "string",
    "area": 0.0,
    "floors": 0,
    "bedrooms": 0,
    "bathrooms": 0,
    "price": 0,
    "imageUrl": "string | null",
    "stages": [
      {
        "id": "string",
        "name": "string",
        "status": "pending | in_progress | completed"
      }
    ],
    "chatId": "string | null",
    "allDocumentsSigned": false,
    "isCompleted": false
  }
]
```

### GET /construction-objects/{objectId}
Получить информацию о конкретном объекте строительства.

**Path Parameters:**
- `objectId` (string) - ID объекта строительства

**Response:** (Аналогично элементу из списка `GET /construction-objects`)

### POST /construction-objects/{objectId}/complete
Завершить строительство объекта (после подписания всех финальных документов и достижения 100% прогресса).

**Path Parameters:**
- `objectId` (string) - ID объекта строительства

**Требования:**
- Все финальные документы должны быть подписаны (`allDocumentsSigned = true`)
- Прогресс строительства должен быть 100% (`progress = 1.0`)

**Response:**
```
204 No Content
```

**Примечание:** После завершения строительства:
- `isCompleted` устанавливается в `true`
- Документы становятся доступными только для просмотра
- Чат и камеры скрываются
- Объект отображается как завершенный

### PATCH /construction-objects/by-project/{projectId}/documents-status
Обновить статус подписания документов для объекта строительства.

**Path Parameters:**
- `projectId` (string) - ID проекта, связанного с объектом строительства

**Request Body:**
```json
{
  "allDocumentsSigned": true
}
```

**Response:**
```
204 No Content
```

## Чат

### GET /chats
Получить список всех чатов пользователя.

**Response:**
```json
[
  {
    "id": "string",
    "projectId": "string",
    "specialistName": "string",
    "specialistAvatarUrl": "string | null",
    "lastMessage": "string | null",
    "lastMessageAt": "ISO 8601 datetime | null",
    "unreadCount": 0,
    "isActive": true
  }
]
```

**Примечание:** Чат автоматически создается при начале строительства объекта. `projectId` используется для связи чата с проектом/объектом.

### GET /chats/{chatId}
Получить информацию о конкретном чате.

**Path Parameters:**
- `chatId` (string) - ID чата

**Response:**
```json
{
  "id": "string",
  "projectId": "string",
  "specialistName": "string",
  "specialistAvatarUrl": "string | null",
  "lastMessage": "string | null",
  "lastMessageAt": "ISO 8601 datetime | null",
  "unreadCount": 0,
  "isActive": true
}
```

### GET /chats/{chatId}/messages
Получить список сообщений в чате.

**Path Parameters:**
- `chatId` (string) - ID чата

**Response:**
```json
[
  {
    "id": "string",
    "chatId": "string",
    "text": "string",
    "sentAt": "ISO 8601 datetime",
    "isFromSpecialist": false,
    "isRead": false
  }
]
```

### POST /chats/{chatId}/messages
Отправить сообщение в чат.

**Path Parameters:**
- `chatId` (string) - ID чата

**Request Body:**
```json
{
  "text": "string"
}
```

**Response:**
```json
{
  "id": "string",
  "chatId": "string",
  "text": "string",
  "sentAt": "ISO 8601 datetime",
  "isFromSpecialist": false,
  "isRead": false
}
```

### POST /chats/{chatId}/messages/read
Пометить все сообщения в чате как прочитанные.

**Path Parameters:**
- `chatId` (string) - ID чата

**Response:**
```
204 No Content
```

## Завершение строительства

### GET /projects/{projectId}/completion-status
Получить статус завершения строительства проекта.

**Path Parameters:**
- `projectId` (string) - ID проекта

**Response:**
```json
{
  "projectId": "string",
  "isCompleted": false,
  "completionDate": "ISO 8601 datetime | null",
  "progress": 1.0,
  "allDocumentsSigned": false,
  "documents": [
    {
      "id": "string",
      "title": "string",
      "description": "string",
      "fileUrl": "string | null",
      "status": "pending | signed | rejected",
      "submittedAt": "ISO 8601 datetime | null",
      "signedAt": "ISO 8601 datetime | null",
      "signatureUrl": "string | null"
    }
  ]
}
```

**Примечание:** 
- `progress` - значение от 0.0 до 1.0 (0% - 100%), приходит с бэкенда
- `isCompleted` - становится `true` только после вызова `POST /construction-objects/{objectId}/complete` (нажатие кнопки "Завершить строительство")
- `allDocumentsSigned` - отдельный параметр, который показывает, что все финальные документы подписаны. Когда `allDocumentsSigned = true`, появляется кнопка "Завершить строительство"

### GET /projects/{projectId}/final-documents
Получить список финальных документов для подписания.

**Path Parameters:**
- `projectId` (string) - ID проекта

**Response:**
```json
[
  {
    "id": "string",
    "title": "string",
    "description": "string",
    "fileUrl": "string | null",
    "status": "pending | signed | rejected",
    "submittedAt": "ISO 8601 datetime | null",
    "signedAt": "ISO 8601 datetime | null",
    "signatureUrl": "string | null"
  }
]
```

### GET /projects/{projectId}/final-documents/{documentId}
Получить информацию о конкретном финальном документе.

**Path Parameters:**
- `projectId` (string) - ID проекта
- `documentId` (string) - ID документа

**Response:**
```json
{
  "id": "string",
  "title": "string",
  "description": "string",
  "fileUrl": "string | null",
  "status": "pending | signed | rejected",
  "submittedAt": "ISO 8601 datetime | null",
  "signedAt": "ISO 8601 datetime | null",
  "signatureUrl": "string | null"
}
```

### POST /projects/{projectId}/final-documents/{documentId}/sign
Подписать финальный документ.

**Path Parameters:**
- `projectId` (string) - ID проекта
- `documentId` (string) - ID документа

**Response:**
```
204 No Content
```

### POST /projects/{projectId}/final-documents/{documentId}/reject
Отклонить финальный документ.

**Path Parameters:**
- `projectId` (string) - ID проекта
- `documentId` (string) - ID документа

**Request Body:**
```json
{
  "reason": "string"
}
```

**Response:**
```
204 No Content
```

## Коды ошибок

- `400 Bad Request` - Неверный формат запроса
- `401 Unauthorized` - Требуется авторизация
- `403 Forbidden` - Доступ запрещен
- `404 Not Found` - Ресурс не найден
- `422 Unprocessable Entity` - Ошибка валидации данных
- `500 Internal Server Error` - Внутренняя ошибка сервера

## Примечания

1. Все даты и время передаются в формате ISO 8601 (например: `2024-01-15T10:30:00Z`).

2. Все числовые значения (`area`, `price`, `progress`) передаются как числа, а не строки.

3. Статусы проектов:
   - `available` - проект доступен для запроса
   - `requested` - запрос на строительство отправлен
   - `construction` - строительство начато

4. Статусы документов согласования:
   - `pending` - ожидает рассмотрения
   - `under_review` - на рассмотрении
   - `approved` - одобрен
   - `rejected` - отклонен

5. Статусы финальных документов:
   - `pending` - ожидает подписания
   - `signed` - подписан
   - `rejected` - отклонен

6. При начале строительства (`POST /projects/{id}/start`):
   - Автоматически создается объект строительства
   - Автоматически создается чат для объекта
   - `objectId` и `chatId` возвращаются в ответе или доступны через соответствующие эндпойнты

7. `streamUrl` для камер должен поддерживать HLS формат (`.m3u8`) для потокового видео.

