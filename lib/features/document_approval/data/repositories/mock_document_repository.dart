import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/core/database/adapters/document_adapter.dart';
import 'package:mosstroinform_mobile/core/database/adapters/construction_object_adapter.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/mock_chat_repository.dart';

/// Интерактивная моковая реализация репозитория документов
/// Использует локальную базу данных Hive для имитации реальной работы приложения
/// Данные сохраняются между перезапусками приложения
class MockDocumentRepository implements DocumentRepository {
  final ProjectRepository projectRepository;

  MockDocumentRepository({required this.projectRepository});

  @override
  Future<List<Document>> getDocuments() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем все документы из базы
    final documentsBox = HiveService.documentsBox;
    final documents = documentsBox.values.map((adapter) => adapter.toDocument()).toList();

    return documents;
  }

  @override
  Future<List<Document>> getDocumentsByProjectId(String projectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Получаем документы для проекта из базы
    final documentsBox = HiveService.documentsBox;
    
    // Используем keys для получения уникальных документов по ID
    // Это гарантирует, что каждый документ будет только один раз
    final documentIds = <String>{};
    for (final key in documentsBox.keys) {
      if (key is String && key.startsWith('doc_$projectId')) {
        documentIds.add(key);
      }
    }
    
    final documents = documentIds
        .map((id) => documentsBox.get(id))
        .whereType<DocumentAdapter>() // Фильтруем null значения
        .map((adapter) => adapter.toDocument())
        .toList();

    AppLogger.info(
      'MockDocumentRepository.getDocumentsByProjectId: получено ${documents.length} уникальных документов для проекта $projectId (ключей: ${documentIds.length})',
    );

    return documents;
  }

  @override
  Future<Document> getDocumentById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Получаем документ из базы
    final documentsBox = HiveService.documentsBox;
    final documentAdapter = documentsBox.get(id);

    if (documentAdapter == null) {
      throw UnknownFailure('Документ с ID $id не найден');
    }

    return documentAdapter.toDocument();
  }

  @override
  Future<void> approveDocument(String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем текущий документ из базы
    final documentsBox = HiveService.documentsBox;
    final documentAdapter = documentsBox.get(documentId);

    if (documentAdapter == null) {
      throw UnknownFailure('Документ с ID $documentId не найден');
    }

    // Обновляем существующий документ напрямую через HiveObject
    // Используем copyWith-подобный подход, создавая новый адаптер с обновленными полями
    final updatedAdapter = DocumentAdapter(
      id: documentAdapter.id,
      projectId: documentAdapter.projectId,
      title: documentAdapter.title,
      description: documentAdapter.description,
      fileUrl: documentAdapter.fileUrl,
      statusString: 'approved',
      submittedAt: documentAdapter.submittedAt,
      approvedAt: DateTime.now(),
      rejectionReason: null,
    );

    // Обновляем документ в базе, используя тот же ключ (ID)
    // Hive.put с тем же ключом заменяет существующую запись, а не создает новую
    await documentsBox.put(documentId, updatedAdapter);
    
    AppLogger.info(
      'MockDocumentRepository.approveDocument: документ $documentId обновлен со статусом approved',
    );
    
    // Проверяем, что нет дубликатов (по ID должен быть только один документ)
    final documentsWithSameId = documentsBox.values
        .where((adapter) => adapter.id == documentId)
        .length;
    if (documentsWithSameId > 1) {
      AppLogger.error(
        'MockDocumentRepository.approveDocument: ОШИБКА! Обнаружены дубликаты документа $documentId ($documentsWithSameId записей)!',
      );
    }

    // Проверяем, все ли документы проекта одобрены
    // Используем прямой запрос к базе после обновления, чтобы получить актуальные данные
    final projectId = documentAdapter.projectId;
    final projectDocuments = documentsBox.values
        .where((adapter) => adapter.projectId == projectId)
        .map((adapter) => adapter.toDocument())
        .toList();
    final allApproved = projectDocuments.isNotEmpty &&
        projectDocuments.every((doc) => doc.status == DocumentStatus.approved);

    if (allApproved) {
      AppLogger.info(
        'MockDocumentRepository.approveDocument: все документы проекта $projectId одобрены, создаем объект',
      );

      // Получаем проект через интерфейс репозитория
      final project = await projectRepository.getProjectById(projectId);

      // Проверяем, не существует ли уже объект для этого проекта
      final objectsBox = HiveService.constructionObjectsBox;
      final existingObject = objectsBox.values
          .where((obj) => obj.projectId == projectId)
          .firstOrNull;

      if (existingObject == null) {
        // Создаем чат для объекта автоматически (в моковом режиме)
        final chatId = MockChatRepository.createChatForProject(projectId);
        
        // Создаем начальные этапы строительства
        // Для моков все этапы создаются со статусом completed (100% прогресс) для тестирования подписания документов
        final initialStages = [
          ConstructionStageAdapter(
            id: '1',
            name: 'Подготовительные работы',
            statusString: 'completed',
          ),
          ConstructionStageAdapter(
            id: '2',
            name: 'Фундамент',
            statusString: 'completed',
          ),
          ConstructionStageAdapter(
            id: '3',
            name: 'Возведение стен',
            statusString: 'completed',
          ),
          ConstructionStageAdapter(
            id: '4',
            name: 'Кровля',
            statusString: 'completed',
          ),
          ConstructionStageAdapter(
            id: '5',
            name: 'Отделочные работы',
            statusString: 'completed',
          ),
        ];

        // Создаем объект из проекта
        // Адрес будет добавлен позже при начале строительства
        final objectAdapter = ConstructionObjectAdapter.fromObject(
          ConstructionObject.fromProject(
            project,
            'object_$projectId', // ID объекта формируется из projectId
            'Адрес будет указан при начале строительства', // Временный адрес
            initialStages.map((s) => s.toStage()).toList(),
            chatId: chatId,
          ),
        );

        // Сохраняем объект в базу
        await objectsBox.put(objectAdapter.id, objectAdapter);

        AppLogger.info(
          'MockDocumentRepository.approveDocument: объект ${objectAdapter.id} создан для проекта $projectId',
        );
      } else {
        AppLogger.info(
          'MockDocumentRepository.approveDocument: объект для проекта $projectId уже существует',
        );
      }

      // Удаляем проект из списка запрошенных
      final requestedBox = HiveService.requestedProjectsBox;
      await requestedBox.delete(projectId);
      AppLogger.info(
        'MockDocumentRepository.approveDocument: проект $projectId удален из списка запрошенных',
      );
    }
  }

  @override
  Future<void> rejectDocument(String documentId, String reason) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем текущий документ из базы
    final documentsBox = HiveService.documentsBox;
    final documentAdapter = documentsBox.get(documentId);

    if (documentAdapter == null) {
      throw UnknownFailure('Документ с ID $documentId не найден');
    }

    // Создаем обновленный документ со статусом rejected
    final updatedAdapter = DocumentAdapter(
      id: documentAdapter.id,
      projectId: documentAdapter.projectId,
      title: documentAdapter.title,
      description: documentAdapter.description,
      fileUrl: documentAdapter.fileUrl,
      statusString: 'rejected',
      submittedAt: documentAdapter.submittedAt,
      approvedAt: null,
      rejectionReason: reason,
    );

    // Обновляем документ в базе
    await documentsBox.put(documentId, updatedAdapter);
  }
}
