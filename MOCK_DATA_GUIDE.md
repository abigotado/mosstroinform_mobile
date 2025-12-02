# Руководство по использованию моковых данных

## Обзор

Для демонстрации приложения используются моковые данные, которые позволяют показать полный пользовательский путь без необходимости создания реального бэкенда.

## Структура моковых данных

Моковые данные организованы по фичам:

- `projects_mock_data.dart` - данные проектов
- `documents_mock_data.dart` - документы для согласования
- `construction_mock_data.dart` - данные этапа строительства (камеры, фотоотчёты)
- `chat_mock_data.dart` - данные чата со специалистами
- `completion_mock_data.dart` - финальные документы

## Переключение между моками и реальным API

В файле `lib/core/constants/app_constants.dart` есть флаг `useMocks`:

```dart
static const bool useMocks = true; // Использовать моки
static const bool useMocks = false; // Использовать реальный API
```

## Использование в репозиториях

Пример структуры репозитория с поддержкой моков:

```dart
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final bool useMocks;

  ProjectRepositoryImpl({
    required this.remoteDataSource,
    this.useMocks = false,
  });

  @override
  Future<List<Project>> getProjects() async {
    if (useMocks) {
      // Возвращаем моковые данные
      return ProjectsMockData.projects
          .map((json) => ProjectModel.fromJson(json).toEntity())
          .toList();
    }
    
    // Используем реальный API
    final response = await remoteDataSource.getProjects();
    return response.map((model) => model.toEntity()).toList();
  }
}
```

## Преимущества подхода

1. **Быстрая разработка** - не нужно ждать бэкенд
2. **Полный контроль** - можно создать любые сценарии
3. **Легкое переключение** - один флаг для перехода на реальный API
4. **Тестирование** - легко тестировать edge cases
5. **Демонстрация** - работает офлайн, не зависит от сети

## Альтернативные варианты

### Вариант 1: Mock Server (json-server)

Если нужен более реалистичный подход, можно использовать json-server:

```bash
npm install -g json-server
json-server --watch db.json --port 3000
```

### Вариант 2: Firebase Firestore

Для более продвинутой демонстрации можно использовать Firebase Firestore с тестовыми данными.

### Вариант 3: Простой Node.js сервер

Можно создать простой Express.js сервер для демонстрации.

## Рекомендация для хакатона

Для хакатона рекомендуется использовать **моки** по следующим причинам:

1. Экономия времени - можно сразу начать разработку UI
2. Надёжность - не зависит от стабильности сети или сервера
3. Полный контроль - можно показать любые сценарии
4. Простота демонстрации - работает на любом устройстве

После хакатона можно легко переключиться на реальный API, изменив один флаг.

