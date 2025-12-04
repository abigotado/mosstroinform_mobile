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

## 📥 Скачать и установить APK

### Быстрая установка (без разработки)

Если вы просто хотите установить и использовать приложение без разработки:

1. **Скачайте APK:**
   - Перейдите на страницу [Releases](https://github.com/abigotado/mosstroinform_mobile/releases/latest)
   - Скачайте файл `app-release.apk` из последнего релиза

2. **Установите APK на Android устройство:**
   - На вашем Android устройстве перейдите в **Настройки → Безопасность**
   - Включите опцию **"Разрешить установку из неизвестных источников"** или **"Установка неизвестных приложений"**
   - Откройте скачанный APK файл на устройстве
   - Нажмите **"Установить"**
   - После установки нажмите **"Открыть"**

3. **Готово!** Приложение готово к использованию.

> **Примечание:** APK автоматически собирается при каждом обновлении ветки `master`. Все сборки проходят тесты и проверки качества кода.

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
git clone https://github.com/abigotado/mosstroinform_mobile.git
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

## 📋 Требования

### Минимальные требования

- **Flutter SDK:** версия 3.10.0 или выше
- **Dart SDK:** версия 3.10.0 или выше (входит в Flutter)
- **Операционная система:**
  - macOS 10.14 или выше (для iOS разработки)
  - Windows 10 или выше
  - Linux (Ubuntu 18.04 или выше)

### Для разработки под Android

- Android Studio или Android SDK
- Android SDK Platform 33 или выше
- Android Emulator или физическое устройство с включенной отладкой по USB

### Для разработки под iOS (только macOS)

- Xcode 14.0 или выше
- CocoaPods (устанавливается автоматически при первом запуске)
- iOS Simulator или физическое устройство

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

Подробнее о flavors см. [FLAVORS_GUIDE.md](./FLAVORS_GUIDE.md)

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

Подробные инструкции по сборке см. [BUILD_GUIDE.md](./BUILD_GUIDE.md)

## 🧪 Тестирование

Проект имеет полное тестовое покрытие ключевых компонентов приложения. Всего **76 тестов**, покрывающих notifiers, repositories, use cases и UI виджеты.

### Структура тестов

Тесты организованы по той же структуре, что и основной код:

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
- **GoRouter** - навигация между экранами
- **flutter_localizations** - локализация приложения
- **video_player** - воспроизведение видеопотоков
- **shimmer** - эффекты загрузки (skeleton screens)

## 🏗 Архитектура

Проект использует **Domain-Driven Design (DDD)** с feature-first структурой.

### Структура проекта

```
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

Подробнее об архитектуре см. [ARCHITECTURE.md](./ARCHITECTURE.md)

## 🎯 Основные функции

1. **Авторизация и регистрация** - вход в систему, регистрация новых пользователей, безопасное хранение токенов
2. **Выбор проекта** - просмотр доступных проектов, детальная информация, отправка запроса на строительство
3. **Согласование документации** - просмотр документов, процесс согласования, отслеживание статусов
4. **Этап строительства** - видеопоток со стройки, просмотр камер, управление видео
5. **Чат со специалистом** - общение с экспертами, отправка сообщений, история переписки
6. **Завершение строительства** - подписание документов, финальные документы, статус завершения

### Защита роутов

Все страницы приложения защищены авторизацией:
- Неавторизованные пользователи автоматически перенаправляются на экран входа
- После успешной авторизации пользователь перенаправляется на главную страницу
- Токены хранятся в безопасном хранилище (`flutter_secure_storage`)
- При выходе из системы токены удаляются и пользователь перенаправляется на экран входа

## 🔧 Режим разработки и моки

Приложение поддерживает работу с моковыми данными для разработки и демонстрации без необходимости подключения к реальному API.

### Использование моков

По умолчанию приложение запускается с включенными моками (flavor `mock`). Моки:
- Имитируют работу реального API
- Хранят состояние в памяти (сбрасывается при перезапуске)
- Позволяют тестировать весь функционал без бэкенда

Подробнее о моках см. [MOCK_DATA_GUIDE.md](./MOCK_DATA_GUIDE.md)

## 🗺 Навигация по приложению

Пользовательский путь (User Journey):

1. **Список проектов** → Выбор проекта
2. **Детали проекта** → Отправка запроса на строительство
3. **Список документов** → Согласование документов
4. **Детали документа** → Одобрение/отклонение
5. **Этап строительства** → Просмотр видеопотоков с камер
6. **Чат со специалистом** → Общение с экспертами
7. **Завершение строительства** → Подписание финальных документов

## 🌐 Локализация

Все тексты приложения на русском языке. Файлы локализации находятся в `lib/l10n/`.

Для добавления новых строк:
1. Добавьте ключ в `lib/l10n/app_ru.arb`
2. Запустите `flutter pub get` для генерации локализации

## 🐛 Отладка

### Логирование

Приложение использует `AppLogger` для логирования:

```dart
import 'package:mosstroinform_mobile/core/utils/logger.dart';

AppLogger.debug('Отладочное сообщение');
AppLogger.info('Информационное сообщение');
AppLogger.warning('Предупреждение', error);
AppLogger.error('Ошибка', error, stackTrace);
```

Логи отображаются только в debug режиме.

### Hot Reload и Hot Restart

- **Hot Reload** (`r` в консоли): Быстрое обновление UI без перезапуска приложения
- **Hot Restart** (`R` в консоли): Перезапуск приложения с сохранением состояния

## 📝 Разработка

Проект следует принципам чистого кода:
- Не используются widget функции (только классы виджетов)
- Четкое разделение ответственности
- Использование интерфейсов для репозиториев
- Типобезопасность через Freezed

Подробнее о правилах архитектуры см. [ARCHITECTURE_RULES.md](./ARCHITECTURE_RULES.md)

## 🔄 Работа с Git

- **main** - основная ветка (только для начального коммита)
- **stage** - рабочая ветка для разработки
- Для каждого шага создается feature-ветка от stage, после завершения - squash merge в stage

## 📖 Дополнительная документация

- [ARCHITECTURE.md](./ARCHITECTURE.md) - подробное описание архитектуры проекта
- [ARCHITECTURE_RULES.md](./ARCHITECTURE_RULES.md) - правила архитектуры и разработки
- [BUILD_GUIDE.md](./BUILD_GUIDE.md) - подробные инструкции по сборке приложения
- [FLAVORS_GUIDE.md](./FLAVORS_GUIDE.md) - руководство по использованию flavors
- [MOCK_DATA_GUIDE.md](./MOCK_DATA_GUIDE.md) - руководство по работе с моками

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

- **castlele** ([@castlele](https://github.com/castlele)) - castlelecs@gmail.com (15 коммитов)
  - Полное тестовое покрытие проекта (76 тестов)
  - Unit тесты для notifiers, repositories, use cases
  - Widget тесты для UI компонентов
  - Документация по тестированию и архитектуре
  - Рефакторинг виджет-функций в классы виджетов
  - Документация структуры проекта (ARCHITECTURE.md, README.md)

- **Konkurent** ([@Konkurent](https://github.com/Konkurent)) - kechin.d@gmail.com (15 коммитов)
  - Реализация shimmer эффектов для всех экранов загрузки
  - Создание системы логирования (AppLogger)
  - Улучшение навигации между экранами (постоянные кнопки в AppBar)
  - Оптимизация видеопотока (удаление контролов для live потоков, остановка при выходе)
  - Настройки платформ для потокового видео (Android Manifest, iOS Info.plist)
  - Добавление демо-видеопотоков для демонстрации

- **NikBakly** ([@NikBakly](https://github.com/NikBakly)) - baklykov.nikita369@gmail.com (15 коммитов)
  - Исправление ошибок UI (CardTheme)
  - Работа с документами (одобрение отклоненных документов, projectId в Document entity)
  - Исправления в document_remote_data_source
  - Реализация интерактивных моков с состоянием через Riverpod
  - Навигация к стройке после одобрения всех документов
  - Исправления локализации и навигации
  - Добавление видеоплеера и навигации между этапами

### Тимлид

- **Nikita Kovalenko** ([@abigotado](https://github.com/abigotado)) - nik.koval.89@gmail.com (21 коммит)
  - Архитектура проекта (DDD, feature-first)
  - Основная функциональность приложения
  - Интеграция всех модулей
  - Координация работы команды

## 📄 Лицензия

Проект создан в рамках учебного проекта.
