import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Observer для Riverpod, который логирует изменения провайдеров в Talker
final class TalkerRiverpodObserver extends ProviderObserver {
  TalkerRiverpodObserver(this.talker);

  final Talker talker;

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    super.didAddProvider(context, value);
    talker.logCustom(
      TalkerProviderLog(
        context: context,
        action: 'Added',
        value: value,
      ),
    );
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    super.didDisposeProvider(context);
    talker.logCustom(
      TalkerProviderLog(
        context: context,
        action: 'Disposed',
      ),
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    super.didUpdateProvider(context, previousValue, newValue);
    talker.logCustom(
      TalkerProviderLog(
        context: context,
        action: 'Updated',
        previousValue: previousValue,
        value: newValue,
      ),
    );
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    super.providerDidFail(context, error, stackTrace);
    final provider = context.provider;
    talker.error(
      'Provider failed: ${provider.name ?? provider.runtimeType}',
      error,
      stackTrace,
    );
  }
}

/// Кастомный лог для провайдеров Riverpod
class TalkerProviderLog extends TalkerLog {
  TalkerProviderLog({
    required ProviderObserverContext context,
    required String action,
    Object? value,
    Object? previousValue,
  }) : super(_createMessage(context, action, value, previousValue));

  @override
  AnsiPen get pen => AnsiPen()..xterm(200);

  @override
  String get key => 'riverpod_provider';

  static String _createMessage(
    ProviderObserverContext context,
    String action,
    Object? value,
    Object? previousValue,
  ) {
    final provider = context.provider;
    final buffer = StringBuffer()
      ..write('Provider $action: ')
      ..write(provider.name ?? provider.runtimeType);

    if (previousValue != null) {
      buffer.write('\nPrevious: $previousValue');
    }
    if (value != null) {
      buffer.write('\nNew: $value');
    }

    return buffer.toString();
  }
}
