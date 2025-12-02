import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Моковая реализация репозитория документов
/// Используется для демонстрации приложения без реального бэкенда
class MockDocumentRepository implements DocumentRepository {
  @override
  Future<List<Document>> getDocuments() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final mockData = [
      {
        'id': '1',
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

  @override
  Future<Document> getDocumentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final documents = await getDocuments();
    try {
      final document = documents.firstWhere((d) => d.id == id);
      return document;
    } catch (e) {
      throw UnknownFailure('Документ с ID $id не найден');
    }
  }

  @override
  Future<void> approveDocument(String documentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // В реальном приложении здесь была бы отправка запроса на одобрение
  }

  @override
  Future<void> rejectDocument(String documentId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // В реальном приложении здесь была бы отправка запроса на отклонение
  }
}

