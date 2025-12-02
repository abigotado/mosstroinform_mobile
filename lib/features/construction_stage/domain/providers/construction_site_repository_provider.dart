import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/providers/construction_site_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/repositories/construction_site_repository_impl.dart';
import 'package:mosstroinform_mobile/features/construction_stage/data/repositories/mock_construction_site_repository.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';

part 'construction_site_repository_provider.g.dart';

/// Провайдер для репозитория строительной площадки
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
@riverpod
ConstructionSiteRepository constructionSiteRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  debugPrint('=== constructionSiteRepositoryProvider ===');
  debugPrint('useMocks: ${config.useMocks}');
  if (config.useMocks) {
    debugPrint('Используем MockConstructionSiteRepository');
    return MockConstructionSiteRepository();
  }
  debugPrint('Используем ConstructionSiteRepositoryImpl');
  final remoteDataSource = ref.watch(constructionSiteRemoteDataSourceProvider);
  return ConstructionSiteRepositoryImpl(remoteDataSource: remoteDataSource);
}

