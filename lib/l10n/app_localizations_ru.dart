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
}
