import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mosstroinform_mobile/core/config/app_config_provider.dart';
import 'package:mosstroinform_mobile/features/chat/data/providers/chat_data_source_provider.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';

part 'chat_repository_provider.g.dart';

/// Провайдер для репозитория чатов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
/// Находится в domain слое, так как предоставляет доступ к интерфейсу репозитория
@riverpod
ChatRepository chatRepository(Ref ref) {
  final config = ref.watch(appConfigSimpleProvider);
  if (config.useMocks) {
    return MockChatRepository();
  }
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: remoteDataSource);
}

