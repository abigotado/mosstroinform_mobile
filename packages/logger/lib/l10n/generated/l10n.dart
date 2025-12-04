import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of LoggerL10n
/// returned by `LoggerL10n.of(context)`.
///
/// Applications need to include `LoggerL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: LoggerL10n.localizationsDelegates,
///   supportedLocales: LoggerL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the LoggerL10n.supportedLocales
/// property.
abstract class LoggerL10n {
  LoggerL10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static LoggerL10n of(BuildContext context) {
    return Localizations.of<LoggerL10n>(context, LoggerL10n)!;
  }

  static const LocalizationsDelegate<LoggerL10n> delegate =
      _LoggerL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @devConsoleDebugInfo.
  ///
  /// In en, this message translates to:
  /// **'Debug Info'**
  String get devConsoleDebugInfo;

  /// No description provided for @devConsoleDebugInfoAppBuildNumber.
  ///
  /// In en, this message translates to:
  /// **'App Build Number'**
  String get devConsoleDebugInfoAppBuildNumber;

  /// No description provided for @devConsoleDebugInfoAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get devConsoleDebugInfoAppVersion;

  /// No description provided for @devConsoleDebugInfoDeviceModel.
  ///
  /// In en, this message translates to:
  /// **'Device Model'**
  String get devConsoleDebugInfoDeviceModel;

  /// No description provided for @devConsoleDebugInfoDeviceOS.
  ///
  /// In en, this message translates to:
  /// **'Device OS'**
  String get devConsoleDebugInfoDeviceOS;

  /// No description provided for @devConsoleDebugInfoFlavor.
  ///
  /// In en, this message translates to:
  /// **'Flavor'**
  String get devConsoleDebugInfoFlavor;

  /// No description provided for @devConsoleDebugInfoNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get devConsoleDebugInfoNoData;

  /// No description provided for @devConsoleLogsFullMode.
  ///
  /// In en, this message translates to:
  /// **'Console logs full mode'**
  String get devConsoleLogsFullMode;

  /// No description provided for @devConsoleOpenConsole.
  ///
  /// In en, this message translates to:
  /// **'Open logger console'**
  String get devConsoleOpenConsole;

  /// No description provided for @devConsoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Dev Console'**
  String get devConsoleTitle;
}

class _LoggerL10nDelegate extends LocalizationsDelegate<LoggerL10n> {
  const _LoggerL10nDelegate();

  @override
  Future<LoggerL10n> load(Locale locale) {
    return SynchronousFuture<LoggerL10n>(lookupLoggerL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_LoggerL10nDelegate old) => false;
}

LoggerL10n lookupLoggerL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return LoggerL10nEn();
    case 'ru':
      return LoggerL10nRu();
  }

  throw FlutterError(
    'LoggerL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
