import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/document_approval/data/datasources/document_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_data_source_provider.g.dart';

/// Провайдер для Retrofit источника данных документов
/// Находится в data слое, так как зависит от реализации (Retrofit)
@riverpod
DocumentRemoteDataSource documentRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return DocumentRemoteDataSource(dio, baseUrl: config.baseUrl);
}
