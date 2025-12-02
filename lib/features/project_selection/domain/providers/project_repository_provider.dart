import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/providers/project_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/mock_project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/project_repository_impl.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

part 'project_repository_provider.g.dart';

/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockProjectRepository();
  }
  final remoteDataSource = ref.watch(projectRemoteDataSourceProvider);
  return ProjectRepositoryImpl(remoteDataSource: remoteDataSource);
}

