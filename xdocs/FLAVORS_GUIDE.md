# Руководство по использованию Flavors

## Обзор

Проект использует **Flavors** для управления разными окружениями (mock, prod) с помощью упрощенной конфигурации `AppConfigSimple`.

## Flavors

### 1. **mock** - Режим с моками (по умолчанию)
- Использует моковые данные (`useMocks: true`)
- API URL: `https://api-mock.example.com`
- Имя приложения: "Mock"
- **Используется для разработки и тестирования без реального API**

### 2. **prod** - Production
- Использует реальный API (`useMocks: false`)
- API URL: `https://api.example.com`
- Имя приложения: "Production"
- **Используется для production окружения с реальными данными**

## Запуск приложения с разными flavors

### VS Code (рекомендуется)

В проекте уже настроен `.vscode/launch.json` с конфигурациями для всех flavors:

1. Откройте панель отладки (F5 или Cmd+Shift+D)
2. Выберите нужную конфигурацию из выпадающего списка:
   - **Mock (с моками)** - для разработки с моковыми данными
   - **Mock (Release)** - для release сборки с моками
   - **Production** - для production окружения
   - **Production (Release)** - для production release сборки
   - Также доступны варианты для Android и iOS

### Командная строка

#### Android

```bash
# Mock flavor (по умолчанию)
flutter run --dart-define=FLAVOR=mock

# Production flavor
flutter run --dart-define=FLAVOR=prod

# С указанием flavor через --flavor (опционально)
flutter run --flavor mock --dart-define=FLAVOR=mock -t lib/main.dart
flutter run --flavor prod --dart-define=FLAVOR=prod -t lib/main.dart
```

#### iOS

```bash
# Mock flavor (по умолчанию)
flutter run --dart-define=FLAVOR=mock

# Production flavor
flutter run --dart-define=FLAVOR=prod

# С указанием flavor через --flavor (опционально)
flutter run --flavor mock --dart-define=FLAVOR=mock -t lib/main.dart
flutter run --flavor prod --dart-define=FLAVOR=prod -t lib/main.dart
```

### Сборка APK/IPA

```bash
# Android APK (mock)
flutter build apk --release --dart-define=FLAVOR=mock

# Android APK (prod)
flutter build apk --release --dart-define=FLAVOR=prod

# iOS IPA (mock)
flutter build ios --release --dart-define=FLAVOR=mock

# iOS IPA (prod)
flutter build ios --release --dart-define=FLAVOR=prod
```

## Настройка переменных окружения

### Использование AppConfigSimple

Текущая реализация использует `AppConfigSimple`, который не требует файлов `.env` и работает сразу из коробки. Flavor определяется через `--dart-define` или по умолчанию используется `mock`.

**Преимущества:**
- Работает сразу без дополнительной настройки
- Не требует генерации кода
- Простая конфигурация
- Легко переключаться между окружениями

**Недостатки:**
- Конфигурация хранится в коде (не в .env файлах)
- Менее гибкая для сложных сценариев

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

Провайдеры репозиториев автоматически выбирают между мок-репозиторием и реальным в зависимости от `config.useMocks`:

```dart
@riverpod
ProjectRepository projectRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockProjectRepository(ref); // Мок-репозиторий
  }
  return ProjectRepositoryImpl(...); // Реальный репозиторий
}
```

## Переключение между моками и реальным API

Flavor автоматически определяет, использовать ли моки:

- **mock** → `useMocks: true` (используются моки)
- **prod** → `useMocks: false` (используется реальный API)

Это позволяет:
- Быстро разрабатывать с моками в mock окружении
- Использовать реальный API в production

## CI/CD

В GitHub Actions по умолчанию собирается **mock** flavor:

```yaml
- name: Build APK (mock flavor)
  run: flutter build apk --release --dart-define=FLAVOR=mock
```

Для сборки production версии измените на:

```yaml
- name: Build APK (prod flavor)
  run: flutter build apk --release --dart-define=FLAVOR=prod
```

## Преимущества подхода

1. **Простота** - всего два flavor'а вместо трех
2. **Ясность** - mock для моков, prod для реальных данных
3. **Разделение окружений** - разные конфигурации для mock/prod
4. **Гибкость** - легко добавлять новые переменные окружения
5. **Простота использования** - один флаг для переключения между моками и API

## Рекомендации

- Для **разработки/тестирования**: используйте `mock` flavor с моками (конфигурация "Mock (с моками)" в VS Code)
- Для **production**: используйте `prod` flavor с реальным API (конфигурация "Production" в VS Code)
- Для **CI/CD**: по умолчанию собирается `mock` flavor для быстрого тестирования
