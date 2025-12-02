import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/providers/final_document_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/repositories/final_document_repository_impl.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/repositories/mock_final_document_repository.dart';
import 'package:mosstroinform_mobile/features/construction_completion/domain/repositories/final_document_repository.dart';

part 'final_document_repository_provider.g.dart';

/// Провайдер для репозитория финальных документов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
@riverpod
FinalDocumentRepository finalDocumentRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockFinalDocumentRepository();
  }
  final remoteDataSource = ref.watch(finalDocumentRemoteDataSourceProvider);
  return FinalDocumentRepositoryImpl(remoteDataSource: remoteDataSource);
}

