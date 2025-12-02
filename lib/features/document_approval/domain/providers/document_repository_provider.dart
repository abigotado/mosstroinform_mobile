import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/providers/document_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/repositories/document_repository_impl.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/repositories/mock_document_repository.dart';
import 'package:mosstroinform_mobile/features/document_approval/domain/repositories/document_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_repository_provider.g.dart';

/// Провайдер для репозитория документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
@riverpod
DocumentRepository documentRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockDocumentRepository(ref);
  }
  final remoteDataSource = ref.watch(documentRemoteDataSourceProvider);
  return DocumentRepositoryImpl(remoteDataSource: remoteDataSource);
}
