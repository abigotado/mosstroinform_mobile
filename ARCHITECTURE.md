# Архитектура проекта

## Обзор

Проект использует **Domain-Driven Design (DDD)** с feature-first структурой. Каждая фича изолирована и содержит все необходимые слои для своей работы.

## Структура проекта

```
lib/
├── core/                           # Общие компоненты приложения
│   ├── theme/                     # Темизация (подготовлено для мультитематизации)
│   │   └── app_theme.dart         # Определение тем (light/dark)
│   ├── constants/                 # Константы приложения
│   │   └── app_constants.dart     # Базовые константы (URL, таймауты и т.д.)
│   ├── utils/                     # Утилиты
│   └── errors/                    # Обработка ошибок
│       └── failures.dart          # Базовые классы ошибок
│
├── features/                      # Фичи приложения (feature-first)
│   ├── project_selection/         # Выбор проекта
│   ├── document_approval/        # Согласование документации
│   ├── construction_stage/       # Этап строительства
│   ├── chat/                     # Чат со специалистом
│   └── construction_completion/  # Завершение строительства
│       ├── data/                 # Слой данных
│       │   ├── models/           # Модели данных (DTO)
│       │   ├── repositories/     # Реализация репозиториев
│       │   ├── datasources/      # Источники данных (API, локальное хранилище)
│       │   └── providers/        # Провайдеры data source (Retrofit)
│       ├── domain/               # Слой домена
│       │   ├── entities/         # Сущности домена
│       │   ├── repositories/     # Интерфейсы репозиториев
│       │   ├── providers/        # Провайдеры репозиториев (возвращают интерфейсы)
│       │   └── usecases/         # Use cases (бизнес-логика)
│       ├── notifier/             # State management (Riverpod)
│       └── ui/                   # UI слой
│           ├── screens/          # Экраны
│           └── widgets/          # Виджеты фичи
│
└── shared/                        # Общие компоненты
    ├── widgets/                   # Переиспользуемые виджеты
    └── utils/                     # Общие утилиты
```

## Слои архитектуры

### 1. Domain Layer (Доменный слой)

**Назначение:** Содержит бизнес-логику приложения, независимую от внешних зависимостей.

**Компоненты:**
- **Entities** - чистые объекты домена без зависимостей от фреймворков
- **Repositories (интерфейсы)** - контракты для работы с данными
- **Providers (репозиториев)** - провайдеры Riverpod, возвращающие интерфейсы репозиториев
- **Use Cases** - бизнес-логика, инкапсулированная в отдельные классы

**Принципы:**
- Не зависит от других слоев
- Не содержит зависимостей от Flutter или внешних библиотек
- Использует только чистый Dart
- Провайдеры репозиториев находятся в domain слое, так как предоставляют доступ к интерфейсам домена

### 2. Data Layer (Слой данных)

**Назначение:** Реализация работы с данными (API, локальное хранилище).

**Компоненты:**
- **Models** - модели данных (DTO), используют Freezed для генерации кода
- **Repositories (реализация)** - реализация интерфейсов из domain layer
- **Data Sources** - источники данных (Retrofit интерфейсы):
  - RemoteDataSource - работа с API через Retrofit
  - LocalDataSource - работа с локальным хранилищем
- **Providers (data source)** - провайдеры для Retrofit data sources, находятся в data слое

**Принципы:**
- Зависит от domain layer (реализует интерфейсы)
- Может использовать Flutter и внешние библиотеки (Dio, Retrofit)
- Провайдеры data source находятся в data слое, так как зависят от реализации (Retrofit)
- Использует Dio для сетевых запросов
- Использует Retrofit для декларативного описания API

### 3. Notifier Layer (Слой управления состоянием)

**Назначение:** Управление состоянием через Riverpod с code generation.

**Компоненты:**
- **Notifiers** - классы, управляющие состоянием фичи
- Использует `@riverpod` аннотации для генерации провайдеров

**Принципы:**
- Использует Riverpod с code generation
- Связывает domain и UI слои
- Обрабатывает состояния загрузки, ошибок, успеха

### 4. UI Layer (Слой интерфейса)

**Назначение:** Отображение данных пользователю.

**Компоненты:**
- **Screens** - экраны приложения
- **Widgets** - виджеты фичи (не переиспользуемые между фичами)

**Принципы:**
- Использует только классы виджетов (не функции-виджеты)
- Читает состояние через Riverpod провайдеры
- Вызывает методы из notifier слоя для изменения состояния

## Принципы разработки

### Clean Code

1. **Нет widget функций** - используются только классы виджетов
2. **Разделение ответственности** - каждый класс имеет одну ответственность
3. **Интерфейсы для репозиториев** - использование абстракций вместо конкретных реализаций
4. **Типобезопасность** - использование Freezed для моделей данных

### Dependency Injection

- Используется Riverpod для dependency injection
- Все зависимости инжектируются через провайдеры
- Легко тестируется через моки

#### Разделение провайдеров по слоям

**Провайдеры data source** (`data/providers/`):
- Зависят от реализации (Retrofit)
- Пример: `project_data_source_provider.dart`
- Возвращают Retrofit интерфейсы

**Провайдеры репозиториев** (`domain/providers/`):
- Возвращают интерфейсы репозиториев из domain слоя
- Пример: `project_repository_provider.dart`
- Находятся в domain слое, так как предоставляют доступ к интерфейсам домена
- Могут использовать моковые или реальные реализации в зависимости от конфигурации

**Провайдеры конфигурации** (`core/config/`):
- `appConfigSimpleProvider` - провайдер конфигурации приложения
- Используется для определения окружения (dev/staging/prod) и включения моков

**Провайдеры базовой инфраструктуры** (`core/network/`):
- `dioProvider` - базовый провайдер Dio для сетевых запросов

### Error Handling

- Используется система Failure классов
- Ошибки обрабатываются на уровне notifier
- UI отображает понятные сообщения об ошибках

## Технологии

- **State Management:** Riverpod с code generation
- **Networking:** Dio + Retrofit
- **Code Generation:** Freezed, json_serializable, build_runner
- **Navigation:** GoRouter
- **Localization:** flutter_localizations
- **Theming:** ThemeData (подготовлено для мультитематизации)

## Пример структуры фичи

```dart
// domain/entities/project.dart
class Project {
  final String id;
  final String name;
  final String address;
  // ...
}

// domain/repositories/project_repository.dart
abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<Project> getProjectById(String id);
}

// data/models/project_model.dart
@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    required String address,
  }) = _ProjectModel;
  
  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}

// data/repositories/project_repository_impl.dart
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  
  // реализация методов
}

// notifier/project_notifier.dart
@riverpod
class ProjectNotifier extends _$ProjectNotifier {
  // управление состоянием
}

// ui/screens/project_list_screen.dart
class ProjectListScreen extends ConsumerWidget {
  // отображение UI
}
```

