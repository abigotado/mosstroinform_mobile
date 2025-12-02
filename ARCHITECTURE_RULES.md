# Правила архитектуры проекта

## Общие принципы

### 1. Разделение слоёв

Каждая фича должна иметь чёткое разделение на слои:
- **Domain** - бизнес-логика, сущности, интерфейсы репозиториев
- **Data** - реализация репозиториев, модели данных, источники данных, провайдеры данных
- **Notifier** - управление состоянием (только notifiers, без провайдеров данных)
- **UI** - экраны и виджеты

### 2. Провайдеры должны возвращать интерфейсы

**❌ НЕПРАВИЛЬНО:**
```dart
@riverpod
ProjectRepositoryImpl projectRepository(ProjectRepositoryRef ref) {
  // ...
}
```

**✅ ПРАВИЛЬНО:**
```dart
@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  final remoteDataSource = ref.watch(projectRemoteDataSourceImplProvider);
  return ProjectRepositoryImpl(remoteDataSource: remoteDataSource);
}
```

### 3. Размещение провайдеров по слоям

**Провайдеры данных** должны быть в слое `data/providers/`:
- Провайдеры для Dio, DataSource, RepositoryImpl
- Файл: `lib/features/{feature}/data/providers/{feature}_data_providers.dart`

**Провайдеры состояния** должны быть в слое `notifier/`:
- Только Notifiers для управления состоянием
- Файл: `lib/features/{feature}/notifier/{feature}_notifier.dart`

### 4. Структура файлов

```
lib/features/{feature}/
├── data/
│   ├── providers/          # Провайдеры data source (Retrofit)
│   │   └── {feature}_data_source_provider.dart
│   ├── datasources/        # Источники данных (Retrofit интерфейсы)
│   ├── models/            # Модели данных (DTO)
│   └── repositories/      # Реализация репозиториев
├── domain/
│   ├── entities/          # Сущности домена
│   ├── repositories/      # Интерфейсы репозиториев
│   ├── providers/        # Провайдеры репозиториев (возвращают интерфейсы)
│   │   └── {feature}_repository_provider.dart
│   └── usecases/          # Use cases
├── notifier/              # Только Notifiers для состояния
│   └── {feature}_notifier.dart
└── ui/
    ├── screens/           # Экраны
    └── widgets/           # Виджеты фичи
```

## Пример правильной структуры

### Data Layer (`data/providers/`)

```dart
// lib/features/project_selection/data/providers/project_data_providers.dart

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/datasources/project_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/project_repository_impl.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

part 'project_data_providers.g.dart';

/// Провайдер для Dio клиента
@riverpod
Dio dio(DioRef ref) {
  return Dio(/* ... */);
}

/// Провайдер для удалённого источника данных
@riverpod
ProjectRemoteDataSource projectRemoteDataSource(
  ProjectRemoteDataSourceRef ref,
) {
  final dio = ref.watch(dioProvider);
  return ProjectRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}

/// Провайдер для реализации удалённого источника данных
@riverpod
ProjectRemoteDataSourceImpl projectRemoteDataSourceImpl(
  ProjectRemoteDataSourceImplRef ref,
) {
  final remoteDataSource = ref.watch(projectRemoteDataSourceProvider);
  return ProjectRemoteDataSourceImpl(
    remoteDataSource: remoteDataSource,
    useMocks: AppConstants.useMocks,
  );
}

/// Провайдер для репозитория проектов
/// ⚠️ ВАЖНО: Возвращает интерфейс, а не имплементацию!
@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  final remoteDataSource = ref.watch(projectRemoteDataSourceImplProvider);
  return ProjectRepositoryImpl(remoteDataSource: remoteDataSource);
}
```

### Notifier Layer (`notifier/`)

```dart
// lib/features/project_selection/notifier/project_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/providers/project_data_providers.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

part 'project_notifier.g.dart';

/// Notifier для управления состоянием списка проектов
@riverpod
class ProjectsNotifier extends _$ProjectsNotifier {
  @override
  Future<ProjectsState> build() async {
    return const ProjectsState(projects: []);
  }

  Future<void> loadProjects() async {
    // Используем интерфейс из провайдера данных
    final repository = ref.read(projectRepositoryProvider);
    // ...
  }
}
```

## Правила работы с ошибками

### Все warnings должны быть исправлены

- Неиспользуемые импорты
- Неиспользуемые переменные
- Неиспользуемые параметры

### Все errors должны быть исправлены

- Ошибки компиляции
- Ошибки типов
- Ошибки линтера

## Правила именования

### Провайдеры данных
- `{feature}DataProviders` - файл с провайдерами данных
- `{feature}RepositoryProvider` - провайдер репозитория (возвращает интерфейс)
- `{feature}RemoteDataSourceProvider` - провайдер источника данных

### Notifiers
- `{Feature}Notifier` - класс notifier
- `{feature}NotifierProvider` - провайдер notifier

## Чеклист для новой фичи

- [ ] Создана структура папок по слоям
- [ ] Domain layer: entities, repositories (интерфейсы), usecases
- [ ] Data layer: models, datasources, repositories (имплементации), providers
- [ ] Notifier layer: только notifiers, используют интерфейсы из domain
- [ ] UI layer: screens, widgets
- [ ] Провайдеры данных в `data/providers/`
- [ ] Провайдеры возвращают интерфейсы, а не имплементации
- [ ] Все warnings исправлены
- [ ] Все errors исправлены
- [ ] Код сгенерирован (`build_runner build`)

## Примеры неправильной архитектуры

### ❌ Провайдер возвращает имплементацию
```dart
@riverpod
ProjectRepositoryImpl projectRepository(ProjectRepositoryRef ref) {
  // ...
}
```

### ❌ Провайдеры данных в notifier слое
```dart
// lib/features/project_selection/notifier/project_notifier.dart
@riverpod
Dio dio(DioRef ref) { // ❌ Не должен быть здесь
  // ...
}
```

### ❌ Notifier использует имплементацию напрямую
```dart
final repository = ProjectRepositoryImpl(/* ... */); // ❌ Должен использовать провайдер
```

## Примеры правильной архитектуры

### ✅ Провайдер репозитория возвращает интерфейс и находится в domain/providers/
```dart
// lib/features/project_selection/domain/providers/project_repository_provider.dart
@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockProjectRepository();
  }
  final remoteDataSource = ref.watch(projectRemoteDataSourceProvider);
  return ProjectRepositoryImpl(remoteDataSource: remoteDataSource);
}
```

### ✅ Провайдеры data source в data/providers/
```dart
// lib/features/project_selection/data/providers/project_data_source_provider.dart
@riverpod
ProjectRemoteDataSource projectRemoteDataSource(ProjectRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return ProjectRemoteDataSource(dio, baseUrl: config.baseUrl);
}
```

### ✅ Notifier использует провайдер репозитория из domain слоя
```dart
// lib/features/project_selection/notifier/project_notifier.dart
import 'package:mosstroinform_mobile/features/project_selection/domain/providers/project_repository_provider.dart';

final repository = ref.read(projectRepositoryProvider); // ✅ Использует интерфейс из domain слоя
```

