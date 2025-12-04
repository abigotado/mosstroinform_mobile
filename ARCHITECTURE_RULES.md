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

## Правила UI и стилизации

### 1. Локализация текстов

**Все тексты должны храниться в локализации.**

**❌ НЕПРАВИЛЬНО:**
```dart
Text('Вход в систему')
Text('Email')
ElevatedButton(onPressed: () {}, child: Text('Войти'))
```

**✅ ПРАВИЛЬНО:**
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.loginTitle)
Text(l10n.emailLabel)
ElevatedButton(onPressed: () {}, child: Text(l10n.loginButton))
```

**Правила:**
- Все строки, видимые пользователю, должны быть в `l10n/app_ru.arb`
- Использовать `AppLocalizations.of(context)!` для получения локализованных строк
- Даже короткие тексты (кнопки, заголовки, подсказки) должны быть локализованы
- Исключение: только технические сообщения для разработчиков (логи, debug)

### 2. Виджет-функции не используются

**Используются только классы виджетов.**

**❌ НЕПРАВИЛЬНО:**
```dart
Widget buildButton(String text) {
  return ElevatedButton(
    onPressed: () {},
    child: Text(text),
  );
}

Widget build(BuildContext context) {
  return Column(
    children: [
      buildButton('Войти'),
    ],
  );
}
```

**✅ ПРАВИЛЬНО:**
```dart
class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const LoginButton({super.key, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(l10n.loginButton),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginButton(onPressed: () {}),
      ],
    );
  }
}
```

**Правила:**
- Все виджеты должны быть классами, наследующими `StatelessWidget` или `StatefulWidget`
- Не использовать функции, возвращающие `Widget`
- Для переиспользуемых компонентов создавать отдельные классы виджетов
- Исключение: только встроенные виджеты Flutter (например, `Padding`, `SizedBox`)

### 3. Стили хранятся в теме

**Все стили (цвета, шрифты, размеры) должны браться из темы.**

**❌ НЕПРАВИЛЬНО:**
```dart
Text(
  'Заголовок',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)

Container(
  color: Colors.grey[200],
  child: Text('Текст'),
)
```

**✅ ПРАВИЛЬНО:**
```dart
final theme = Theme.of(context);

Text(
  l10n.title,
  style: theme.textTheme.headlineMedium,
)

Container(
  color: theme.colorScheme.surfaceContainerHighest,
  child: Text(
    l10n.text,
    style: theme.textTheme.bodyLarge,
  ),
)
```

**Правила:**
- Использовать `Theme.of(context)` для получения темы
- Цвета брать из `theme.colorScheme.*` (например, `primary`, `onSurface`, `surfaceContainerHighest`)
- Шрифты и размеры брать из `theme.textTheme.*` (например, `headlineMedium`, `bodyLarge`, `titleSmall`)
- Не использовать хардкод цветов (`Colors.blue`, `Colors.grey[200]`)
- Не использовать хардкод размеров шрифтов (`fontSize: 24`)
- Исключение: только системные цвета Flutter для специфических случаев (например, `Colors.transparent`)

**Доступные стили из темы:**

**Цвета:**
- `theme.colorScheme.primary` - основной цвет
- `theme.colorScheme.onPrimary` - цвет текста на основном фоне
- `theme.colorScheme.surface` - цвет поверхности
- `theme.colorScheme.onSurface` - цвет текста на поверхности
- `theme.colorScheme.surfaceContainerHighest` - самый светлый контейнер
- `theme.colorScheme.error` - цвет ошибки
- `theme.colorScheme.onError` - цвет текста на ошибке

**Типографика:**
- `theme.textTheme.displayLarge` - самый большой заголовок
- `theme.textTheme.displayMedium` - большой заголовок
- `theme.textTheme.displaySmall` - средний заголовок
- `theme.textTheme.headlineLarge` - заголовок списка
- `theme.textTheme.headlineMedium` - заголовок секции
- `theme.textTheme.headlineSmall` - подзаголовок
- `theme.textTheme.titleLarge` - заголовок карточки
- `theme.textTheme.titleMedium` - заголовок элемента
- `theme.textTheme.titleSmall` - маленький заголовок
- `theme.textTheme.bodyLarge` - основной текст
- `theme.textTheme.bodyMedium` - вторичный текст
- `theme.textTheme.bodySmall` - маленький текст
- `theme.textTheme.labelLarge` - метка (кнопка)
- `theme.textTheme.labelMedium` - средняя метка
- `theme.textTheme.labelSmall` - маленькая метка

## Правила работы с Riverpod

### Импорты для провайдеров

**Всегда добавлять `flutter_riverpod` в импорты при использовании `riverpod_annotation`.**

**❌ НЕПРАВИЛЬНО:**
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
MyType myProvider(MyProviderRef ref) {
  // ...
}
```

**✅ ПРАВИЛЬНО:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
MyType myProvider(Ref ref) {
  // ...
}
```

**Правила:**
- Всегда использовать `Ref ref` вместо типов с суффиксом `Ref` (например, `MyProviderRef`)
- Всегда добавлять `import 'package:flutter_riverpod/flutter_riverpod.dart';` при использовании `@riverpod`
- Это необходимо для корректной работы code generation

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
- [ ] Все тексты локализованы (используется `AppLocalizations`)
- [ ] Нет виджет-функций (только классы виджетов)
- [ ] Все стили берутся из темы (цвета, шрифты)
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

