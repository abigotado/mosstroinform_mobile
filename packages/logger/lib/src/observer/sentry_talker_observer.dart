import 'package:talker_flutter/talker_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryTalkerObserver extends TalkerObserver {
  SentryTalkerObserver({this.filter, this.levelMapper, this.captureErrors = true});

  final SentryFilter? filter;
  final LevelMapper? levelMapper;
  final bool captureErrors;

  @override
  void onLog(TalkerData log) {
    if (filter?.call(log) == false) {
      return;
    }

    if (captureErrors) {
      Sentry.captureException(
        log.error,
        stackTrace: log.stackTrace,
        hint: Hint.withMap({'logMessage': log.message, 'title': log.title}), // Доп. контекст
      );
      return;
    }

    Sentry.addBreadcrumb(
      Breadcrumb(
        message: log.generateTextMessage(),
        level: levelMapper?.call(log.logLevel ?? LogLevel.info) ?? SentryLevel.debug,
      ),
    );
  }
}

typedef SentryFilter = bool Function(TalkerData log);
typedef LevelMapper = SentryLevel Function(LogLevel level);

SentryLevel defaultSentryLevelMapper(LogLevel level) {
  switch (level) {
    case LogLevel.critical:
      return SentryLevel.fatal;
    case LogLevel.error:
      return SentryLevel.error;
    case LogLevel.warning:
      return SentryLevel.warning;
    case LogLevel.info:
      return SentryLevel.info;
    default:
      return SentryLevel.debug;
  }
}
