import 'package:mosstroinform_mobile/core/errors/failures.dart';
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
    try {
      final model = await remoteDataSource.getCompletionStatus(projectId);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении статуса завершения: $e');
    }
  }

  @override
  Future<List<FinalDocument>> getFinalDocuments(String projectId) async {
    try {
      final models = await remoteDataSource.getFinalDocuments(projectId);
      return models.map((model) => model.toEntity()).toList();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении финальных документов: $e');
    }
  }

  @override
  Future<FinalDocument> getFinalDocumentById(
    String projectId,
    String documentId,
  ) async {
    try {
      final model =
          await remoteDataSource.getFinalDocumentById(projectId, documentId);
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при получении финального документа: $e');
    }
  }

  @override
  Future<void> signFinalDocument(String projectId, String documentId) async {
    try {
      await remoteDataSource.signFinalDocument(projectId, documentId);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при подписании документа: $e');
    }
  }

  @override
  Future<void> rejectFinalDocument(
    String projectId,
    String documentId,
    String reason,
  ) async {
    try {
      await remoteDataSource.rejectFinalDocument(projectId, documentId, reason);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Ошибка при отклонении документа: $e');
    }
  }
}

