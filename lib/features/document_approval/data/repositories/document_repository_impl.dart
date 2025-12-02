import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/datasources/document_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/entities/document.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

/// Реализация репозитория документов
class DocumentRepositoryImpl implements DocumentRepository {
  final IDocumentRemoteDataSource remoteDataSource;

  DocumentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Document>> getDocuments() async {
    try {
      final models = await remoteDataSource.getDocuments();
      return models.map((model) => model.toEntity()).toList();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении документов: $e');
    }
  }

  @override
  Future<Document> getDocumentById(String id) async {
    try {
      final model = await remoteDataSource.getDocumentById(id);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении документа: $e');
    }
  }

  @override
  Future<void> approveDocument(String documentId) async {
    try {
      await remoteDataSource.approveDocument(documentId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при одобрении документа: $e');
    }
  }

  @override
  Future<void> rejectDocument(String documentId, String reason) async {
    try {
      await remoteDataSource.rejectDocument(documentId, {'reason': reason});
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отклонении документа: $e');
    }
  }
}

