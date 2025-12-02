import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:mosstroinform_mobile/core/constants/app_constants.dart';
import 'package:mosstroinform_mobile/core/network/dio_provider.dart';
import 'package:mosstroinform_mobile/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mosstroinform_mobile/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:mosstroinform_mobile/features/chat/domain/repositories/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_data_providers.g.dart';

/// Провайдер для Retrofit источника данных чатов
@riverpod
ChatRemoteDataSource chatRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ChatRemoteDataSource(dio, baseUrl: AppConstants.baseUrl);
}

/// Провайдер для репозитория чатов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
@riverpod
ChatRepository chatRepository(Ref ref) {
  if (AppConstants.useMocks) {
    return MockChatRepository();
  }
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: remoteDataSource);
}

