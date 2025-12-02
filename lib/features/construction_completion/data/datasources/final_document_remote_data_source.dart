import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/models/final_document_model.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/datasources/final_document_remote_data_source.dart';

part 'final_document_remote_data_source.g.dart';

/// Удалённый источник данных для финальных документов (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class FinalDocumentRemoteDataSource
    implements IFinalDocumentRemoteDataSource {
  factory FinalDocumentRemoteDataSource(Dio dio, {String baseUrl}) =
      _FinalDocumentRemoteDataSource;

  @override
  @GET('/projects/{projectId}/completion-status')
  Future<ConstructionCompletionStatusModel> getCompletionStatus(
    @Path('projectId') String projectId,
  );

  @override
  @GET('/projects/{projectId}/final-documents')
  Future<List<FinalDocumentModel>> getFinalDocuments(
    @Path('projectId') String projectId,
  );

  @override
  @GET('/projects/{projectId}/final-documents/{documentId}')
  Future<FinalDocumentModel> getFinalDocumentById(
    @Path('projectId') String projectId,
    @Path('documentId') String documentId,
  );

  @override
  @POST('/projects/{projectId}/final-documents/{documentId}/sign')
  Future<void> signFinalDocument(
    @Path('projectId') String projectId,
    @Path('documentId') String documentId,
  );

  @override
  @POST('/projects/{projectId}/final-documents/{documentId}/reject')
  Future<void> rejectFinalDocument(
    @Path('projectId') String projectId,
    @Path('documentId') String documentId,
    @Field('reason') String reason,
  );
}

