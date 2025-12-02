import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/datasources/document_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/repositories/document_repository_impl.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/repositories/mock_document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';

part 'document_data_providers.g.dart';

/// Провайдер для Retrofit источника данных документов
@riverpod
DocumentRemoteDataSource documentRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DocumentRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}

/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
@riverpod
DocumentRepository documentRepository(Ref ref) {
  if (AppConstants.useMocks) {
    return MockDocumentRepository();
  }
  final remoteDataSource = ref.watch(documentRemoteDataSourceProvider);
  return DocumentRepositoryImpl(remoteDataSource: remoteDataSource);
}

