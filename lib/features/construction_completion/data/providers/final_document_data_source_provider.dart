import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/construction_completion/data/datasources/final_document_remote_data_source.dart';

part 'final_document_data_source_provider.g.dart';

/// Провайдер для Retrofit источника данных финальных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)
@riverpod
FinalDocumentRemoteDataSource finalDocumentRemoteDataSource(FinalDocumentRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return FinalDocumentRemoteDataSource(dio, baseUrl: config.baseUrl);
}

