import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/storage/secure_storage_provider.dart';
import 'package:mosstroinform_mobile/features/auth/data/providers/auth_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mosstroinform_mobile/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:mosstroinform_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

/// Провайдер репозитория авторизации
/// Возвращает mock или реальную реализацию в зависимости от конфигурации
@riverpod
AuthRepository authRepository(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  
  if (AppConstants.useMocks) {
    return MockAuthRepository(secureStorage: secureStorage);
  }
  
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    secureStorage: secureStorage,
  );
}

