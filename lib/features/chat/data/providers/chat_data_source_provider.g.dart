// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер для Retrofit источника данных чатов
/// Находится в data слое, так как зависит от реализации (Retrofit)

@ProviderFor(chatRemoteDataSource)
const chatRemoteDataSourceProvider = ChatRemoteDataSourceProvider._();

/// Провайдер для Retrofit источника данных чатов
/// Находится в data слое, так как зависит от реализации (Retrofit)

final class ChatRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ChatRemoteDataSource,
          ChatRemoteDataSource,
          ChatRemoteDataSource
        >
    with $Provider<ChatRemoteDataSource> {
  /// Провайдер для Retrofit источника данных чатов
  /// Находится в data слое, так как зависит от реализации (Retrofit)
  const ChatRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ChatRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatRemoteDataSource create(Ref ref) {
    return chatRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRemoteDataSource>(value),
    );
  }
}

String _$chatRemoteDataSourceHash() =>
    r'6c9c4a9d3955dedd0b17a6a44a7e48b1a6e0ddf5';
