// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LoggerL10nEn extends LoggerL10n {
  LoggerL10nEn([String locale = 'en']) : super(locale);

  @override
  String get devConsoleDebugInfo => 'Debug Info';

  @override
  String get devConsoleDebugInfoAppBuildNumber => 'App Build Number';

  @override
  String get devConsoleDebugInfoAppVersion => 'App Version';

  @override
  String get devConsoleDebugInfoDeviceModel => 'Device Model';

  @override
  String get devConsoleDebugInfoDeviceOS => 'Device OS';

  @override
  String get devConsoleDebugInfoFlavor => 'Flavor';

  @override
  String get devConsoleDebugInfoNoData => 'No data';

  @override
  String get devConsoleLogsFullMode => 'Console logs full mode';

  @override
  String get devConsoleOpenConsole => 'Open logger console';

  @override
  String get devConsoleTitle => 'Dev Console';
}
