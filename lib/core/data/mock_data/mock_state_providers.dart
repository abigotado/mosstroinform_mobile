import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

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
        'projectId': '1',
        'title': 'Проектная документация',
        'description': 'Полный комплект проектной документации для строительства',
        'fileUrl': 'https://example.com/docs/project-docs.pdf',
        'status': 'under_review',
        'submittedAt': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'approvedAt': null,
        'rejectionReason': null,
      },
      {
        'id': '2',
        'projectId': '1',
        'title': 'Разрешение на строительство',
        'description': 'Официальное разрешение на начало строительных работ',
        'fileUrl': 'https://example.com/docs/building-permit.pdf',
        'status': 'approved',
        'submittedAt': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'approvedAt': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'rejectionReason': null,
      },
      {
        'id': '3',
        'projectId': '1',
        'title': 'Договор подряда',
        'description': 'Договор на выполнение строительных работ',
        'fileUrl': 'https://example.com/docs/contract.pdf',
        'status': 'pending',
        'submittedAt': null,
        'approvedAt': null,
        'rejectionReason': null,
      },
      {
        'id': '4',
        'projectId': '1',
        'title': 'Смета на материалы',
        'description': 'Детальная смета расходов на строительные материалы',
        'fileUrl': 'https://example.com/docs/estimate.pdf',
        'status': 'rejected',
        'submittedAt': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
        'approvedAt': null,
        'rejectionReason': 'Требуется уточнение цен на материалы',
      },
    ];

    final models = mockData.map((json) => DocumentModel.fromJson(json)).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  /// Обновить документ
  void updateDocument(Document document) {
    state = [
      for (final doc in state)
        if (doc.id == document.id) document else doc,
    ];
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
        'address': 'ул. Лесная, 15',
        'description': 'Двухэтажный дом площадью 150 кв.м с гаражом',
        'area': 150.0,
        'floors': 2,
        'price': 8500000,
        'imageUrl':
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',
        'stages': [
          {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
          {'id': '2', 'name': 'Фундамент', 'status': 'in_progress'},
          {'id': '3', 'name': 'Возведение стен', 'status': 'pending'},
          {'id': '4', 'name': 'Кровля', 'status': 'pending'},
        ],
      },
      {
        'id': '2',
        'name': 'Дачный дом',
        'address': 'с. Луговое, 3',
        'description': 'Одноэтажный дачный дом площадью 80 кв.м',
        'area': 80.0,
        'floors': 1,
        'price': 4200000,
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',
        'stages': [
          {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
          {'id': '2', 'name': 'Фундамент', 'status': 'completed'},
          {'id': '3', 'name': 'Возведение стен', 'status': 'in_progress'},
          {'id': '4', 'name': 'Кровля', 'status': 'pending'},
        ],
      },
      {
        'id': '3',
        'name': 'Коттедж с мансардой',
        'address': 'ул. Садовая, 42',
        'description': 'Дом с мансардой площадью 180 кв.м',
        'area': 180.0,
        'floors': 2,
        'price': 12000000,
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b?w=800&h=600&fit=crop',
        'stages': [
          {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
          {'id': '2', 'name': 'Фундамент', 'status': 'completed'},
          {'id': '3', 'name': 'Возведение стен', 'status': 'completed'},
          {'id': '4', 'name': 'Кровля', 'status': 'in_progress'},
        ],
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

