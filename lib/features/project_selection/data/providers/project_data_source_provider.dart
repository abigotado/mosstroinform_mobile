import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/datasources/project_remote_data_source.dart';

part 'project_data_source_provider.g.dart';

/// Провайдер для Retrofit источника данных проектов
/// Находится в data слое, так как зависит от реализации (Retrofit)
@riverpod
ProjectRemoteDataSource projectRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return ProjectRemoteDataSource(dio, baseUrl: config.baseUrl);
}

