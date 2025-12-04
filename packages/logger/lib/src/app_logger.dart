// ignore_for_file: comment_references

import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:logger/src/observer/sentry_talker_observer.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:logger/src/observer/talker_riverpod_observer.dart';
import 'package:logger/src/domain/domain.dart';

/// The AppLogger class is a singleton that provides a way to log messages to the console.
/// It uses the Talker library to log messages and supports both compact and full output modes.
/// It also supports Sentry observer.
/// It also supports the ability to open the console.
/// It also supports the ability to set the output mode.
/// It also supports the ability to log errors.
/// It also supports the ability to log messages.
/// It also supports the ability to log warnings.
/// It also supports the ability to log verbose messages.
/// It also supports the ability to log critical messages.
class AppLogger {
  AppLogger._internal();

  static final AppLogger _instance = AppLogger._internal();

  late final Talker _talker;

  bool _isInitialized = false;
  AppLoggerOutputMode _outputMode = AppLoggerOutputMode.compact;
  final Set<TalkerDioLogger> _registeredDioLoggers = <TalkerDioLogger>{};
  TalkerDioLoggerSettings _dioLoggerSettings = _compactDioSettings;

  /// The Talker instance.
  static Talker get talker {
    if (!_instance._isInitialized) {
      throw Exception('AppLogger not initialized. Call AppLogger.init() first.');
    }
    return _instance._talker;
  }

  /// The TalkerRouteObserver instance.
  /// It is used to log routes to the console.
  static TalkerRouteObserver get routeObserver => TalkerRouteObserver(talker);

  /// The TalkerRiverpodObserver instance.
  /// It is used to log Riverpod providers to the console.
  static TalkerRiverpodObserver get riverpodObserver => TalkerRiverpodObserver(talker);

  /// The TalkerDioLogger instance.
  /// It is used to log dio requests to the console.
  static TalkerDioLogger get dioLogger {
    final logger = TalkerDioLogger(talker: talker, settings: _instance._dioLoggerSettings);
    _instance._registeredDioLoggers.add(logger);
    return logger;
  }

  /// The output mode for the logger.
  ///
  /// [compact] will print only the message and the data.
  /// [full] will print the request and response headers and data.
  static AppLoggerOutputMode get outputMode => _instance._outputMode;

  /// The settings for the dio logger.
  ///
  /// [compact] will print only the message and the data.
  /// [full] will print the request and response headers and data.
  static TalkerDioLoggerSettings get dioLoggerSettings => _instance._dioLoggerSettings;

  /// The flag to show debug features.
  ///
  /// [true] will show debug features.
  /// [false] will not show debug features.
  static bool get showDebugFeatures => _showDebugFeatures;

  static bool _showDebugFeatures = false;

  /// The method to open the console.
  /// Uses go_router for navigation
  static void openConsole(BuildContext context) {
    if (!_instance._isInitialized) {
      return;
    }

    // Используем go_router для навигации
    final router = GoRouter.of(context);
    router.push('/dev-console');
  }

  /// The method to initialize the logger.
  static Future<void> init({required final bool showLogs}) async {
    _showDebugFeatures = showLogs;

    if (_instance._isInitialized) {
      if (showDebugFeatures) {
        debugPrint('AppLogger already initialized.');
      }
      return;
    }

    if (showDebugFeatures) {
      debugPrint('Initializing AppLogger...');
    }

    _instance._talker = TalkerFlutter.init(
      settings: TalkerSettings(useConsoleLogs: showDebugFeatures),
      logger: TalkerLogger(output: _defaultFlutterOutput),
    );

    try {
      _instance._talker
        ..configure(
          observer: SentryTalkerObserver(filter: _sentryFilter, captureErrors: !kDebugMode),
        )
        ..info('Talker configured with Sentry and Crashlytics observers.');
    } catch (e, st) {
      talker.error('Failed to configure Talker observers', e, st);
    }

    _instance._isInitialized = true;
    talker.info('AppLogger initialization complete.');

    _applyOutputMode(_instance._outputMode);
  }

