# Архитектура проекта

## Обзор

Проект использует **Domain-Driven Design (DDD)** с feature-first структурой. Каждая фича изолирована и содержит все необходимые слои для своей работы.

## Структура проекта

```
lib/
├── core/                           # Общие компоненты приложения
│   ├── theme/                     # Темизация (подготовлено для мультитематизации)
│   │   └── app_theme.dart         # Определение тем (light/dark)
│   ├── config/                    # Конфигурация приложения
│   │   ├── app_config_simple.dart # Конфигурация для разных окружений
│   │   └── app_config_provider.dart # Провайдер конфигурации (Riverpod)
│   ├── network/                   # Сетевой слой
│   │   └── dio_provider.dart      # Провайдер Dio (базовая настройка сети)
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
- **Testing:** flutter_test, mocktail

## Тестирование

Проект имеет полное тестовое покрытие ключевых компонентов. Структура тестов повторяет структуру основного кода.

### Структура тестов

```
test/
├── features/
│   ├── project_selection/
│   │   ├── notifier/              # Тесты для notifiers
│   │   ├── data/repositories/     # Тесты для mock repositories
│   │   ├── domain/usecases/       # Тесты для use cases
│   │   └── ui/widgets/            # Widget тесты
│   ├── document_approval/
│   │   ├── notifier/
│   │   ├── data/repositories/
│   │   ├── domain/usecases/
│   │   └── ui/widgets/
│   ├── chat/
│   │   └── notifier/
│   └── construction_stage/
│       ├── notifier/
│       └── ui/widgets/
└── widget_test.dart               # Базовый тест приложения
```

### Типы тестов

#### 1. Unit тесты для Notifiers

Тестируют логику управления состоянием через Riverpod. Используют `ProviderContainer` для изоляции тестов и моки репозиториев через `mocktail`.

**Пример структуры:**
```dart
void main() {
  late ProviderContainer container;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    container = ProviderContainer(
      overrides: [
        repositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  test('loadData успешно загружает данные', () async {
    when(() => mockRepository.getData())
        .thenAnswer((_) async => data);
    
    final notifier = container.read(notifierProvider.notifier);
    await notifier.loadData();
    
    final state = container.read(notifierProvider);
    expect(state.value?.data, equals(data));
  });
}
```

#### 2. Unit тесты для Repositories

Тестируют mock реализации репозиториев, проверяя корректность работы с состоянием через Riverpod провайдеры.

**Особенности:**
- Используют `ProviderContainer` для доступа к `Ref`
- Тестируют интерактивное состояние (изменения сохраняются в памяти)
- Проверяют бизнес-логику репозиториев

#### 3. Unit тесты для Use Cases

Тестируют бизнес-логику в use cases. Используют моки репозиториев для изоляции.

**Пример:**
```dart
test('call возвращает данные', () async {
  when(() => mockRepository.getData())
      .thenAnswer((_) async => data);
  
  final result = await useCase.call();
  expect(result, equals(data));
});
```

#### 4. Widget тесты

Тестируют UI компоненты, проверяя корректность отображения и взаимодействия.

**Пример:**
```dart
testWidgets('отображает данные корректно', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MyWidget(data: testData),
      ),
    ),
  );
  
  expect(find.text('Expected Text'), findsOneWidget);
});
```

### Принципы тестирования

1. **Изоляция** - каждый тест независим и не влияет на другие
2. **Моки** - используются для изоляции зависимостей
3. **Покрытие** - тестируются все ключевые компоненты
4. **Читаемость** - тесты легко читать и понимать
5. **ARRANGE-ACT-ASSERT** - четкая структура тестов

### Запуск тестов

```bash
# Все тесты
flutter test

# Конкретный файл
flutter test test/features/project_selection/notifier/project_notifier_test.dart

# С покрытием
flutter test --coverage
```

### Текущее покрытие

- ✅ **Notifiers:** 8 файлов тестов (все основные notifiers)
- ✅ **Mock Repositories:** 2 файла тестов
- ✅ **Use Cases:** 7 файлов тестов (все use cases)
- ✅ **Widgets:** 4 файла тестов (ключевые UI компоненты)
- ✅ **Базовый тест:** 1 файл

**Всего: 18 файлов тестов, 76 тестов**

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

