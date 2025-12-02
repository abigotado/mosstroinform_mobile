import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// Название приложения
  ///
  /// In ru, this message translates to:
  /// **'Стройконтроль Онлайн'**
  String get appTitle;

  /// Заголовок экрана списка проектов
  ///
  /// In ru, this message translates to:
  /// **'Объекты'**
  String get projectsTitle;

  /// Сообщение когда проектов нет
  ///
  /// In ru, this message translates to:
  /// **'Проекты не найдены'**
  String get projectsNotFound;

  /// Заголовок экрана деталей проекта
  ///
  /// In ru, this message translates to:
  /// **'Детали проекта'**
  String get projectDetails;

  /// Сообщение когда проект не найден
  ///
  /// In ru, this message translates to:
  /// **'Проект не найден'**
  String get projectNotFound;

  /// Кнопка отправки запроса на строительство
  ///
  /// In ru, this message translates to:
  /// **'Отправить запрос на строительство'**
  String get sendConstructionRequest;

  /// Сообщение об успешной отправке запроса
  ///
  /// In ru, this message translates to:
  /// **'Запрос на строительство успешно отправлен'**
  String get constructionRequestSent;

  /// Заголовок ошибки загрузки проектов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки проектов'**
  String get errorLoadingProjects;

  /// Кнопка повтора действия
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// Заголовок экрана согласования документов
  ///
  /// In ru, this message translates to:
  /// **'Согласование документов'**
  String get documentApprovalTitle;

  /// Сообщение когда документов нет
  ///
  /// In ru, this message translates to:
  /// **'Нет документов для согласования'**
  String get noDocumentsToApprove;

  /// Заголовок экрана документа
  ///
  /// In ru, this message translates to:
  /// **'Документ'**
  String get documentTitle;

  /// Сообщение когда документ не найден
  ///
  /// In ru, this message translates to:
  /// **'Документ не найден'**
  String get documentNotFound;

  /// Заголовок секции описания
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get description;

  /// Метка даты отправки
  ///
  /// In ru, this message translates to:
  /// **'Отправлен'**
  String get submitted;

  /// Метка даты одобрения
  ///
  /// In ru, this message translates to:
  /// **'Одобрен'**
  String get approved;

  /// Заголовок причины отклонения
  ///
  /// In ru, this message translates to:
  /// **'Причина отклонения'**
  String get rejectionReason;

  /// Кнопка скачивания документа
  ///
  /// In ru, this message translates to:
  /// **'Скачать документ'**
  String get downloadDocument;

  /// Кнопка отклонения документа
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get reject;

  /// Кнопка одобрения документа
  ///
  /// In ru, this message translates to:
  /// **'Одобрить'**
  String get approve;

  /// Заголовок диалога отклонения документа
  ///
  /// In ru, this message translates to:
  /// **'Отклонить документ'**
  String get rejectDocumentTitle;

  /// Подсказка для поля причины отклонения
  ///
  /// In ru, this message translates to:
  /// **'Укажите причину отклонения'**
  String get rejectReasonHint;

  /// Кнопка отмены
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// Сообщение об успешном одобрении документа
  ///
  /// In ru, this message translates to:
  /// **'Документ успешно одобрен'**
  String get documentApproved;

  /// Сообщение об отклонении документа
  ///
  /// In ru, this message translates to:
  /// **'Документ отклонён'**
  String get documentRejected;

  /// Заголовок ошибки
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// Заголовок ошибки загрузки документов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки документов'**
  String get errorLoadingDocuments;

  /// Заголовок ошибки загрузки документа
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки документа'**
  String get errorLoadingDocument;

  /// Сообщение о необходимости указать причину отклонения
  ///
  /// In ru, this message translates to:
  /// **'Укажите причину отклонения'**
  String get specifyRejectionReason;

  /// Сообщение об открытии файла
  ///
  /// In ru, this message translates to:
  /// **'Открыть файл: {url}'**
  String openFile(String url);

  /// Статус документа - ожидает
  ///
  /// In ru, this message translates to:
  /// **'Ожидает'**
  String get documentStatusPending;

  /// Статус документа - на рассмотрении
  ///
  /// In ru, this message translates to:
  /// **'На рассмотрении'**
  String get documentStatusUnderReview;

  /// Статус документа - одобрен
  ///
  /// In ru, this message translates to:
  /// **'Одобрен'**
  String get documentStatusApproved;

  /// Статус документа - отклонён
  ///
  /// In ru, this message translates to:
  /// **'Отклонён'**
  String get documentStatusRejected;

  /// Заголовок секции этапов строительства
  ///
  /// In ru, this message translates to:
  /// **'Этапы строительства'**
  String get constructionStages;

  /// Метка площади
  ///
  /// In ru, this message translates to:
  /// **'Площадь'**
  String get area;

  /// Метка этажности
  ///
  /// In ru, this message translates to:
  /// **'Этажность'**
  String get floors;

  /// Метка стоимости
  ///
  /// In ru, this message translates to:
  /// **'Стоимость'**
  String get price;

  /// Слово этаж
  ///
  /// In ru, this message translates to:
  /// **'этаж'**
  String get floor;

  /// Слово этажа (множественное)
  ///
  /// In ru, this message translates to:
  /// **'этажа'**
  String get floorsPlural;

  /// Заголовок экрана этапа строительства
  ///
  /// In ru, this message translates to:
  /// **'Этап строительства'**
  String get constructionStage;

  /// Заголовок списка камер
  ///
  /// In ru, this message translates to:
  /// **'Камеры'**
  String get cameras;

  /// Заголовок экрана камеры
  ///
  /// In ru, this message translates to:
  /// **'Камера'**
  String get camera;

  /// Сообщение когда камер нет
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных камер'**
  String get noCameras;

  /// Сообщение о неактивной камере
  ///
  /// In ru, this message translates to:
  /// **'Камера неактивна'**
  String get cameraNotActive;

  /// Заголовок ошибки загрузки стройки
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки информации о стройке'**
  String get errorLoadingConstructionSite;

  /// Заголовок ошибки загрузки камер
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки камер'**
  String get errorLoadingCameras;

  /// Метка прогресса строительства
  ///
  /// In ru, this message translates to:
  /// **'Прогресс'**
  String get progress;

  /// Метка даты начала
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get startDate;

  /// Метка ожидаемой даты завершения
  ///
  /// In ru, this message translates to:
  /// **'Ожидаемое завершение'**
  String get expectedCompletion;

  /// Статус камеры - активна
  ///
  /// In ru, this message translates to:
  /// **'Активна'**
  String get active;

  /// Статус камеры - неактивна
  ///
  /// In ru, this message translates to:
  /// **'Неактивна'**
  String get inactive;

  /// Заголовок экрана завершения строительства
  ///
  /// In ru, this message translates to:
  /// **'Завершение строительства'**
  String get constructionCompletion;

  /// Заголовок статуса завершения
  ///
  /// In ru, this message translates to:
  /// **'Статус завершения'**
  String get completionStatus;

  /// Заголовок списка финальных документов
  ///
  /// In ru, this message translates to:
  /// **'Финальные документы'**
  String get finalDocuments;

  /// Сообщение когда финальных документов нет
  ///
  /// In ru, this message translates to:
  /// **'Нет финальных документов'**
  String get noFinalDocuments;

  /// Заголовок экрана финального документа
  ///
  /// In ru, this message translates to:
  /// **'Финальный документ'**
  String get finalDocument;

  /// Сообщение когда финальный документ не найден
  ///
  /// In ru, this message translates to:
  /// **'Финальный документ не найден'**
  String get finalDocumentNotFound;

  /// Кнопка подписания документа
  ///
  /// In ru, this message translates to:
  /// **'Подписать документ'**
  String get signDocument;

  /// Сообщение об успешном подписании документа
  ///
  /// In ru, this message translates to:
  /// **'Документ успешно подписан'**
  String get documentSigned;

  /// Статус документа - подписан
  ///
  /// In ru, this message translates to:
  /// **'Подписан'**
  String get signed;

  /// Метка даты подписания
  ///
  /// In ru, this message translates to:
  /// **'Подписан'**
  String get signedAt;

  /// Сообщение что все документы подписаны
  ///
  /// In ru, this message translates to:
  /// **'Все документы подписаны'**
  String get allDocumentsSigned;

  /// Сообщение о завершении строительства
  ///
  /// In ru, this message translates to:
  /// **'Строительство завершено'**
  String get constructionCompleted;

  /// Заголовок ошибки загрузки статуса
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки статуса завершения'**
  String get errorLoadingCompletionStatus;

  /// Заголовок ошибки загрузки финальных документов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки финальных документов'**
  String get errorLoadingFinalDocuments;

  /// Заголовок ошибки загрузки финального документа
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки финального документа'**
  String get errorLoadingFinalDocument;

  /// Метка даты завершения строительства
  ///
  /// In ru, this message translates to:
  /// **'Дата завершения'**
  String get completionDate;

  /// Метка подписи
  ///
  /// In ru, this message translates to:
  /// **'Подпись'**
  String get signature;

  /// Заголовок списка чатов
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get chats;

  /// Заголовок экрана чата
  ///
  /// In ru, this message translates to:
  /// **'Чат'**
  String get chat;

  /// Сообщение когда чатов нет
  ///
  /// In ru, this message translates to:
  /// **'Нет чатов'**
  String get noChats;

  /// Сообщение когда сообщений нет
  ///
  /// In ru, this message translates to:
  /// **'Нет сообщений'**
  String get noMessages;

  /// Подсказка для поля ввода сообщения
  ///
  /// In ru, this message translates to:
  /// **'Введите сообщение...'**
  String get typeMessage;

  /// Кнопка отправки сообщения
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get send;

  /// Заголовок ошибки загрузки чатов
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки чатов'**
  String get errorLoadingChats;

  /// Заголовок ошибки загрузки сообщений
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки сообщений'**
  String get errorLoadingMessages;

  /// Заголовок ошибки отправки сообщения
  ///
  /// In ru, this message translates to:
  /// **'Ошибка отправки сообщения'**
  String get errorSendingMessage;

  /// Сообщение об успешной отправке
  ///
  /// In ru, this message translates to:
  /// **'Сообщение отправлено'**
  String get messageSent;

  /// Метка непрочитанных сообщений
  ///
  /// In ru, this message translates to:
  /// **'Непрочитано'**
  String get unread;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