  /// The default method to log a message.
  ///
  /// [message] is the message to log.
  /// [level] is the level of the message.
  /// [data] is the data to log.
  /// [stackTrace] is the stack trace to log.
  /// [reason] is the reason to log.
  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    Map<String, dynamic>? data,
    StackTrace? stackTrace,
    String? reason,
  }) {
    if (!_instance._isInitialized) {
      debugPrint('[AppLogger] Not initialized: $message');
      return;
    }
    final additional = data != null ? {'data': data} : null;
    return switch (level) {
      LogLevel.debug => _instance._talker.debug(message, additional),
      LogLevel.info => _instance._talker.info(message, additional),
      LogLevel.warning => _instance._talker.warning(message, additional),
      LogLevel.verbose => _instance._talker.verbose(message, additional),
      LogLevel.error => logError(message, stackTrace: stackTrace, reason: reason, level: level),
      LogLevel.critical => logError(message, stackTrace: stackTrace, reason: reason, level: level),
    };
  }

  /// Convenience methods for backward compatibility
  static void info(String message, [Map<String, dynamic>? data]) {
    log(message, level: LogLevel.info, data: data);
  }

  static void debug(String message, [Map<String, dynamic>? data]) {
    log(message, level: LogLevel.debug, data: data);
  }

  static void warning(String message, [Map<String, dynamic>? data]) {
    log(message, level: LogLevel.warning, data: data);
  }

  /// The method to log an error.
  ///
  /// [error] is the error to log.
  /// [stackTrace] is the stack trace to log.
  /// [reason] is the reason to log.
  /// [level] is the level of the message.
  static void logError(
    dynamic error, {
    StackTrace? stackTrace,
    String? reason,
    LogLevel level = LogLevel.error,
  }) {
    if (!_instance._isInitialized) {
      debugPrint('[AppLogger] Not initialized: Error: $error, Reason: $reason');
      return;
    }
    return switch (level) {
      LogLevel.warning => _instance._talker.warning(reason, error, stackTrace),
      LogLevel.critical => _instance._talker.critical(reason, error, stackTrace),
      _ => _instance._talker.error(reason, error, stackTrace),
    };
  }

  /// Convenience method for backward compatibility
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    logError(error ?? message, stackTrace: stackTrace, reason: message);
  }

  /// The method to set the output mode.
  ///
  /// [mode] is the output mode to set.
  static void setOutputMode(AppLoggerOutputMode mode) {
    if (_instance._outputMode == mode) {
      return;
    }

    _instance._outputMode = mode;
    _applyOutputMode(mode);
  }

  /// Default output function for Flutter:
  /// - On web, prints to console.
  /// - On iOS/macOS, uses `dart:developer.log`.
  /// - On other platforms, uses `debugPrint`.
  static void _defaultFlutterOutput(String message) {
    if (kIsWeb) {
      // ignore: avoid_print
      if (kDebugMode) {
        print(message);
      }
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        if (kDebugMode) {
          developer.log(message, name: 'Talker');
        }
      default:
        if (kDebugMode) {
          debugPrint(message);
        }
    }
  }

  static void _applyOutputMode(AppLoggerOutputMode mode) {
    _instance._dioLoggerSettings = switch (mode) {
      AppLoggerOutputMode.compact => _compactDioSettings,
      AppLoggerOutputMode.full => _fullDioSettings,
    };

    for (final logger in _instance._registeredDioLoggers) {
      logger.settings = _instance._dioLoggerSettings;
    }

    if (_instance._isInitialized && kDebugMode) {
      _instance._talker.debug('Logger output mode switched to ${mode.name}');
    }
  }

  static const TalkerDioLoggerSettings _compactDioSettings = TalkerDioLoggerSettings(
    printResponseData: false,
    printErrorHeaders: false,
    printErrorData: false,
  );

  static const TalkerDioLoggerSettings _fullDioSettings = TalkerDioLoggerSettings(
    printRequestHeaders: true,
    printResponseHeaders: true,
  );

  /// The method to filter the sentry logs.
  ///
  /// [log] is the log to filter.
  /// [return] is true if the log should be filtered, false otherwise.
  /// Sentry only logs warnings and errors in debug mode.
  static bool _sentryFilter(TalkerData log) {
    if (!kDebugMode) {
      return true;
    }

    final level = log.logLevel ?? LogLevel.info;
    return level.index >= LogLevel.warning.index;
  }
}
