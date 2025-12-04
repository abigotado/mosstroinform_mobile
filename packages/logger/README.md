# Logger

Logging toolkit built on top of Talker, Sentry, and Riverpod. It provides
consistent logging APIs, Riverpod observers, Dio interceptors, and a developer console that can be accessed
from anywhere in the app.

## Highlights

- Centralized `AppLogger` facade for structured logging at multiple levels.
- Sentry observers, Dio interceptors, and Riverpod observers wired in out of the box.
- Developer console UI with localized strings and debug button overlay.
- `LogErrorMixin` to simplify error reporting from feature modules.
- Full integration with go_router for navigation.

## Requirements

- Flutter with Dart >= 3.9.0 (matches package SDK constraint).
- Build runner toolchain for generating Riverpod providers.
- `flutter_riverpod` and `riverpod_annotation` for state management.

## Getting Started

1. **Add the package** to your `pubspec.yaml` (path or git depending on your setup) and run
   `flutter pub get`.
2. **Generate Riverpod providers** whenever notifiers change:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Init AppLogger** before using the logger, typically before running runApp() function:

   ```dart
   import 'package:logger/logger.dart';
   import 'package:flutter/foundation.dart' show kDebugMode;

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     
     await AppLogger.init(showLogs: kDebugMode);
     
     runApp(MyApp());
   }
   ```

4. **Add Riverpod observer** to ProviderScope:

   ```dart
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'package:logger/logger.dart';

   runApp(
     ProviderScope(
       observers: [AppLogger.riverpodObserver],
       child: MyApp(),
     ),
   );
   ```

5. **Add Dev Console route** to your go_router:

   ```dart
   import 'package:logger/logger.dart';
   import 'package:logger/src/presentation/ui/navigation/dev_console_page.dart';

   GoRoute(
     path: '/dev-console',
     builder: (context, state) => const DevConsolePage(),
   ),
   ```

6. **Add localization delegate** to MaterialApp:

   ```dart
   import 'package:logger/l10n/generated/l10n.dart';

   MaterialApp(
     localizationsDelegates: const [
       // ... other delegates
       LoggerL10n.delegate,
     ],
     // ...
   );
   ```

## Usage Tips

### Logging

```dart
import 'package:logger/logger.dart';

// Basic logging
AppLogger.log('Info message');
AppLogger.log('Debug message', level: LogLevel.debug);
AppLogger.log('Warning message', level: LogLevel.warning);

// Error logging
AppLogger.logError(error, stackTrace: stackTrace, reason: 'Error description');
AppLogger.error('Error message', error, stackTrace); // Convenience method
```

### Dio Interceptor

Add Dio logger interceptor to your Dio instance:

```dart
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final dio = Dio()
  ..interceptors.add(AppLogger.dioLogger);
```

### Riverpod Observer

The Riverpod observer is automatically added when you include `AppLogger.riverpodObserver` in your `ProviderScope.observers`. It logs all provider lifecycle events (add, update, dispose, errors).

### Dev Console

The Dev Console provides an interactive interface for viewing logs, errors, and debug information:

- **Access:** Click the debug button in the top-right corner (debug mode only) or call `AppLogger.openConsole(context)`
- **Features:**
  - View all application logs (debug, info, warning, error)
  - Filter logs by level
  - View detailed error information and stack traces
  - App information (version, build number, flavor, device)
  - Toggle between compact and full log output modes

### LogErrorMixin

Use `LogErrorMixin` in your classes to get helper methods for consistently formatted logs:

```dart
import 'package:logger/src/mixin/log_error_mixin.dart';

class MyNotifier with LogErrorMixin {
  @override
  String get className => 'MyNotifier';

  void doSomething() {
    try {
      // ... some code
    } catch (e, s) {
      logError(e, stackTrace: s, methodName: 'doSomething');
    }
  }
}
```

### Output Modes

Toggle between compact and full output modes:

```dart
AppLogger.setOutputMode(AppLoggerOutputMode.full); // Full mode with headers
AppLogger.setOutputMode(AppLoggerOutputMode.compact); // Compact mode (default)
```

For additional details explore the `lib/src` folder, especially `app_logger.dart`, the notifiers under `src/presentation/notifier`, and the UI widgets.
