import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/providers/construction_object_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/construction_object_repository_impl.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/mock_construction_object_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/construction_object_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'construction_object_repository_provider.g.dart';

/// Провайдер для репозитория объектов строительства
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
/// keepAlive: true - репозиторий не должен быть disposed при перестроении виджетов
@Riverpod(keepAlive: true)
ConstructionObjectRepository constructionObjectRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockConstructionObjectRepository();
  }
  final remoteDataSource = ref.watch(constructionObjectRemoteDataSourceProvider);
  return ConstructionObjectRepositoryImpl(remoteDataSource: remoteDataSource);
}

