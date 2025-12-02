import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/chat/data/datasources/chat_remote_data_source.dart';

part 'chat_data_source_provider.g.dart';

/// Провайдер для Retrofit источника данных чатов
/// Находится в data слое, так как зависит от реализации (Retrofit)
@riverpod
ChatRemoteDataSource chatRemoteDataSource(ChatRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return ChatRemoteDataSource(dio, baseUrl: config.baseUrl);
}

