// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier для управления состоянием списка чатов

@ProviderFor(ChatsNotifier)
const chatsProvider = ChatsNotifierProvider._();

/// Notifier для управления состоянием списка чатов
final class ChatsNotifierProvider
    extends $AsyncNotifierProvider<ChatsNotifier, ChatsState> {
  /// Notifier для управления состоянием списка чатов
  const ChatsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatsNotifierHash();

  @$internal
  @override
  ChatsNotifier create() => ChatsNotifier();
}

String _$chatsNotifierHash() => r'802b79b0c20aa52f31b4223ba0f30313cdb7758b';

/// Notifier для управления состоянием списка чатов

abstract class _$ChatsNotifier extends $AsyncNotifier<ChatsState> {
  FutureOr<ChatsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ChatsState>, ChatsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatsState>, ChatsState>,
              AsyncValue<ChatsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Notifier для управления состоянием сообщений чата
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние сообщений должно сохраняться при навигации

@ProviderFor(MessagesNotifier)
const messagesProvider = MessagesNotifierFamily._();

/// Notifier для управления состоянием сообщений чата
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние сообщений должно сохраняться при навигации
final class MessagesNotifierProvider
    extends $AsyncNotifierProvider<MessagesNotifier, MessagesState> {
  /// Notifier для управления состоянием сообщений чата
  /// keepAlive: true - провайдер не должен быть disposed автоматически,
  /// так как состояние сообщений должно сохраняться при навигации
  const MessagesNotifierProvider._({
    required MessagesNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'messagesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$messagesNotifierHash();

  @override
  String toString() {
    return r'messagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MessagesNotifier create() => MessagesNotifier();

  @override
  bool operator ==(Object other) {
    return other is MessagesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messagesNotifierHash() => r'9c7e19f259a588127df352a17a604be29c4b6aa3';

/// Notifier для управления состоянием сообщений чата
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние сообщений должно сохраняться при навигации

final class MessagesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MessagesNotifier,
          AsyncValue<MessagesState>,
          MessagesState,
          FutureOr<MessagesState>,
          String
        > {
  const MessagesNotifierFamily._()
    : super(
        retry: null,
        name: r'messagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier для управления состоянием сообщений чата
  /// keepAlive: true - провайдер не должен быть disposed автоматически,
  /// так как состояние сообщений должно сохраняться при навигации

  MessagesNotifierProvider call(String chatId) =>
      MessagesNotifierProvider._(argument: chatId, from: this);

  @override
  String toString() => r'messagesProvider';
}

/// Notifier для управления состоянием сообщений чата
/// keepAlive: true - провайдер не должен быть disposed автоматически,
/// так как состояние сообщений должно сохраняться при навигации

abstract class _$MessagesNotifier extends $AsyncNotifier<MessagesState> {
  late final _$args = ref.$arg as String;
  String get chatId => _$args;

  FutureOr<MessagesState> build(String chatId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<MessagesState>, MessagesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MessagesState>, MessagesState>,
              AsyncValue<MessagesState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
