import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_state_providers.g.dart';

/// Провайдер состояния моковых документов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
@Riverpod(keepAlive: true)
class MockDocumentsState extends _$MockDocumentsState {
  @override
  List<Document> build() {
    // Дефолтное состояние документов
    return _getDefaultDocuments();
  }

  /// Получить дефолтное состояние документов
  List<Document> _getDefaultDocuments() {
    final mockData = [
      {
        'id': '1',
        'project_id': '1',
        'title': 'Проектная документация',
        'description':
            'Полный комплект проектной документации для строительства',
        'file_url': 'https://example.com/docs/project-docs.pdf',
        'status': 'under_review',
        'submitted_at': DateTime.now()
            .subtract(const Duration(days: 2))
            .toIso8601String(),
        'approved_at': null,
        'rejection_reason': null,
      },
      {
        'id': '2',
        'project_id': '1',
        'title': 'Разрешение на строительство',
        'description': 'Официальное разрешение на начало строительных работ',
        'file_url': 'https://example.com/docs/building-permit.pdf',
        'status': 'approved',
        'submitted_at': DateTime.now()
            .subtract(const Duration(days: 5))
            .toIso8601String(),
        'approved_at': DateTime.now()
            .subtract(const Duration(days: 1))
            .toIso8601String(),
        'rejection_reason': null,
      },
      {
        'id': '3',
        'project_id': '1',
        'title': 'Договор подряда',
        'description': 'Договор на выполнение строительных работ',
        'file_url': 'https://example.com/docs/contract.pdf',
        'status': 'pending',
        'submitted_at': null,
        'approved_at': null,
        'rejection_reason': null,
      },
      {
        'id': '4',
        'project_id': '1',
        'title': 'Смета на материалы',
        'description': 'Детальная смета расходов на строительные материалы',
        'file_url': 'https://example.com/docs/estimate.pdf',
        'status': 'rejected',
        'submitted_at': DateTime.now()
            .subtract(const Duration(days: 7))
            .toIso8601String(),
        'approved_at': null,
        'rejection_reason': 'Требуется уточнение цен на материалы',
      },
    ];

    final models = mockData
        .map((json) => DocumentModel.fromJson(json))
        .toList();
    return models.map((model) => model.toEntity()).toList();
  }

  /// Обновить документ
  void updateDocument(Document document) {
    state = [
      for (final doc in state)
        if (doc.id == document.id) document else doc,
    ];
  }

  /// Создать документы для проекта
  /// Вызывается после запроса проекта
  void createDocumentsForProject(String projectId) {
    // Проверяем, не существуют ли уже документы для этого проекта
    if (state.any((doc) => doc.projectId == projectId)) {
      return;
    }

    // Создаем стандартный набор документов для проекта
    final newDocuments = [
      Document(
        id: 'doc_${projectId}_1',
        projectId: projectId,
        title: 'Проектная документация',
        description: 'Полный комплект проектной документации для строительства',
        fileUrl: 'https://example.com/docs/project-docs-$projectId.pdf',
        status: DocumentStatus.pending,
        submittedAt: null,
        approvedAt: null,
        rejectionReason: null,
      ),
      Document(
        id: 'doc_${projectId}_2',
        projectId: projectId,
        title: 'Разрешение на строительство',
        description: 'Официальное разрешение на начало строительных работ',
        fileUrl: 'https://example.com/docs/building-permit-$projectId.pdf',
        status: DocumentStatus.pending,
        submittedAt: null,
        approvedAt: null,
        rejectionReason: null,
      ),
      Document(
        id: 'doc_${projectId}_3',
        projectId: projectId,
        title: 'Договор подряда',
        description: 'Договор на выполнение строительных работ',
        fileUrl: 'https://example.com/docs/contract-$projectId.pdf',
        status: DocumentStatus.pending,
        submittedAt: null,
        approvedAt: null,
        rejectionReason: null,
      ),
      Document(
        id: 'doc_${projectId}_4',
        projectId: projectId,
        title: 'Смета на материалы',
        description: 'Детальная смета расходов на строительные материалы',
        fileUrl: 'https://example.com/docs/estimate-$projectId.pdf',
        status: DocumentStatus.pending,
        submittedAt: null,
        approvedAt: null,
        rejectionReason: null,
      ),
    ];

    state = [...state, ...newDocuments];
  }

  /// Получить документы для проекта
  List<Document> getDocumentsForProject(String projectId) {
    return state.where((doc) => doc.projectId == projectId).toList();
  }

  /// Проверить, все ли документы проекта одобрены
  bool areAllDocumentsApproved(String projectId) {
    final projectDocuments = getDocumentsForProject(projectId);
    if (projectDocuments.isEmpty) return false;
    return projectDocuments.every(
      (doc) => doc.status == DocumentStatus.approved,
    );
  }

  /// Сбросить к дефолту
  void reset() {
    state = _getDefaultDocuments();
  }
}

/// Провайдер состояния моковых проектов
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
@Riverpod(keepAlive: true)
class MockProjectsState extends _$MockProjectsState {
  @override
  List<Project> build() {
    // Дефолтное состояние проектов
    return _getDefaultProjects();
  }

  /// Получить дефолтное состояние проектов
  List<Project> _getDefaultProjects() {
    final mockData = [
      {
        'id': '1',
        'name': 'Частный жилой дом',
        'description': 'Двухэтажный дом площадью 150 кв.м с гаражом',
        'area': 150.0,
        'floors': 2,
        'bedrooms': 3,
        'bathrooms': 2,
        'price': 8500000,
        'image_url':
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',
        'status': 'available',
        'object_id': null,
      },
      {
        'id': '2',
        'name': 'Дачный дом',
        'description': 'Одноэтажный дачный дом площадью 80 кв.м',
        'area': 80.0,
        'floors': 1,
        'bedrooms': 2,
        'bathrooms': 1,
        'price': 4200000,
        'image_url':
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',
        'status': 'available',
        'object_id': null,
      },
      {
        'id': '3',
        'name': 'Коттедж с мансардой',
        'description': 'Дом с мансардой площадью 180 кв.м',
        'area': 180.0,
        'floors': 2,
        'bedrooms': 4,
        'bathrooms': 3,
        'price': 12000000,
        'image_url':
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b?w=800&h=600&fit=crop',
        'status': 'available',
        'object_id': null,
      },
    ];

    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  /// Обновить проект
  void updateProject(Project project) {
    state = [
      for (final proj in state)
        if (proj.id == project.id) project else proj,
    ];
  }

  /// Сбросить к дефолту
  void reset() {
    state = _getDefaultProjects();
  }
}

/// Провайдер состояния моковых объектов строительства
/// Состояние хранится в памяти и сбрасывается при перезапуске приложения
@Riverpod(keepAlive: true)
class MockConstructionObjectsState extends _$MockConstructionObjectsState {
  @override
  List<ConstructionObject> build() {
    // Начальное состояние - пустой список объектов
    return [];
  }

  /// Добавить объект
  void addObject(ConstructionObject object) {
    state = [...state, object];
  }

  /// Обновить объект
  void updateObject(ConstructionObject object) {
    state = [
      for (final obj in state)
        if (obj.id == object.id) object else obj,
    ];
  }

  /// Удалить объект
  void removeObject(String objectId) {
    state = state.where((obj) => obj.id != objectId).toList();
  }

  /// Сбросить к дефолту
  void reset() {
    state = [];
  }
}
