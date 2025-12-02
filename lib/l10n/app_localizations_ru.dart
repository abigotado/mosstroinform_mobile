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
  String get projectsTitle => 'Объекты';

  @override
  String get projectsNotFound => 'Проекты не найдены';

  @override
  String get projectDetails => 'Детали проекта';

  @override
  String get projectNotFound => 'Проект не найден';

  @override
  String get sendConstructionRequest => 'Отправить запрос на строительство';

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
  String get floors => 'Этажность';

  @override
  String get price => 'Стоимость';

  @override
  String get floor => 'этаж';

  @override
  String get floorsPlural => 'этажа';

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
}
