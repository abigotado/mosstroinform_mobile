// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRemoteDataSourceHash() =>
    r'dee5ed0be077bceb36be662a073838f6c01166bc';

/// Провайдер для Retrofit источника данных чатов
///
/// Copied from [chatRemoteDataSource].
@ProviderFor(chatRemoteDataSource)
final chatRemoteDataSourceProvider =
    AutoDisposeProvider<ChatRemoteDataSource>.internal(
      chatRemoteDataSource,
      name: r'chatRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRemoteDataSourceRef = AutoDisposeProviderRef<ChatRemoteDataSource>;
String _$chatRepositoryHash() => r'0170993b7931fed898e2910cef20fdfd8c3e4771';

/// Провайдер для репозитория чатов
/// Возвращает интерфейс, а не имплементацию
/// Использует моковый репозиторий если включены моки, иначе реальный
///
/// Copied from [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
