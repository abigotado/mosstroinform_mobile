import 'package:mosstroinform_mobile/core/database/hive_service.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:mosstroinform_mobile/core/database/adapters/construction_object_adapter.dart';
import 'package:mosstroinform_mobile/core/database/adapters/document_adapter.dart';
import 'package:mosstroinform_mobile/core/database/adapters/project_adapter.dart';

/// Интерактивная моковая реализация репозитория проектов
/// Использует локальную базу данных Hive для имитации реальной работы приложения
/// Данные сохраняются между перезапусками приложения
class MockProjectRepository implements ProjectRepository {
  @override
  Future<List<Project>> getProjects({int? page, int? limit}) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Обеспечиваем загрузку проектов, если бокс пустой (ленивая загрузка)
    await HiveService.ensureProjectsLoaded();

    // Получаем все проекты из базы
    final projectsBox = HiveService.projectsBox;
    final allProjects = projectsBox.values.map((adapter) => adapter.toProject()).toList();

    // Если указаны параметры пагинации, применяем их
    if (page != null && limit != null) {
      final startIndex = page * limit;
      final endIndex = (startIndex + limit).clamp(0, allProjects.length);
      
      if (startIndex >= allProjects.length) {
        AppLogger.info(
          'MockProjectRepository.getProjects: страница $page пуста (всего проектов: ${allProjects.length})',
        );
        return [];
      }
      
      final paginatedProjects = allProjects.sublist(startIndex, endIndex);
      AppLogger.info(
        'MockProjectRepository.getProjects: страница $page, получено ${paginatedProjects.length} из ${allProjects.length} проектов',
      );
      return paginatedProjects;
    }

