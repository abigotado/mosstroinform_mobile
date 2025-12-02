// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatsNotifierHash() => r'802b79b0c20aa52f31b4223ba0f30313cdb7758b';

/// Notifier для управления состоянием списка чатов
///
/// Copied from [ChatsNotifier].
@ProviderFor(ChatsNotifier)
final chatsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ChatsNotifier, ChatsState>.internal(
      ChatsNotifier.new,
      name: r'chatsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$chatsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ChatsNotifier = AutoDisposeAsyncNotifier<ChatsState>;
String _$messagesNotifierHash() => r'5f1c5e7e51409b1969fe7c17f1b5077b0ed0266a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessagesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<MessagesState> {
  late final String chatId;

  FutureOr<MessagesState> build(String chatId);
}

/// Notifier для управления состоянием сообщений чата
///
/// Copied from [MessagesNotifier].
@ProviderFor(MessagesNotifier)
const messagesNotifierProvider = MessagesNotifierFamily();

/// Notifier для управления состоянием сообщений чата
///
/// Copied from [MessagesNotifier].
class MessagesNotifierFamily extends Family<AsyncValue<MessagesState>> {
  /// Notifier для управления состоянием сообщений чата
  ///
  /// Copied from [MessagesNotifier].
  const MessagesNotifierFamily();

  /// Notifier для управления состоянием сообщений чата
  ///
  /// Copied from [MessagesNotifier].
  MessagesNotifierProvider call(String chatId) {
    return MessagesNotifierProvider(chatId);
  }

  @override
  MessagesNotifierProvider getProviderOverride(
    covariant MessagesNotifierProvider provider,
  ) {
    return call(provider.chatId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesNotifierProvider';
}

/// Notifier для управления состоянием сообщений чата
///
/// Copied from [MessagesNotifier].
class MessagesNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<MessagesNotifier, MessagesState> {
  /// Notifier для управления состоянием сообщений чата
  ///
  /// Copied from [MessagesNotifier].
  MessagesNotifierProvider(String chatId)
    : this._internal(
        () => MessagesNotifier()..chatId = chatId,
        from: messagesNotifierProvider,
        name: r'messagesNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$messagesNotifierHash,
        dependencies: MessagesNotifierFamily._dependencies,
        allTransitiveDependencies:
            MessagesNotifierFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  MessagesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  FutureOr<MessagesState> runNotifierBuild(
    covariant MessagesNotifier notifier,
  ) {
    return notifier.build(chatId);
  }

  @override
  Override overrideWith(MessagesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessagesNotifierProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MessagesNotifier, MessagesState>
  createElement() {
    return _MessagesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesNotifierProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessagesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<MessagesState> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _MessagesNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<MessagesNotifier, MessagesState>
    with MessagesNotifierRef {
  _MessagesNotifierProviderElement(super.provider);

  @override
  String get chatId => (origin as MessagesNotifierProvider).chatId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
