import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/datasources/construction_site_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/repositories/construction_site_repository_impl.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/repositories/mock_construction_site_repository.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'construction_site_data_providers.g.dart';

/// Провайдер для Retrofit источника данных строительной площадки
@riverpod
ConstructionSiteRemoteDataSource constructionSiteRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ConstructionSiteRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}

/// Провайдер для репозитория строительной площадки
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
@riverpod
ConstructionSiteRepository constructionSiteRepository(Ref ref) {
  if (AppConstants.useMocks) {
    return MockConstructionSiteRepository();
  }
  final remoteDataSource =
      ref.watch(constructionSiteRemoteDataSourceProvider);
  return ConstructionSiteRepositoryImpl(remoteDataSource: remoteDataSource);
}

