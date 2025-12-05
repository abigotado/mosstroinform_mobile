import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
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
    return guard(() async {
      final models = await remoteDataSource.getDocuments();
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getDocuments');
  }

  @override
  Future<List<Document>> getDocumentsByProjectId(String projectId) async {
    return guard(() async {
      // Фильтруем документы по projectId
      final allDocuments = await getDocuments();
      return allDocuments.where((doc) => doc.projectId == projectId).toList();
    }, methodName: 'getDocumentsByProjectId');
  }

  @override
  Future<Document> getDocumentById(String id) async {
    return guard(() async {
      final model = await remoteDataSource.getDocumentById(id);
      return model.toEntity();
    }, methodName: 'getDocumentById');
  }

  @override
  Future<void> approveDocument(String documentId) async {
    return guard(() async {
      await remoteDataSource.approveDocument(documentId);
    }, methodName: 'approveDocument');
  }

  @override
  Future<void> rejectDocument(String documentId, String reason) async {
    return guard(() async {
      await remoteDataSource.rejectDocument(documentId, {'reason': reason});
    }, methodName: 'rejectDocument');
  }
}
