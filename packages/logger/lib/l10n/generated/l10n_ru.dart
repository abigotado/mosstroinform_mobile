// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LoggerL10nRu extends LoggerL10n {
  LoggerL10nRu([String locale = 'ru']) : super(locale);

  @override
  String get devConsoleDebugInfo => 'Информация для отладки';

  @override
  String get devConsoleDebugInfoAppBuildNumber => 'Номер сборки приложения';

  @override
  String get devConsoleDebugInfoAppVersion => 'Версия приложения';

  @override
  String get devConsoleDebugInfoDeviceModel => 'Модель устройства';

  @override
  String get devConsoleDebugInfoDeviceOS => 'Операционная система устройства';

  @override
  String get devConsoleDebugInfoFlavor => 'Флавр';

  @override
  String get devConsoleDebugInfoNoData => 'Нет данных';

  @override
  String get devConsoleLogsFullMode => 'Полный режим консоли';

  @override
  String get devConsoleOpenConsole => 'Открыть консоль разработчика';

  @override
  String get devConsoleTitle => 'Консоль разработчика';
}
