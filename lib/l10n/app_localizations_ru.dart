// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Стройконтроль Онлайн';

  @override
  String get projectsTitle => 'Проекты';

  @override
  String get projectsNotFound => 'Проекты не найдены';

  @override
  String get projectDetails => 'Детали проекта';

  @override
  String get projectNotFound => 'Проект не найден';

  @override
  String get sendConstructionRequest => 'Отправить запрос на строительство';

  @override
  String get requestConstruction => 'Запрос строительства';

  @override
  String get constructionRequestSent =>
      'Запрос на строительство успешно отправлен';

  @override
  String get errorLoadingProjects => 'Ошибка загрузки проектов';

  @override
  String get retry => 'Повторить';

  @override
  String get documentApprovalTitle => 'Согласование документов';

  @override
  String get noDocumentsToApprove => 'Нет документов для согласования';

  @override
  String get documentTitle => 'Документ';

  @override
  String get documentNotFound => 'Документ не найден';

  @override
  String get description => 'Описание';

  @override
  String get submitted => 'Отправлен';

  @override
  String get approved => 'Одобрен';

  @override
  String get rejectionReason => 'Причина отклонения';

  @override
  String get downloadDocument => 'Скачать документ';

  @override
  String get reject => 'Отклонить';

  @override
  String get approve => 'Одобрить';

  @override
  String get rejectDocumentTitle => 'Отклонить документ';

  @override
  String get rejectReasonHint => 'Укажите причину отклонения';

  @override
  String get cancel => 'Отмена';

  @override
  String get documentApproved => 'Документ успешно одобрен';

  @override
  String get documentRejected => 'Документ отклонён';

  @override
  String get error => 'Ошибка';

  @override
  String get errorLoadingDocuments => 'Ошибка загрузки документов';

  @override
  String get errorLoadingDocument => 'Ошибка загрузки документа';

  @override
  String get specifyRejectionReason => 'Укажите причину отклонения';

  @override
  String openFile(String url) {
    return 'Открыть файл: $url';
  }

  @override
  String get documentStatusPending => 'Ожидает';

  @override
  String get documentStatusUnderReview => 'На рассмотрении';

  @override
  String get documentStatusApproved => 'Одобрен';

  @override
  String get documentStatusRejected => 'Отклонён';

  @override
  String get constructionStages => 'Этапы строительства';

  @override
  String get area => 'Площадь';

  @override
  String get floorsLabel => 'Этажность';

  @override
  String get price => 'Стоимость';

  @override
  String floors(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'этажей',
      many: 'этажей',
      few: 'этажа',
      one: 'этаж',
    );
    return '$_temp0';
  }

  @override
  String bedrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'спален',
      many: 'спален',
      few: 'спальни',
      one: 'спальня',
    );
    return '$_temp0';
  }

  @override
  String bathrooms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ванных',
      many: 'ванных',
      few: 'ванные',
      one: 'ванная',
    );
    return '$_temp0';
  }

  @override
  String get million => 'млн';

  @override
  String get thousand => 'тыс';

  @override
  String get ruble => '₽';

  @override
  String get constructionStage => 'Этап строительства';

  @override
  String get cameras => 'Камеры';

  @override
  String get camera => 'Камера';

  @override
  String get noCameras => 'Нет доступных камер';

  @override
  String get cameraNotActive => 'Камера неактивна';

  @override
  String get errorLoadingConstructionSite =>
      'Ошибка загрузки информации о стройке';

  @override
  String get errorLoadingCameras => 'Ошибка загрузки камер';

  @override
  String get progress => 'Прогресс';

  @override
  String get startDate => 'Дата начала';

  @override
  String get expectedCompletion => 'Ожидаемое завершение';

  @override
  String get active => 'Активна';

  @override
  String get inactive => 'Неактивна';

  @override
  String get constructionCompletion => 'Завершение строительства';

  @override
  String get completionStatus => 'Статус завершения';

  @override
  String get finalDocuments => 'Финальные документы';

  @override
  String get noFinalDocuments => 'Нет финальных документов';

  @override
  String documentsSignedCount(int signed, int total) {
    return 'Подписано: $signed/$total документов';
  }

  @override
  String get finalDocument => 'Финальный документ';

  @override
  String get finalDocumentNotFound => 'Финальный документ не найден';

  @override
  String get signDocument => 'Подписать документ';

  @override
  String get documentSigned => 'Документ успешно подписан';

  @override
  String get signed => 'Подписан';

  @override
  String get signedAt => 'Подписан';

  @override
  String get allDocumentsSigned => 'Все документы подписаны';

  @override
  String get constructionCompleted => 'Строительство завершено';

  @override
  String get errorLoadingCompletionStatus =>
      'Ошибка загрузки статуса завершения';

  @override
  String get errorLoadingFinalDocuments =>
      'Ошибка загрузки финальных документов';

  @override
  String get errorLoadingFinalDocument =>
      'Ошибка загрузки финального документа';

  @override
  String get completionDate => 'Дата завершения';

  @override
  String get signature => 'Подпись';

  @override
  String get chats => 'Чаты';

  @override
  String get chat => 'Чат';

  @override
  String get noChats => 'Нет чатов';

  @override
  String get noMessages => 'Нет сообщений';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get send => 'Отправить';

  @override
  String get errorLoadingChats => 'Ошибка загрузки чатов';

  @override
  String get errorLoadingMessages => 'Ошибка загрузки сообщений';

  @override
  String get chatNotFound => 'Чат для этого объекта не найден';

  @override
  String get errorSendingMessage => 'Ошибка отправки сообщения';

  @override
  String get messageSent => 'Сообщение отправлено';

  @override
  String get unread => 'Непрочитано';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get documentStatus => 'Статус документа';

  @override
  String errorOpeningFile(String url) {
    return 'Ошибка открытия файла: $url';
  }

  @override
  String get errorLoadingSignature => 'Ошибка загрузки подписи';

  @override
  String get loadingVideoStream => 'Загрузка видеопотока...';

  @override
  String get errorLoadingVideoStream => 'Ошибка загрузки видеопотока';

  @override
  String get toConstruction => 'К стройке';

  @override
  String get toDocuments => 'К документам';

  @override
  String get completionTooltip => 'Завершение строительства';

  @override
  String get chatTooltip => 'Чат со специалистом';

  @override
  String get completed => 'Завершён';

  @override
  String get inProgress => 'В процессе';

  @override
  String get waiting => 'Ожидает';

  @override
  String get constructionStagesLabel => 'Этапы строительства:';

  @override
  String get buffering => 'Буферизация...';

  @override
  String get loginTitle => 'Вход в систему';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get noAccount => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get nameLabel => 'Имя';

  @override
  String get phoneLabel => 'Телефон (необязательно)';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get hasAccount => 'Уже есть аккаунт? Войти';

  @override
  String get enterEmail => 'Введите email';

  @override
  String get enterValidEmail => 'Введите корректный email';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get passwordMinLength => 'Пароль должен содержать минимум 6 символов';

  @override
  String get enterName => 'Введите имя';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String errorOccurred(String error) {
    return 'Произошла ошибка: $error';
  }

  @override
  String get logout => 'Выход';

  @override
  String get logoutTooltip => 'Выйти из системы';

  @override
  String get requestedProjectsTitle => 'Запрошенные проекты';

  @override
  String get requested => 'Запрошен';

  @override
  String get underConstruction => 'Строительство';

  @override
  String get myObjectsTitle => 'Мои объекты';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get searchProjects => 'Поиск проектов';

  @override
  String get searchHint => 'Введите название или адрес';

  @override
  String get noRequestedProjects => 'Нет запрошенных проектов';

  @override
  String get noMyObjects => 'У вас пока нет объектов';

  @override
  String get constructionProgress => 'Прогресс строительства';

  @override
  String get stagesCompleted => 'этапов завершено';

  @override
  String get startConstruction => 'Начать';

  @override
  String get constructionAddressTitle => 'Адрес строительства';

  @override
  String get enterConstructionAddress => 'Введите адрес строительства';

  @override
  String get constructionStarted => 'Строительство начато!';

  @override
  String get completeConstruction => 'Завершить строительство';

  @override
  String get constructionCompletedSuccess => 'Строительство успешно завершено!';

  @override
  String get networkError => 'Ошибка сети. Проверьте подключение к интернету';

  @override
  String get serverError => 'Ошибка сервера';

  @override
  String get cacheError => 'Ошибка сохранения данных';
}
