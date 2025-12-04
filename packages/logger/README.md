# Logger

Logging toolkit built on top of Talker, Sentry, and GetIt/Injectable. It provides
consistent logging APIs, route/bloc observers, and a developer console overlay that can be toggled
at runtime.

## Highlights

- Centralized `AppLogger` facade for structured logging at multiple levels.
- Sentry observers, Dio interceptors, and Bloc/Route observers wired in out of the box.
- Developer console UI with localized strings and optional draggable overlay trigger.
- `LogErrorMixin` to simplify error reporting from feature modules.

## Requirements

- Flutter with Dart >= 3.9.0 (matches package SDK constraint).
- Build runner toolchain for generating injectable configuration.

## Getting Started

1. **Add the package** to your `pubspec.yaml` (path or git depending on your setup) and run
   `flutter pub get`.
2. **Generate dependency injection code** whenever models change:

   ```bash
   dart run build_runner build -d
   ```

3. **Init AppLogger** before using the logger, typically before running runApp() function:

   ```dart
   import '../../lib/logger.dart';

   Future<void> bootstrap() async {
     await AppLogger.init(showLogs: kDebugMode || EnvironmentUtil.flavor != AppFlavor.prod));
   }
   ```

## Usage Tips

- Attach Talker helpers where needed:

  ```dart
  Bloc.observer = AppLogger.blocObserver;
  final dio = Dio()..interceptors.add(AppLogger.dioLogger);
  ```

- Toggle detailed request output via `AppLogger.setOutputMode(AppLoggerOutputMode.full);`.
- Display the developer console overlay in debug builds:

  ```dart
  if (AppLogger.showDebugFeatures) const DebugLoggerOverlay();
  ```

- When using the developer console, include the `DevConsoleL10n.delegate` in your
  `localizationsDelegates` (and optionally merge `supportedLocales`).
- Open the console from anywhere with `AppLogger.openConsole(context);`.
- Mix `LogErrorMixin` into classes to get helper methods for consistently formatted logs.
- Open the console from anywhere with `AppLogger.openConsole(context);`.
- Mix `LogErrorMixin` into classes to get helper methods for consistently formatted logs.

For additional details explore the `lib/src` folder, especially `app_logger.dart`, the DI module
under `src/di`, and the presentation widgets.
