import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/models/document_model.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/datasources/document_remote_data_source.dart';

part 'document_remote_data_source.g.dart';

/// Удалённый источник данных для документов (Retrofit)
/// Реализует интерфейс из domain слоя
@RestApi()
abstract class DocumentRemoteDataSource implements IDocumentRemoteDataSource {
  factory DocumentRemoteDataSource(Dio dio, {String baseUrl}) =
      _DocumentRemoteDataSource;

  @override
  @GET('/documents')
  Future<List<DocumentModel>> getDocuments();

  @override
  @GET('/documents/{id}')
  Future<DocumentModel> getDocumentById(@Path('id') String id);

  @override
  @POST('/documents/{id}/approve')
  Future<void> approveDocument(@Path('id') String documentId);

  @override
  @POST('/documents/{id}/reject')
  Future<void> rejectDocument(
    @Path('id') String documentId,
    @Body() Map<String, dynamic> body,
  );
}

