import 'package:mosstroinform_mobile/core/utils/extensions/error_guard_extension.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/models/final_document_model.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/datasources/final_document_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/entities/final_document.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

/// Реализация репозитория финальных документов
class FinalDocumentRepositoryImpl implements FinalDocumentRepository {
  final IFinalDocumentRemoteDataSource remoteDataSource;

  FinalDocumentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ConstructionCompletionStatus> getCompletionStatus(
    String projectId,
  ) async {
    return guard(() async {
      final model = await remoteDataSource.getCompletionStatus(projectId);
      return model.toEntity();
    }, methodName: 'getCompletionStatus');
  }

  @override
  Future<List<FinalDocument>> getFinalDocuments(String projectId) async {
    return guard(() async {
      final models = await remoteDataSource.getFinalDocuments(projectId);
      return models.map((model) => model.toEntity()).toList();
    }, methodName: 'getFinalDocuments');
  }

  @override
  Future<FinalDocument> getFinalDocumentById(
    String projectId,
    String documentId,
  ) async {
    return guard(() async {
      final model = await remoteDataSource.getFinalDocumentById(
        projectId,
        documentId,
      );
      return model.toEntity();
    }, methodName: 'getFinalDocumentById');
  }

  @override
  Future<void> signFinalDocument(String projectId, String documentId) async {
    return guard(() async {
      await remoteDataSource.signFinalDocument(projectId, documentId);
    }, methodName: 'signFinalDocument');
  }

  @override
  Future<void> rejectFinalDocument(
    String projectId,
    String documentId,
    String reason,
  ) async {
    return guard(() async {
      await remoteDataSource.rejectFinalDocument(projectId, documentId, reason);
    }, methodName: 'rejectFinalDocument');
  }
}
