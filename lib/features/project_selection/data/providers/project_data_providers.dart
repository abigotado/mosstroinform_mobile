import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/datasources/project_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/mock_project_repository.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/repositories/project_repository_impl.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_data_providers.g.dart';

/// Провайдер для Retrofit источника данных
@riverpod
ProjectRemoteDataSource projectRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProjectRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}

/// Провайдер для репозитория проектов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
@riverpod
ProjectRepository projectRepository(Ref ref) {
  if (AppConstants.useMocks) {
    return MockProjectRepository();
  }
  final remoteDataSource = ref.watch(projectRemoteDataSourceProvider);
  return ProjectRepositoryImpl(remoteDataSource: remoteDataSource);
}
