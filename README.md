# МосСтройИнформ Мобайл

Мобильное приложение для управления строительством объектов ИЖС (Индивидуальное Жилищное Строительство).

## 📱 О приложении

Приложение позволяет пользователям:

- **Авторизоваться и регистрироваться** в системе
- Просматривать доступные проекты строительства
- Отправлять запросы на начало строительства
- Согласовывать необходимые документы
- Наблюдать за ходом строительства через видеопотоки с камер
- Общаться со специалистами в чате
- Отслеживать статус завершения строительства и подписывать финальные документы

## 🖥 Поддерживаемые платформы

Приложение разработано на Flutter и поддерживает следующие платформы:

### 📱 Мобильные платформы

- **Android** - основная мобильная платформа
  - Минимальная версия: Android 5.0 (API 21)
  - Рекомендуется: Android 8.0 (API 26) и выше
  - Поддержка всех архитектур: ARM, ARM64, x86, x86_64

- **iOS** - поддержка устройств Apple
  - Минимальная версия: iOS 12.0
  - Рекомендуется: iOS 14.0 и выше
  - Поддержка iPhone и iPad

### 💻 Desktop платформы

- **Linux** - нативные приложения для Linux
  - Поддержка GTK3
  - Требуется: libgtk-3-dev, libsecret-1-dev и другие зависимости
  - Подробнее в [BUILD_GUIDE.md](xdocs/BUILD_GUIDE.md#linux)

- **Windows** - нативные приложения для Windows
  - Поддержка Windows 10 и выше
  - Автоматическая сборка через GitHub Actions
  - Подробнее в [BUILD_GUIDE.md](xdocs/BUILD_GUIDE.md#windows)

- **macOS** - нативные приложения для macOS
  - Поддержка macOS 10.14 и выше
  - Поддержка flavors (mock/prod)
  - Подробнее в [BUILD_GUIDE.md](xdocs/BUILD_GUIDE.md#macos)

### 🌐 Web платформа

- **Web** - веб-приложение
  - Поддержка современных браузеров (Chrome, Firefox, Safari, Edge)
  - Автоматический деплой на GitHub Pages
  - Подробнее в [BUILD_GUIDE.md](xdocs/BUILD_GUIDE.md#веб-web)

> **Примечание:** Хотя основное внимание уделено мобильным платформам (Android/iOS), приложение полностью функционально на всех поддерживаемых платформах, включая desktop и web.

## 🔐 Авторизация

Приложение требует авторизации для доступа к функциям. Все страницы защищены и требуют входа в систему.

### Тестовые учетные данные (Mock окружение)

При использовании flavor `mock` доступны следующие тестовые учетные записи:

**Обычный пользователь:**

- Email: `test@example.com`
- Пароль: `password123`
- Имя: Тестовый Пользователь

**Администратор:**

- Email: `admin@example.com`
- Пароль: `admin123`
- Имя: Администратор

> **Примечание:** Эти учетные данные работают только в mock окружении. В production используются реальные учетные данные с бэкенда.

### Регистрация

Вы также можете зарегистрировать новый аккаунт через экран регистрации. В mock окружении регистрация создает новую учетную запись в памяти приложения (данные сохраняются до перезапуска приложения).

## 📥 Скачать и установить

### Быстрая установка (без разработки)

Если вы просто хотите установить и использовать приложение без разработки:

#### Android (APK)

1. **Скачайте APK:**
   - Перейдите на страницу [Releases](https://github.com/MosStroiInform/mosstroinform_mobile/releases/latest)
   - Скачайте файл `app-prod-release.apk` или `app-mock-release.apk` из последнего релиза

2. **Установите APK на Android устройство:**
   - На вашем Android устройстве перейдите в **Настройки → Безопасность**
   - Включите опцию **"Разрешить установку из неизвестных источников"** или **"Установка неизвестных приложений"**
   - Откройте скачанный APK файл на устройстве
   - Нажмите **"Установить"**
   - После установки нажмите **"Открыть"**

#### Desktop платформы (Linux, Windows, macOS)

1. **Скачайте сборку для вашей платформы:**
   - Перейдите на страницу [Releases](https://github.com/MosStroiInform/mosstroinform_mobile/releases/latest)
   - Скачайте архив для вашей платформы:
     - `linux-prod-release` - для Linux
     - `windows-prod-release` - для Windows
     - `macos-mock-release` или `macos-prod-release` - для macOS

2. **Установите приложение:**
   - **Linux:** Распакуйте архив и запустите исполняемый файл
   - **Windows:** Распакуйте архив и запустите `.exe` файл
   - **macOS:** Распакуйте архив и переместите `.app` в папку Applications

#### Web версия

Веб-версия доступна на GitHub Pages: [https://mosstroiinform.github.io/mosstroinform_mobile/](https://mosstroiinform.github.io/mosstroinform_mobile/)

> **Примечание:** Все сборки автоматически создаются при каждом обновлении ветки `main`. Все сборки проходят тесты и проверки качества кода. Подробнее о сборке для каждой платформы см. в [BUILD_GUIDE.md](xdocs/BUILD_GUIDE.md).

## 🚀 Быстрый старт (для разработчиков)

### Для тех, кто никогда не работал с Flutter

Если вы впервые работаете с Flutter и мобильной разработкой, следуйте этим шагам:

#### Шаг 1: Установка Flutter

1. **Скачайте Flutter SDK:**
   - Перейдите на [flutter.dev](https://flutter.dev/docs/get-started/install)
   - Выберите вашу операционную систему (Windows, macOS, Linux)
   - Скачайте и распакуйте архив Flutter SDK

2. **Добавьте Flutter в PATH:**
   - **macOS/Linux:** Добавьте путь к Flutter в файл `~/.zshrc` или `~/.bashrc`:

     ```bash
     export PATH="$PATH:[путь_к_flutter]/bin"
     ```

   - **Windows:** Добавьте путь к Flutter в переменные окружения PATH

3. **Проверьте установку:**

   ```bash
   flutter doctor
   ```

   Эта команда покажет, что нужно установить дополнительно (Android Studio, Xcode для iOS и т.д.)

4. **Установите недостающие компоненты:**
   - **Для Android:** Установите Android Studio и Android SDK
   - **Для iOS (только macOS):** Установите Xcode из App Store
   - Следуйте инструкциям `flutter doctor` для установки недостающих компонентов

#### Шаг 2: Настройка IDE

Рекомендуется использовать **VS Code** или **Android Studio**:

- **VS Code:** Установите расширение "Flutter" из маркетплейса расширений
- **Android Studio:** Установите плагин Flutter через Settings → Plugins

#### Шаг 3: Клонирование проекта

```bash
git clone https://github.com/MosStroiInform/mosstroinform_mobile.git
cd mosstroinform_mobile
```

#### Шаг 4: Установка зависимостей

```bash
flutter pub get
```

#### Шаг 5: Генерация кода

Проект использует code generation для моделей данных и провайдеров:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Шаг 6: Запуск приложения

**Для Android:**

```bash
flutter run
```

Убедитесь, что у вас запущен эмулятор Android или подключено устройство.

**Для iOS (только macOS):**

```bash
flutter run
```

Убедитесь, что у вас запущен симулятор iOS или подключено устройство.

**Для Desktop платформ (Linux, Windows, macOS):**

```bash
# Linux
flutter run -d linux

# Windows
flutter run -d windows

# macOS
flutter run -d macos
```

Для desktop платформ эмулятор не требуется - приложение запускается напрямую на вашем компьютере.

**Для Web:**

```bash
flutter run -d chrome
```

Приложение откроется в браузере Chrome.

## 📋 Требования

### Минимальные требования

- **Flutter SDK:** версия 3.10.0 или выше
- **Dart SDK:** версия 3.10.0 или выше (входит в Flutter)
- **Операционная система:**
  - macOS 10.14 или выше (для iOS и macOS разработки)
  - Windows 10 или выше (для Windows разработки)
  - Linux (Ubuntu 18.04 или выше, для Linux разработки)

### Для разработки под Android

- Android Studio или Android SDK
- Android SDK Platform 33 или выше
- Android Emulator или физическое устройство с включенной отладкой по USB

### Для разработки под iOS (только macOS)

- Xcode 14.0 или выше
- CocoaPods (устанавливается автоматически при первом запуске)
- iOS Simulator или физическое устройство

### Для разработки под Linux

- Linux (Ubuntu 18.04 или выше, или другой дистрибутив с поддержкой GTK3)
- Системные зависимости:
  ```bash
  sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev libsecret-1-dev libcurl4-openssl-dev libmpv-dev
  ```

### Для разработки под Windows

- Windows 10 или выше
- Visual Studio 2022 или выше с компонентами:
  - Desktop development with C++
  - Windows 10/11 SDK
- CMake (обычно устанавливается с Visual Studio)

### Для разработки под macOS (desktop)

- macOS 10.14 или выше
- Xcode 14.0 или выше
- CocoaPods (устанавливается автоматически)

### Для разработки под Web

- Современный браузер (Chrome, Firefox, Safari, Edge)
- Flutter Web поддержка (включена по умолчанию)

## 🛠 Установка и настройка

### Детальная инструкция по установке

#### 1. Проверка системы

Выполните команду для проверки готовности системы:

```bash
flutter doctor -v
```

Убедитесь, что все необходимые компоненты установлены и настроены.

#### 2. Настройка проекта

После клонирования проекта выполните:

```bash
# Перейдите в директорию проекта
cd mosstroinform_mobile

# Установите зависимости
flutter pub get

# Сгенерируйте код (модели, провайдеры)
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 3. Настройка эмулятора/симулятора

**Android:**

1. Откройте Android Studio
2. Tools → Device Manager
3. Create Device → выберите устройство (например, Pixel 5)
4. Запустите эмулятор

**iOS (macOS):**

1. Откройте Xcode
2. Xcode → Open Developer Tool → Simulator
3. File → New Simulator → выберите устройство (например, iPhone 14)

## 🎮 Запуск приложения

### Режим разработки (Development)

Приложение по умолчанию запускается в режиме разработки с использованием моковых данных:

```bash
flutter run
```

Или с указанием устройства:

```bash
# Список доступных устройств
flutter devices

# Запуск на конкретном устройстве
flutter run -d <device_id>
```

### Режимы запуска (Flavors)

Проект поддерживает два окружения через flavors:

- **mock** (по умолчанию) - режим с моками для разработки и тестирования
- **prod** - production окружение с реальными данными

Запуск с указанием flavor:

```bash
flutter run --dart-define=FLAVOR=mock  # С моками (по умолчанию)
flutter run --dart-define=FLAVOR=prod   # Production
```

Подробнее о flavors см. [FLAVORS_GUIDE.md](./xdocs/FLAVORS_GUIDE.md)

## 📦 Сборка приложения

### Android

#### Debug сборка (для тестирования)

```bash
flutter build apk --debug
```

APK файл будет находиться в `build/app/outputs/flutter-apk/app-debug.apk`

#### Release сборка (для публикации)

```bash
flutter build apk --release
```

APK файл будет находиться в `build/app/outputs/flutter-apk/app-release.apk`

#### App Bundle (для Google Play)

```bash
flutter build appbundle --release
```

AAB файл будет находиться в `build/app/outputs/bundle/release/app-release.aab`

### iOS (только macOS)

#### Debug сборка

```bash
flutter build ios --debug
```

#### Release сборка

```bash
flutter build ios --release
```

Для установки на устройство или публикации в App Store используйте Xcode:

1. Откройте `ios/Runner.xcworkspace` в Xcode
2. Выберите устройство или "Any iOS Device"
3. Product → Archive
4. Следуйте инструкциям для публикации

Подробные инструкции по сборке см. [BUILD_GUIDE.md](./xdocs/BUILD_GUIDE.md)

## 🧪 Тестирование

Проект имеет полное тестовое покрытие ключевых компонентов приложения. Всего **76 тестов**, покрывающих notifiers, repositories, use cases и UI виджеты.

### Структура тестов

Тесты организованы по той же структуре, что и основной код:

```log
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

Тестируют логику управления состоянием через Riverpod:

- `ProjectsNotifier` - управление списком проектов
- `ProjectNotifier` - управление отдельным проектом
- `DocumentsNotifier` - управление списком документов
- `DocumentNotifier` - управление отдельным документом
- `ChatsNotifier` - управление списком чатов
- `MessagesNotifier` - управление сообщениями в чате
- `ConstructionSiteNotifier` - управление стройплощадкой
- `CamerasNotifier` - управление камерами

**Пример:**

```dart
test('loadProjects успешно загружает проекты', () async {
  when(() => mockRepository.getProjects())
      .thenAnswer((_) async => projects);
  
  final notifier = container.read(projectsNotifierProvider.notifier);
  await notifier.loadProjects();
  
  final state = container.read(projectsNotifierProvider);
  expect(state.value?.projects, equals(projects));
});
```

#### 2. Unit тесты для Repositories

Тестируют mock реализации репозиториев:

- `MockProjectRepository` - тесты для работы с проектами
- `MockDocumentRepository` - тесты для работы с документами

**Пример:**

```dart
test('getProjects возвращает список проектов из состояния', () async {
  final projects = await repository.getProjects();
  expect(projects, isNotEmpty);
  expect(projects.first, isA<Project>());
});
```

#### 3. Unit тесты для Use Cases

Тестируют бизнес-логику в use cases:

- `GetProjects`, `GetProjectById`, `RequestConstruction`
- `GetDocuments`, `GetDocumentById`, `ApproveDocument`, `RejectDocument`

**Пример:**

```dart
test('call возвращает список проектов', () async {
  when(() => mockRepository.getProjects())
      .thenAnswer((_) async => projects);
  
  final result = await useCase.call();
  expect(result, equals(projects));
});
```

#### 4. Widget тесты

Тестируют UI компоненты:

- `ProjectCard` - карточка проекта
- `DocumentCard` - карточка документа
- `ProjectStageItem` - элемент этапа строительства
- `CameraGridItem` - элемент камеры в сетке

**Пример:**

```dart
testWidgets('отображает проект с корректными данными', (tester) async {
  await tester.pumpWidget(createWidget(project));
  
  expect(find.text('Проект 1'), findsOneWidget);
  expect(find.text('Описание 1'), findsOneWidget);
});
```

### Запуск тестов

#### Запуск всех тестов

```bash
flutter test
```

#### Запуск конкретного файла тестов

```bash
flutter test test/features/project_selection/notifier/project_notifier_test.dart
```

#### Запуск тестов с покрытием

```bash
flutter test --coverage
```

Покрытие будет в `coverage/lcov.info`. Для просмотра используйте инструменты вроде `lcov` или `genhtml`.

#### Запуск тестов в watch режиме

```bash
flutter test --watch
```

Тесты будут автоматически перезапускаться при изменении файлов.

### Используемые библиотеки для тестирования

- **flutter_test** - базовый фреймворк для тестирования Flutter приложений
- **mocktail** - библиотека для создания моков (альтернатива mockito)
- **flutter_riverpod** - для тестирования Riverpod провайдеров

### Покрытие тестами

**Текущее покрытие:**

- ✅ Notifiers: 8 файлов тестов
- ✅ Mock Repositories: 2 файла тестов
- ✅ Use Cases: 7 файлов тестов
- ✅ Widgets: 4 файла тестов
- ✅ Базовый тест приложения: 1 файл

**Всего: 18 файлов тестов, 76 тестов**

### Написание новых тестов

При добавлении новой функциональности рекомендуется:

1. **Для notifiers:** Создать тесты в `test/features/[feature]/notifier/`
2. **Для repositories:** Создать тесты в `test/features/[feature]/data/repositories/`
3. **Для use cases:** Создать тесты в `test/features/[feature]/domain/usecases/`
4. **Для widgets:** Создать тесты в `test/features/[feature]/ui/widgets/`

**Шаблон теста для notifier:**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements SomeRepository {}

void main() {
  late ProviderContainer container;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    container = ProviderContainer(
      overrides: [
        someRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('test description', () async {
    // Arrange
    // Act
    // Assert
  });
}
```

**Шаблон теста для widget:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createWidget(SomeData data) {
  return MaterialApp(
    home: Scaffold(
      body: SomeWidget(data: data),
    ),
  );
}

void main() {
  testWidgets('widget description', (WidgetTester tester) async {
    // Arrange
    final data = SomeData();
    
    // Act
    await tester.pumpWidget(createWidget(data));
    await tester.pumpAndSettle();
    
    // Assert
    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```

### CI/CD

Проект использует GitHub Actions для автоматизации сборки и тестирования. Workflow разделен на три джобы:

1. **test** - запуск тестов, анализ кода и проверка форматирования
2. **build** - сборка APK (запускается только после успешного прохождения тестов)
3. **release** - создание GitHub Release с APK (только при push в `master`)

**Конфигурация:**

- Flutter 3.24.0
- Java 21 (требуется для текущей версии Flutter)
- Автоматический запуск при push и pull request в `master`

**Workflow файл:** `.github/workflows/build_apk.yml`

При каждом push в `master`:

- ✅ Запускаются все тесты (76 тестов)
- ✅ Выполняется анализ кода (`flutter analyze`)
- ✅ Проверяется форматирование (`dart format`)
- ✅ Собирается release APK
- ✅ Создается GitHub Release с APK для скачивания

Все сборки проходят проверки качества кода перед публикацией.

## 📚 Технологический стек

- **Flutter** - кроссплатформенный фреймворк для разработки мобильных приложений
- **Riverpod** (с code generation) - управление состоянием приложения
- **Dio + Retrofit** - библиотеки для работы с HTTP запросами и REST API
- **Freezed** - генерация кода для неизменяемых моделей данных
- **GoRouter** - навигация между экранами с поддержкой StatefulShellRoute для bottom navigation
- **Hive** - локальное хранилище данных для моков и настроек
- **flutter_localizations** - локализация приложения
- **video_player** - воспроизведение видеопотоков
- **shimmer** - эффекты загрузки (skeleton screens)

## 🏗 Архитектура

Проект использует **Domain-Driven Design (DDD)** с feature-first структурой.

### Структура проекта

```log
lib/
├── core/                    # Общие компоненты
│   ├── theme/              # Темизация
│   ├── config/             # Конфигурация приложения
│   ├── network/            # Сетевой слой
│   ├── constants/          # Константы
│   ├── utils/              # Утилиты (логгер и др.)
│   ├── widgets/            # Переиспользуемые виджеты (shimmer и др.)
│   └── errors/             # Обработка ошибок
├── features/               # Фичи (feature-first)
│   ├── project_selection/  # Выбор проекта
│   ├── document_approval/  # Согласование документации
│   ├── construction_stage/ # Этап строительства
│   ├── chat/               # Чат со специалистом
│   └── construction_completion/ # Завершение строительства
│       ├── data/           # Слой данных
│       │   ├── models/     # Модели данных (DTO)
│       │   ├── repositories/ # Реализация репозиториев
│       │   ├── datasources/ # Источники данных (Retrofit)
│       │   └── providers/  # Провайдеры data source
│       ├── domain/         # Слой домена
│       │   ├── entities/   # Сущности домена
│       │   ├── repositories/ # Интерфейсы репозиториев
│       │   ├── providers/  # Провайдеры репозиториев
│       │   └── usecases/   # Use cases (бизнес-логика)
│       ├── notifier/       # State management (Riverpod)
│       └── ui/             # UI слой
│           ├── screens/    # Экраны
│           └── widgets/     # Виджеты фичи
└── l10n/                   # Локализация
    └── app_ru.arb          # Русские строки
```

### Слои архитектуры

Каждая фича содержит следующие слои:

1. **Domain Layer** - бизнес-логика, сущности, интерфейсы репозиториев, провайдеры репозиториев, use cases
2. **Data Layer** - реализация репозиториев, модели данных, источники данных (Retrofit), провайдеры data source
3. **Notifier Layer** - управление состоянием через Riverpod с code generation
4. **UI Layer** - экраны и виджеты фичи

Подробнее об архитектуре см. [ARCHITECTURE.md](./xdocs/ARCHITECTURE.md)

## 🎯 Основные функции

1. **Авторизация и регистрация** - вход в систему, регистрация новых пользователей, безопасное хранение токенов
2. **Выбор проекта** - просмотр доступных проектов, детальная информация, отправка запроса на строительство
   - Проекты отображаются с параметрами (площадь, этажность, количество спален, ванных комнат, цена)
   - Статусы проектов: доступен, запрошен, строительство
   - Навигация между проектом и объектом строительства
3. **Согласование документации** - просмотр документов, процесс согласования, отслеживание статусов
4. **Этап строительства** - видеопоток со стройки, просмотр камер, управление видео
   - Навигация к проекту со страницы объекта
5. **Чат со специалистом** - общение с экспертами, отправка сообщений, история переписки
6. **Завершение строительства** - подписание документов, финальные документы, статус завершения

### Защита роутов и навигация

Все страницы приложения защищены авторизацией:

- Неавторизованные пользователи автоматически перенаправляются на экран входа
- После успешной авторизации пользователь перенаправляется на главную страницу
- Токены хранятся в безопасном хранилище (`flutter_secure_storage`)
- При выходе из системы токены удаляются и пользователь перенаправляется на экран входа
- Используется `refreshListenable` для автоматической обработки изменений авторизации
- Все маршруты вложены в `StatefulShellRoute` для сохранения bottom navigation при навигации
- Плавные fade-анимации переходов между экранами авторизации и главным экраном

## 🎨 Темы приложения

Приложение поддерживает светлую и темную темы с автоматическим определением из настроек устройства:

- **Светлая тема** - стандартная светлая тема Material Design 3
- **Темная тема** - темная тема с увеличенной контрастностью для лучшей читаемости
- **Системная тема** (по умолчанию) - автоматически следует настройкам устройства

Переключение темы доступно в экране профиля. Выбор пользователя сохраняется между сессиями.

## 🔧 Режим разработки и моки

Приложение поддерживает работу с моковыми данными для разработки и демонстрации без необходимости подключения к реальному API.

### Использование моков

По умолчанию приложение запускается с включенными моками (flavor `mock`). Моки:

- Имитируют работу реального API
- Хранят состояние в локальной базе данных Hive (сохраняется между сессиями)
- Автоматически очищаются при выходе из системы
- Позволяют тестировать весь функционал без бэкенда

Подробнее о моках см. [MOCK_DATA_GUIDE.md](./xdocs/MOCK_DATA_GUIDE.md)

## 🗺 Навигация по приложению

Приложение использует **GoRouter** для навигации с поддержкой:

- **StatefulShellRoute** для главного экрана с bottom navigation bar
- **Автоматические редиректы** при изменении состояния авторизации через `refreshListenable`
- **Плавные анимации переходов** (fade) между экранами авторизации и главным экраном
- **Защита роутов** - неавторизованные пользователи автоматически перенаправляются на экран входа

### Структура навигации

**Главный экран (StatefulShellRoute):**

- `/` - Список проектов
- `/requested` - Запрошенные проекты
- `/objects` - Мои объекты
- `/profile` - Профиль

**Экраны авторизации:**

- `/login` - Вход в систему
- `/register` - Регистрация

**Детальные экраны:**

- `/projects/:id` - Детали проекта
- `/documents` - Список документов
- `/documents/:id` - Детали документа
- `/construction/:objectId` - Страница объекта строительства
- `/construction/:projectId/chat` - Чат объекта
- `/completion/:projectId` - Статус завершения строительства
- `/completion/:projectId/documents/:documentId` - Детали финального документа
- `/chats` - Список чатов
- `/chats/:chatId` - Детали чата

### Пользовательский путь (User Journey)

1. **Список проектов** → Выбор проекта
2. **Детали проекта** → Отправка запроса на строительство
   - Проект получает статус "запрошен"
   - Появляется кнопка "К документам"
3. **Список документов** → Согласование документов
4. **Детали документа** → Одобрение/отклонение
5. **Детали проекта** → После подписания всех документов появляется кнопка "Начать строительство"
   - Ввод адреса строительства
   - Проект переходит в статус "строительство"
   - Создается объект строительства
6. **Этап строительства** → Просмотр видеопотоков с камер
   - Навигация обратно к проекту через кнопку в AppBar
7. **Чат со специалистом** → Общение с экспертами
8. **Завершение строительства** → Подписание финальных документов

## 🌐 Локализация

Все тексты приложения на русском языке. Файлы локализации находятся в `lib/l10n/`.

Для добавления новых строк:

1. Добавьте ключ в `lib/l10n/app_ru.arb`
2. Запустите `flutter pub get` для генерации локализации

## 🐛 Отладка

### Логирование

Приложение использует пакет `logger` для логирования, построенный на базе Talker и Sentry:

```dart
import 'package:logger/logger.dart';

AppLogger.log('Информационное сообщение');
AppLogger.log('Отладочное сообщение', level: LogLevel.debug);
AppLogger.logError(error, stackTrace: stackTrace, reason: 'Описание ошибки');
```

Логи отображаются только в debug режиме или при использовании моков.

#### Dev Console

В debug режиме в верхнем правом углу экрана доступна кнопка для открытия Dev Console - интерактивного интерфейса для просмотра логов, ошибок и отладочной информации.

**Возможности Dev Console:**

- Просмотр всех логов приложения (debug, info, warning, error)
- Фильтрация логов по уровню
- Просмотр детальной информации об ошибках и stack traces
- Информация о приложении (версия, build number, flavor, устройство)
- Переключение между компактным и полным режимом вывода логов

**Открытие Dev Console:**

- Нажмите на кнопку с иконкой бага в верхнем правом углу экрана (только в debug режиме)
- Или программно: `AppLogger.openConsole(context)`

Подробнее о logger пакете см. [packages/logger/README.md](./packages/logger/README.md)

### Hot Reload и Hot Restart

- **Hot Reload** (`r` в консоли): Быстрое обновление UI без перезапуска приложения
- **Hot Restart** (`R` в консоли): Перезапуск приложения с сохранением состояния

## 📝 Разработка

Проект следует принципам чистого кода:

- Не используются widget функции (только классы виджетов)
- Четкое разделение ответственности
- Использование интерфейсов для репозиториев
- Типобезопасность через Freezed

## 🔄 Работа с Git

- **main** - основная ветка (только для начального коммита)
- **stage** - рабочая ветка для разработки
- Для каждого шага создается feature-ветка от stage, после завершения - squash merge в stage

## 📖 Дополнительная документация

- [ARCHITECTURE.md](./xdocs/ARCHITECTURE.md) - подробное описание архитектуры проекта
- [QUICK_START.md](./xdocs/QUICK_START.md) - быстрый старт для новых разработчиков
- [BUILD_GUIDE.md](./xdocs/BUILD_GUIDE.md) - подробные инструкции по сборке приложения
- [FLAVORS_GUIDE.md](./xdocs/FLAVORS_GUIDE.md) - руководство по использованию flavors
- [MOCK_DATA_GUIDE.md](./xdocs/MOCK_DATA_GUIDE.md) - руководство по работе с моками

## ❓ Часто задаваемые вопросы

### Как запустить приложение в первый раз?

1. Установите Flutter SDK
2. Выполните `flutter pub get`
3. Выполните `flutter pub run build_runner build --delete-conflicting-outputs`
4. Запустите эмулятор/симулятор
5. Выполните `flutter run`

### Приложение не запускается, что делать?

1. Проверьте, что Flutter установлен: `flutter doctor`
2. Убедитесь, что зависимости установлены: `flutter pub get`
3. Проверьте, что код сгенерирован: `flutter pub run build_runner build --delete-conflicting-outputs`
4. Убедитесь, что устройство/эмулятор запущено: `flutter devices`

### Как собрать APK для Android?

```bash
flutter build apk --release
```

APK будет в `build/app/outputs/flutter-apk/app-release.apk`

### Как собрать приложение для iOS?

```bash
flutter build ios --release
```

Затем откройте `ios/Runner.xcworkspace` в Xcode и создайте архив через Product → Archive

### Где находятся моковые данные?

Моковые данные находятся в `lib/core/data/mock_data/` и управляются через Riverpod провайдеры в `lib/core/data/mock_data/mock_state_providers.dart`

## 📞 Поддержка

При возникновении проблем:

1. Проверьте раздел "Часто задаваемые вопросы"
2. Изучите документацию в папке проекта
3. Проверьте логи приложения через `AppLogger`

## 👥 Участники проекта

Проект разработан командой в рамках учебного проекта. Распределение работы:

### Разработчики

- **castlele** ([@castlele](https://github.com/castlele)) - <castlelecs@gmail.com>
  - Тестовое покрытие проекта (unit тесты для notifiers, repositories, use cases, widget тесты)
  - Документация по тестированию и архитектуре
  - Рефакторинг и улучшение структуры кода

- **Konkurent** ([@Konkurent](https://github.com/Konkurent)) - <kechin.d@gmail.com>
  - UI/UX компоненты (shimmer эффекты, система логирования)
  - Видеопотоки и оптимизация воспроизведения
  - Документация API эндпойнтов
  - Навигация и улучшения пользовательского опыта

- **NikBakly** ([@NikBakly](https://github.com/NikBakly)) - <baklykov.nikita369@gmail.com>
  - Работа с документами и объектами строительства
  - Интерактивные моки с состоянием
  - Интеграция видеоплеера и навигации
  - Логика завершения строительства

### Тимлид

- **Nikita Kovalenko** ([@abigotado](https://github.com/abigotado)) - <nik.koval.89@gmail.com>
  - Архитектура проекта (DDD, feature-first структура)
  - Основная функциональность приложения и интеграция модулей
  - Навигация (GoRouter, StatefulShellRoute, анимации переходов)
  - Авторизация и защита роутов
  - CI/CD и автоматизация сборки
  - Координация работы команды

## 📄 Лицензия

Проект создан в рамках учебного проекта.