    // Если пагинация не указана, возвращаем все проекты
    AppLogger.info(
      'MockProjectRepository.getProjects: получено ${allProjects.length} проектов (без пагинации)',
    );
    return allProjects;
  }

  @override
  Future<Project> getProjectById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    // Обеспечиваем загрузку проектов, если бокс пустой (ленивая загрузка)
    await HiveService.ensureProjectsLoaded();

    // Получаем проект из базы
    final projectsBox = HiveService.projectsBox;
    final projectAdapter = projectsBox.get(id);

    if (projectAdapter == null) {
      throw UnknownFailure('Проект с ID $id не найден');
    }

    return projectAdapter.toProject();
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Обновляем статус проекта на "requested"
    final projectsBox = HiveService.projectsBox;
    final projectAdapter = projectsBox.get(projectId);

    if (projectAdapter != null) {
      // Создаем обновленный адаптер со статусом "requested"
      // Сохраняем все поля, включая objectId (если он был установлен ранее)
      final updatedAdapter = ProjectAdapter(
        id: projectAdapter.id,
        name: projectAdapter.name,
        address: projectAdapter.address,
        description: projectAdapter.description,
        area: projectAdapter.area,
        floors: projectAdapter.floors,
        bedrooms: projectAdapter.bedrooms,
        bathrooms: projectAdapter.bathrooms,
        price: projectAdapter.price,
        imageUrl: projectAdapter.imageUrl,
        statusString: 'requested',
        constructionAddress: null, // Адрес больше не хранится в проекте
        objectId: projectAdapter.objectId, // Сохраняем objectId если он был установлен
      );
      await projectsBox.put(projectId, updatedAdapter);
      AppLogger.info(
        'MockProjectRepository.requestConstruction: статус проекта $projectId изменен на requested',
      );
    }

    // Добавляем проект в список запрошенных
    final requestedBox = HiveService.requestedProjectsBox;
    if (!requestedBox.containsKey(projectId)) {
      await requestedBox.put(projectId, projectId);
      AppLogger.info(
        'MockProjectRepository.requestConstruction: проект $projectId добавлен в запрошенные',
      );
    }

    // Создаем документы для проекта
    await _createDocumentsForProject(projectId);
    AppLogger.info(
      'MockProjectRepository.requestConstruction: созданы документы для проекта $projectId',
    );

    // Объект строительства будет создан после подписания всех документов
  }

  /// Создать документы для проекта
  Future<void> _createDocumentsForProject(String projectId) async {
    final documentsBox = HiveService.documentsBox;

    // Проверяем, не созданы ли уже документы для этого проекта
    // Проверяем по конкретным ID документов, чтобы избежать дублирования
    final docIds = [
      'doc_${projectId}_1',
      'doc_${projectId}_2',
      'doc_${projectId}_3',
    ];
    
    final existingDocs = docIds
        .where((id) => documentsBox.containsKey(id))
        .toList();
    
    if (existingDocs.isNotEmpty) {
      AppLogger.info(
        'MockProjectRepository._createDocumentsForProject: документы для проекта $projectId уже существуют (найдено ${existingDocs.length} из ${docIds.length})',
      );
      return;
    }

    // Создаем стандартный набор документов
    final documents = [
      Document(
        id: 'doc_${projectId}_1',
        projectId: projectId,
        title: 'Проектная документация',
        description: 'Полный комплект проектной документации для строительства',
        fileUrl: 'https://example.com/docs/project-docs.pdf',
        status: DocumentStatus.pending,
        submittedAt: DateTime.now().subtract(const Duration(days: 2)),
        approvedAt: null,
        rejectionReason: null,
      ),
      Document(
        id: 'doc_${projectId}_2',
        projectId: projectId,
        title: 'Разрешение на строительство',
        description: 'Официальное разрешение на начало строительных работ',
        fileUrl: 'https://example.com/docs/building-permit.pdf',
        status: DocumentStatus.pending,
        submittedAt: DateTime.now().subtract(const Duration(days: 1)),
        approvedAt: null,
        rejectionReason: null,
      ),
      Document(
        id: 'doc_${projectId}_3',
        projectId: projectId,
        title: 'Договор подряда',
        description: 'Договор на выполнение строительных работ',
        fileUrl: 'https://example.com/docs/contract.pdf',
        status: DocumentStatus.pending,
        submittedAt: DateTime.now().subtract(const Duration(days: 1)),
        approvedAt: null,
        rejectionReason: null,
      ),
    ];

    // Сохраняем документы в базу
    for (final doc in documents) {
      await documentsBox.put(doc.id, DocumentAdapter.fromDocument(doc));
    }

    AppLogger.info(
      'MockProjectRepository._createDocumentsForProject: создано ${documents.length} документов для проекта $projectId',
    );
  }

  @override
  Future<List<Project>> getRequestedProjects() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Получаем список запрошенных проектов из базы
    final requestedBox = HiveService.requestedProjectsBox;
    final requestedIds = requestedBox.values.toSet();

    // Получаем проекты из базы
    final projectsBox = HiveService.projectsBox;
    final requestedProjects = projectsBox.values
        .where((adapter) => requestedIds.contains(adapter.id))
        .map((adapter) => adapter.toProject())
        .toList();

    AppLogger.info(
      'MockProjectRepository.getRequestedProjects: получено ${requestedProjects.length} запрошенных проектов',
    );
    return requestedProjects;
  }

  @override
  Future<void> startConstruction(String projectId, String address) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Обновляем статус проекта на "construction" и добавляем адрес
    final projectsBox = HiveService.projectsBox;
    final projectAdapter = projectsBox.get(projectId);

    if (projectAdapter == null) {
      throw UnknownFailure('Проект с ID $projectId не найден');
    }

    // Создаем объект строительства (получаем objectId)
    final objectId = await _createConstructionObject(projectId, address);

    // Создаем обновленный адаптер с новыми полями, включая objectId
    final updatedAdapter = ProjectAdapter(
      id: projectAdapter.id,
      name: projectAdapter.name,
      address: projectAdapter.address,
      description: projectAdapter.description,
      area: projectAdapter.area,
      floors: projectAdapter.floors,
      bedrooms: projectAdapter.bedrooms,
      bathrooms: projectAdapter.bathrooms,
      price: projectAdapter.price,
      imageUrl: projectAdapter.imageUrl,
      statusString: 'construction',
      constructionAddress: null, // Адрес больше не хранится в проекте
      objectId: objectId,
    );
    await projectsBox.put(projectId, updatedAdapter);

    // Удаляем из списка запрошенных
    final requestedBox = HiveService.requestedProjectsBox;
    await requestedBox.delete(projectId);

    AppLogger.info(
      'MockProjectRepository.startConstruction: строительство проекта $projectId начато по адресу "$address"',
    );
  }

  @override
  Future<bool> isProjectRequested(String projectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 200));

    // Проверяем в базе
    final requestedBox = HiveService.requestedProjectsBox;
    return requestedBox.containsKey(projectId);
  }

  /// Создать объект строительства для проекта
  /// Возвращает ID созданного объекта
  Future<String> _createConstructionObject(String projectId, String address) async {
    // Получаем проект для создания объекта
    final projectsBox = HiveService.projectsBox;
    final projectAdapter = projectsBox.get(projectId);

    if (projectAdapter == null) {
      throw UnknownFailure('Проект с ID $projectId не найден');
    }

    final project = projectAdapter.toProject();

    // Создаем чат для объекта автоматически (в моковом режиме)
    // В реальном режиме чат будет создан автоматически на бэкенде при создании объекта
    // и chatId будет возвращен в ответе от API
    final chatId = MockChatRepository.createChatForProject(projectId);

    // Создаем начальные этапы строительства
    // Для моков все этапы создаются со статусом completed (100% прогресс) для тестирования подписания документов
    final initialStages = [
      const ConstructionStage(id: '1', name: 'Подготовительные работы', status: StageStatus.completed),
      const ConstructionStage(id: '2', name: 'Фундамент', status: StageStatus.completed),
      const ConstructionStage(id: '3', name: 'Возведение стен', status: StageStatus.completed),
      const ConstructionStage(id: '4', name: 'Кровля', status: StageStatus.completed),
      const ConstructionStage(id: '5', name: 'Отделочные работы', status: StageStatus.completed),
    ];

    // Создаем объект строительства с chatId
    final object = ConstructionObject.fromProject(
      project,
      'object_$projectId',
      address,
      initialStages,
      chatId: chatId,
    );

    // Сохраняем объект в базе
    final objectsBox = HiveService.constructionObjectsBox;
    await objectsBox.put(
      object.id,
      ConstructionObjectAdapter.fromObject(object),
    );

    AppLogger.info(
      'MockProjectRepository._createConstructionObject: создан объект строительства ${object.id} для проекта $projectId с чатом $chatId',
    );

    return object.id;
  }

  /// Метод для удаления проекта из запрошенных
  /// Используется только в моковой реализации для имитации работы бэкенда
  /// Не является частью интерфейса ProjectRepository
  Future<void> removeRequestedProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final requestedBox = HiveService.requestedProjectsBox;
    await requestedBox.delete(projectId);
    AppLogger.info(
      'MockProjectRepository.removeRequestedProject: проект $projectId удален из запрошенных',
    );
  }
}
