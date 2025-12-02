// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRemoteDataSourceHash() =>
    r'eb8965a26ddc8f2da8c6c4e5c973bd113acca664';

/// Провайдер для Retrofit источника данных чатов
/// Находится в data слое, так как зависит от реализации (Retrofit)
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
