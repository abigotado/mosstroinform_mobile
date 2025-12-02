import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/datasources/construction_site_remote_data_source.dart';

part 'construction_site_data_source_provider.g.dart';

/// Провайдер для Retrofit источника данных строительной площадки
/// Находится в data слое, так как зависит от реализации (Retrofit)
@riverpod
ConstructionSiteRemoteDataSource constructionSiteRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  final config = ref.watch(appConfigSimpleProvider);
  return ConstructionSiteRemoteDataSource(dio, baseUrl: config.baseUrl);
}

