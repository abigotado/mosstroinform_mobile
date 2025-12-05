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

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Стройконтроль Онлайн'**
  String get appTitle;

  /// No description provided for @projectsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Проекты'**
  String get projectsTitle;

  /// No description provided for @projectsNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Проекты не найдены'**
  String get projectsNotFound;

  /// No description provided for @projectDetails.
  ///
  /// In ru, this message translates to:
  /// **'Детали проекта'**
  String get projectDetails;

  /// No description provided for @projectNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Проект не найден'**
  String get projectNotFound;

  /// No description provided for @sendConstructionRequest.
  ///
  /// In ru, this message translates to:
  /// **'Отправить запрос на строительство'**
  String get sendConstructionRequest;

  /// No description provided for @requestConstruction.
  ///
  /// In ru, this message translates to:
  /// **'Запрос строительства'**
  String get requestConstruction;

  /// No description provided for @constructionRequestSent.
  ///
  /// In ru, this message translates to:
  /// **'Запрос на строительство успешно отправлен'**
  String get constructionRequestSent;

  /// No description provided for @errorLoadingProjects.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки проектов'**
  String get errorLoadingProjects;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @documentApprovalTitle.
  ///
  /// In ru, this message translates to:
  /// **'Согласование документов'**
  String get documentApprovalTitle;

  /// No description provided for @noDocumentsToApprove.
  ///
  /// In ru, this message translates to:
  /// **'Нет документов для согласования'**
  String get noDocumentsToApprove;

  /// No description provided for @documentTitle.
  ///
  /// In ru, this message translates to:
  /// **'Документ'**
  String get documentTitle;

  /// No description provided for @documentNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Документ не найден'**
  String get documentNotFound;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get description;

  /// No description provided for @submitted.
  ///
  /// In ru, this message translates to:
  /// **'Отправлен'**
  String get submitted;

  /// No description provided for @approved.
  ///
  /// In ru, this message translates to:
  /// **'Одобрен'**
  String get approved;

  /// No description provided for @rejectionReason.
  ///
  /// In ru, this message translates to:
  /// **'Причина отклонения'**
  String get rejectionReason;

  /// No description provided for @downloadDocument.
  ///
  /// In ru, this message translates to:
  /// **'Скачать документ'**
  String get downloadDocument;

  /// No description provided for @reject.
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get reject;

  /// No description provided for @approve.
  ///
  /// In ru, this message translates to:
  /// **'Одобрить'**
  String get approve;

  /// No description provided for @rejectDocumentTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отклонить документ'**
  String get rejectDocumentTitle;

  /// No description provided for @rejectReasonHint.
  ///
  /// In ru, this message translates to:
  /// **'Укажите причину отклонения'**
  String get rejectReasonHint;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @documentApproved.
  ///
  /// In ru, this message translates to:
  /// **'Документ успешно одобрен'**
  String get documentApproved;

  /// No description provided for @documentRejected.
  ///
  /// In ru, this message translates to:
  /// **'Документ отклонён'**
  String get documentRejected;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get error;

  /// No description provided for @errorLoadingDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки документов'**
  String get errorLoadingDocuments;

  /// No description provided for @errorLoadingDocument.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки документа'**
  String get errorLoadingDocument;

  /// No description provided for @specifyRejectionReason.
  ///
  /// In ru, this message translates to:
  /// **'Укажите причину отклонения'**
  String get specifyRejectionReason;

  /// Сообщение об открытии файла
  ///
  /// In ru, this message translates to:
  /// **'Открыть файл: {url}'**
  String openFile(String url);

  /// No description provided for @documentStatusPending.
  ///
  /// In ru, this message translates to:
  /// **'Ожидает'**
  String get documentStatusPending;

  /// No description provided for @documentStatusUnderReview.
  ///
  /// In ru, this message translates to:
  /// **'На рассмотрении'**
  String get documentStatusUnderReview;

  /// No description provided for @documentStatusApproved.
  ///
  /// In ru, this message translates to:
  /// **'Одобрен'**
  String get documentStatusApproved;

  /// No description provided for @documentStatusRejected.
  ///
  /// In ru, this message translates to:
  /// **'Отклонён'**
  String get documentStatusRejected;

  /// No description provided for @constructionStages.
  ///
  /// In ru, this message translates to:
  /// **'Этапы строительства'**
  String get constructionStages;

  /// No description provided for @area.
  ///
  /// In ru, this message translates to:
  /// **'Площадь'**
  String get area;

  /// No description provided for @floorsLabel.
  ///
  /// In ru, this message translates to:
  /// **'Этажность'**
  String get floorsLabel;

  /// No description provided for @price.
  ///
  /// In ru, this message translates to:
  /// **'Стоимость'**
  String get price;

  /// Множественное число для этажей
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =1{этаж} few{этажа} many{этажей} other{этажей}}'**
  String floors(int count);

  /// Множественное число для спален
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =1{спальня} few{спальни} many{спален} other{спален}}'**
  String bedrooms(int count);

  /// Множественное число для ванных
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, =1{ванная} few{ванные} many{ванных} other{ванных}}'**
  String bathrooms(int count);

  /// No description provided for @million.
  ///
  /// In ru, this message translates to:
  /// **'млн'**
  String get million;

  /// No description provided for @thousand.
  ///
  /// In ru, this message translates to:
  /// **'тыс'**
  String get thousand;

  /// No description provided for @ruble.
  ///
  /// In ru, this message translates to:
  /// **'₽'**
  String get ruble;

  /// No description provided for @constructionStage.
  ///
  /// In ru, this message translates to:
  /// **'Этап строительства'**
  String get constructionStage;

  /// No description provided for @cameras.
  ///
  /// In ru, this message translates to:
  /// **'Камеры'**
  String get cameras;

  /// No description provided for @camera.
  ///
  /// In ru, this message translates to:
  /// **'Камера'**
  String get camera;

  /// No description provided for @noCameras.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных камер'**
  String get noCameras;

  /// No description provided for @cameraNotActive.
  ///
  /// In ru, this message translates to:
  /// **'Камера неактивна'**
  String get cameraNotActive;

  /// No description provided for @errorLoadingConstructionSite.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки информации о стройке'**
  String get errorLoadingConstructionSite;

  /// No description provided for @errorLoadingCameras.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки камер'**
  String get errorLoadingCameras;

  /// No description provided for @progress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс'**
  String get progress;

  /// No description provided for @startDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get startDate;

  /// No description provided for @expectedCompletion.
  ///
  /// In ru, this message translates to:
  /// **'Ожидаемое завершение'**
  String get expectedCompletion;

  /// No description provided for @active.
  ///
  /// In ru, this message translates to:
  /// **'Активна'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In ru, this message translates to:
  /// **'Неактивна'**
  String get inactive;

  /// No description provided for @constructionCompletion.
  ///
  /// In ru, this message translates to:
  /// **'Завершение строительства'**
  String get constructionCompletion;

  /// No description provided for @completionStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус завершения'**
  String get completionStatus;

  /// No description provided for @finalDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Финальные документы'**
  String get finalDocuments;

  /// No description provided for @noFinalDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Нет финальных документов'**
  String get noFinalDocuments;

  /// Количество подписанных документов из общего количества
  ///
  /// In ru, this message translates to:
  /// **'Подписано: {signed}/{total} документов'**
  String documentsSignedCount(int signed, int total);

  /// No description provided for @finalDocument.
  ///
  /// In ru, this message translates to:
  /// **'Финальный документ'**
  String get finalDocument;

  /// No description provided for @finalDocumentNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Финальный документ не найден'**
  String get finalDocumentNotFound;

  /// No description provided for @signDocument.
  ///
  /// In ru, this message translates to:
  /// **'Подписать документ'**
  String get signDocument;

  /// No description provided for @documentSigned.
  ///
  /// In ru, this message translates to:
  /// **'Документ успешно подписан'**
  String get documentSigned;

  /// No description provided for @signed.
  ///
  /// In ru, this message translates to:
  /// **'Подписан'**
  String get signed;

  /// No description provided for @signedAt.
  ///
  /// In ru, this message translates to:
  /// **'Подписан'**
  String get signedAt;

  /// No description provided for @allDocumentsSigned.
  ///
  /// In ru, this message translates to:
  /// **'Все документы подписаны'**
  String get allDocumentsSigned;

  /// No description provided for @constructionCompleted.
  ///
  /// In ru, this message translates to:
  /// **'Строительство завершено'**
  String get constructionCompleted;

  /// No description provided for @errorLoadingCompletionStatus.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки статуса завершения'**
  String get errorLoadingCompletionStatus;

  /// No description provided for @errorLoadingFinalDocuments.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки финальных документов'**
  String get errorLoadingFinalDocuments;

  /// No description provided for @errorLoadingFinalDocument.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки финального документа'**
  String get errorLoadingFinalDocument;

  /// No description provided for @completionDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата завершения'**
  String get completionDate;

  /// No description provided for @signature.
  ///
  /// In ru, this message translates to:
  /// **'Подпись'**
  String get signature;

  /// No description provided for @chats.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get chats;

  /// No description provided for @chat.
  ///
  /// In ru, this message translates to:
  /// **'Чат'**
  String get chat;

  /// No description provided for @noChats.
  ///
  /// In ru, this message translates to:
  /// **'Нет чатов'**
  String get noChats;

  /// No description provided for @noMessages.
  ///
  /// In ru, this message translates to:
  /// **'Нет сообщений'**
  String get noMessages;

  /// No description provided for @typeMessage.
  ///
  /// In ru, this message translates to:
  /// **'Введите сообщение...'**
  String get typeMessage;

  /// No description provided for @send.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get send;

  /// No description provided for @errorLoadingChats.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки чатов'**
  String get errorLoadingChats;

  /// No description provided for @errorLoadingMessages.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки сообщений'**
  String get errorLoadingMessages;

  /// No description provided for @chatNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Чат для этого объекта не найден'**
  String get chatNotFound;

  /// No description provided for @errorSendingMessage.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка отправки сообщения'**
  String get errorSendingMessage;

  /// No description provided for @messageSent.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение отправлено'**
  String get messageSent;

  /// No description provided for @unread.
  ///
  /// In ru, this message translates to:
  /// **'Непрочитано'**
  String get unread;

  /// No description provided for @yes.
  ///
  /// In ru, this message translates to:
  /// **'Да'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ru, this message translates to:
  /// **'Нет'**
  String get no;

  /// No description provided for @documentStatus.
  ///
  /// In ru, this message translates to:
  /// **'Статус документа'**
  String get documentStatus;

  /// Сообщение об ошибке открытия файла
  ///
  /// In ru, this message translates to:
  /// **'Ошибка открытия файла: {url}'**
  String errorOpeningFile(String url);

  /// No description provided for @errorLoadingSignature.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки подписи'**
  String get errorLoadingSignature;

  /// No description provided for @loadingVideoStream.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка видеопотока...'**
  String get loadingVideoStream;

  /// No description provided for @errorLoadingVideoStream.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки видеопотока'**
  String get errorLoadingVideoStream;

  /// No description provided for @toConstruction.
  ///
  /// In ru, this message translates to:
  /// **'К стройке'**
  String get toConstruction;

  /// No description provided for @toDocuments.
  ///
  /// In ru, this message translates to:
  /// **'К документам'**
  String get toDocuments;

  /// No description provided for @completionTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Завершение строительства'**
  String get completionTooltip;

  /// No description provided for @chatTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Чат со специалистом'**
  String get chatTooltip;

  /// No description provided for @completed.
  ///
  /// In ru, this message translates to:
  /// **'Завершён'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In ru, this message translates to:
  /// **'В процессе'**
  String get inProgress;

  /// No description provided for @waiting.
  ///
  /// In ru, this message translates to:
  /// **'Ожидает'**
  String get waiting;

  /// No description provided for @constructionStagesLabel.
  ///
  /// In ru, this message translates to:
  /// **'Этапы строительства:'**
  String get constructionStagesLabel;

  /// No description provided for @buffering.
  ///
  /// In ru, this message translates to:
  /// **'Буферизация...'**
  String get buffering;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход в систему'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In ru, this message translates to:
  /// **'Нет аккаунта? Зарегистрироваться'**
  String get noAccount;

  /// No description provided for @registerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get registerTitle;

  /// No description provided for @nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get nameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In ru, this message translates to:
  /// **'Телефон (необязательно)'**
  String get phoneLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get registerButton;

  /// No description provided for @hasAccount.
  ///
  /// In ru, this message translates to:
  /// **'Уже есть аккаунт? Войти'**
  String get hasAccount;

  /// No description provided for @enterEmail.
  ///
  /// In ru, this message translates to:
  /// **'Введите email'**
  String get enterEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In ru, this message translates to:
  /// **'Введите корректный email'**
  String get enterValidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get enterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум 6 символов'**
  String get passwordMinLength;

  /// No description provided for @enterName.
  ///
  /// In ru, this message translates to:
  /// **'Введите имя'**
  String get enterName;

  /// No description provided for @confirmPassword.
  ///
  /// In ru, this message translates to:
  /// **'Подтвердите пароль'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают'**
  String get passwordsDoNotMatch;

  /// Сообщение об ошибке
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка: {error}'**
  String errorOccurred(String error);

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выход'**
  String get logout;

  /// No description provided for @logoutTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из системы'**
  String get logoutTooltip;

  /// No description provided for @requestedProjectsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Запрошенные проекты'**
  String get requestedProjectsTitle;

  /// No description provided for @requested.
  ///
  /// In ru, this message translates to:
  /// **'Запрошен'**
  String get requested;

  /// No description provided for @underConstruction.
  ///
  /// In ru, this message translates to:
  /// **'Строительство'**
  String get underConstruction;

  /// No description provided for @myObjectsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мои объекты'**
  String get myObjectsTitle;

  /// No description provided for @profileTitle.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profileTitle;

  /// No description provided for @searchProjects.
  ///
  /// In ru, this message translates to:
  /// **'Поиск проектов'**
  String get searchProjects;

  /// No description provided for @searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Введите название или адрес'**
  String get searchHint;

  /// No description provided for @noRequestedProjects.
  ///
  /// In ru, this message translates to:
  /// **'Нет запрошенных проектов'**
  String get noRequestedProjects;

  /// No description provided for @noMyObjects.
  ///
  /// In ru, this message translates to:
  /// **'У вас пока нет объектов'**
  String get noMyObjects;

  /// No description provided for @constructionProgress.
  ///
  /// In ru, this message translates to:
  /// **'Прогресс строительства'**
  String get constructionProgress;

  /// No description provided for @stagesCompleted.
  ///
  /// In ru, this message translates to:
  /// **'этапов завершено'**
  String get stagesCompleted;

  /// No description provided for @startConstruction.
  ///
  /// In ru, this message translates to:
  /// **'Начать'**
  String get startConstruction;

  /// No description provided for @constructionAddressTitle.
  ///
  /// In ru, this message translates to:
  /// **'Адрес строительства'**
  String get constructionAddressTitle;

  /// No description provided for @enterConstructionAddress.
  ///
  /// In ru, this message translates to:
  /// **'Введите адрес строительства'**
  String get enterConstructionAddress;

  /// No description provided for @constructionStarted.
  ///
  /// In ru, this message translates to:
  /// **'Строительство начато!'**
  String get constructionStarted;

  /// No description provided for @completeConstruction.
  ///
  /// In ru, this message translates to:
  /// **'Завершить строительство'**
  String get completeConstruction;

  /// No description provided for @constructionCompletedSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Строительство успешно завершено!'**
  String get constructionCompletedSuccess;

  /// No description provided for @networkError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сети. Проверьте подключение к интернету'**
  String get networkError;

  /// No description provided for @serverError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сервера'**
  String get serverError;

  /// No description provided for @cacheError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сохранения данных'**
  String get cacheError;
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
