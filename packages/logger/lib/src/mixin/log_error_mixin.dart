import 'package:logger/logger.dart';

mixin LogErrorMixin {
  String get className;

  void logError(Object error, {StackTrace? stackTrace, String? methodName}) => AppLogger.logError(
    error,
    stackTrace: stackTrace,
    reason: getLocationInfo(methodName: methodName),
  );

  void logLocated(String message, {String? methodName, LogLevel level = LogLevel.info}) =>
      AppLogger.log('${getLocationInfo(methodName: methodName)}: $message', level: level);

  void log(
    String message, {
    LogLevel level = LogLevel.info,
    Map<String, dynamic>? data,
    StackTrace? stackTrace,
    String? reason,
  }) => AppLogger.log(message, level: level, data: data, stackTrace: stackTrace, reason: reason);

  String getLocationInfo({String? methodName}) =>
      'Source: $className${switch (methodName != null) {
        true => '.$methodName',
        false => '',
      }}';

  @override
  String toString() => className;
}
