# Руководство по использованию Flavors

## Обзор

Проект использует **Flavors** для управления разными окружениями (dev, staging, prod) с помощью пакета **envied** для типобезопасных переменных окружения.

## Flavors

### 1. **dev** - Разработка
- Использует моковые данные (`useMocks: true`)
- API URL: `https://api-dev.example.com`
- Application ID: `com.mosstroinform.mosstroinform_mobile.dev`
- Имя приложения: "Стройконтроль Dev"

### 2. **staging** - Тестирование
- Использует реальный API (`useMocks: false`)
- API URL: `https://api-staging.example.com`
- Application ID: `com.mosstroinform.mosstroinform_mobile.staging`
- Имя приложения: "Стройконтроль Staging"

### 3. **prod** - Production
- Использует реальный API (`useMocks: false`)
- API URL: `https://api.example.com`
- Application ID: `com.mosstroinform.mosstroinform_mobile`
- Имя приложение: "Стройконтроль Онлайн"

## Запуск приложения с разными flavors

### VS Code (рекомендуется)

В проекте уже настроен `.vscode/launch.json` с конфигурациями для всех flavors:

1. Откройте панель отладки (F5 или Cmd+Shift+D)
2. Выберите нужную конфигурацию из выпадающего списка:
   - **Dev (с моками)** - для разработки с моковыми данными
   - **Staging** - для тестирования с реальным API
   - **Production** - для production окружения
   - Также доступны варианты для Android и iOS

### Командная строка

#### Android

```bash
# Dev flavor
flutter run --flavor dev -t lib/main.dart --dart-define=FLAVOR=dev

# Staging flavor
flutter run --flavor staging -t lib/main.dart --dart-define=FLAVOR=staging

# Production flavor
flutter run --flavor prod -t lib/main.dart --dart-define=FLAVOR=prod

# С передачей flavor через dart-define (без указания flavor)
flutter run --dart-define=FLAVOR=dev -t lib/main.dart
```

#### iOS

```bash
# Dev flavor
flutter run --flavor dev -t lib/main.dart --dart-define=FLAVOR=dev

# Staging flavor
flutter run --flavor staging -t lib/main.dart --dart-define=FLAVOR=staging

# Production flavor
flutter run --flavor prod -t lib/main.dart --dart-define=FLAVOR=prod
```

### Сборка APK/IPA

```bash
# Android APK (dev)
flutter build apk --flavor dev --release

# Android APK (staging)
flutter build apk --flavor staging --release

# Android APK (prod)
flutter build apk --flavor prod --release

# iOS IPA (dev)
flutter build ios --flavor dev --release

# iOS IPA (staging)
flutter build ios --flavor staging --release

# iOS IPA (prod)
flutter build ios --flavor prod --release
```

## Настройка переменных окружения

### Использование AppConfigSimple (текущая реализация)

Текущая реализация использует `AppConfigSimple`, который не требует файлов `.env` и работает сразу из коробки. Flavor определяется через `--dart-define` или по умолчанию используется `dev`.

**Преимущества:**
- Работает сразу без дополнительной настройки
- Не требует генерации кода
- Простая конфигурация
- Легко переключаться между окружениями

**Недостатки:**
- Конфигурация хранится в коде (не в .env файлах)
- Менее гибкая для сложных сценариев

### Использование envied (опционально, для будущего)

Если в будущем понадобится более продвинутое управление переменными окружения, можно использовать `envied`:

1. Раскомментируйте зависимости в `pubspec.yaml`:
```yaml
dependencies:
  envied: ^1.3.2

dev_dependencies:
  envied_generator: ^1.1.1
```

2. Создайте файлы `.env.dev`, `.env.staging`, `.env.prod`
3. Используйте `AppConfig` вместо `AppConfigSimple`
4. Сгенерируйте код: `flutter pub run build_runner build`

## Использование в коде

### Получение конфигурации

```dart
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';

// Использование констант (автоматически берутся из текущего flavor)
final baseUrl = AppConstants.baseUrl;
final useMocks = AppConstants.useMocks;
final timeout = AppConstants.requestTimeout;
final envName = AppConstants.environmentName;
```

### Использование в репозиториях

```dart
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final bool useMocks;

  ProjectRepositoryImpl({
    required this.remoteDataSource,
    this.useMocks = AppConstants.useMocks, // Используем из констант
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

## Настройка Android

Flavors уже настроены в `android/app/build.gradle.kts`:

- Каждый flavor имеет свой `applicationIdSuffix`
- Каждый flavor имеет свой `versionNameSuffix`
- Каждый flavor имеет своё имя приложения

## Настройка iOS

Для iOS нужно создать схемы в Xcode:

1. Откройте `ios/Runner.xcworkspace` в Xcode
2. Выберите схему "Runner" → "Edit Scheme"
3. Создайте новые схемы для каждого flavor:
   - `dev`
   - `staging`
   - `prod`
4. Для каждой схемы настройте Build Configuration:
   - Dev → Debug
   - Staging → Release
   - Prod → Release

Или используйте автоматическую настройку через скрипты (см. документацию Flutter).

## Переключение между моками и реальным API

Flavor автоматически определяет, использовать ли моки:

- **dev** → `useMocks: true` (используются моки)
- **staging** → `useMocks: false` (используется реальный API)
- **prod** → `useMocks: false` (используется реальный API)

Это позволяет:
- Быстро разрабатывать с моками в dev окружении
- Тестировать с реальным API в staging
- Использовать реальный API в production

## Преимущества подхода

1. **Типобезопасность** - envied обеспечивает проверку типов на этапе компиляции
2. **Разделение окружений** - разные конфигурации для dev/staging/prod
3. **Безопасность** - `.env` файлы не попадают в git
4. **Гибкость** - легко добавлять новые переменные окружения
5. **Простота использования** - один флаг для переключения между моками и API

## VS Code Tasks

В проекте также настроены задачи в `.vscode/tasks.json`:

- `flutter: pub get` - установка зависимостей
- `flutter: build_runner build` - генерация кода
- `flutter: build_runner watch` - автоматическая генерация кода при изменениях
- `flutter: analyze` - анализ кода
- `flutter: format` - форматирование кода
- `build: Android APK (dev/staging/prod)` - сборка APK для разных flavors
- `build: iOS (dev/staging/prod)` - сборка iOS для разных flavors

Запустить задачи можно через Command Palette (Cmd+Shift+P) → "Tasks: Run Task"

## Рекомендации

- Для **хакатона/демо**: используйте `dev` flavor с моками (конфигурация "Dev (с моками)" в VS Code)
- Для **тестирования**: используйте `staging` flavor с реальным API
- Для **production**: используйте `prod` flavor с реальным API

