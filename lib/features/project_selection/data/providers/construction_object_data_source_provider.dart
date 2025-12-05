import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/datasources/construction_object_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/datasources/construction_object_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'construction_object_data_source_provider.g.dart';

/// Провайдер для удалённого источника данных объектов строительства
@riverpod
IConstructionObjectRemoteDataSource constructionObjectRemoteDataSource(
  Ref ref,
) {
  final config = ref.watch(appConfigSimpleProvider);
  final dio = ref.watch(dioProvider);
  return ConstructionObjectRemoteDataSource(
    dio,
    baseUrl: config.baseUrl,
  );
}

