import 'package:logger/src/app_logger.dart';
import 'package:logger/src/data/dev_console_repository.dart';
import 'package:logger/src/domain/entity/entity.dart';
import 'package:logger/src/domain/repository/dev_console_repository_i.dart';
import 'package:logger/src/mixin/mixin.dart';
import 'package:logger/src/presentation/bloc/dev_console_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dev_console_notifier.g.dart';

/// Notifier для управления состоянием dev console
@riverpod
class DevConsoleNotifier extends _$DevConsoleNotifier with LogErrorMixin {
  @override
  Future<DevConsoleState> build() async {
    final repository = ref.read(devConsoleRepositoryProvider);
    final debugInfo = await repository.fetchDebugInfo();

    return DevConsoleState(
      debugInfoState: debugInfo,
      loggerOutputMode: AppLogger.outputMode,
    );
  }

  /// Загрузить информацию для отладки
  Future<void> fetchDebugInfo() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(devConsoleRepositoryProvider);
      final debugInfo = await repository.fetchDebugInfo();

      state = AsyncValue.data(state.value!.copyWith(debugInfoState: debugInfo));
    } catch (e, s) {
      logError(e, stackTrace: s, methodName: 'fetchDebugInfo');
      state = AsyncValue.data(
        state.value!.copyWith(
          debugInfoState: DebugInfoEntityError(e.toString()),
        ),
      );
    }
  }

  /// Переключить режим вывода логгера
  void toggleLoggerOutputMode() {
    final currentState = state.value;
    if (currentState == null) return;

    final mode = switch (currentState.loggerOutputMode) {
      AppLoggerOutputMode.compact => AppLoggerOutputMode.full,
      AppLoggerOutputMode.full => AppLoggerOutputMode.compact,
    };

    AppLogger.setOutputMode(mode);
    state = AsyncValue.data(currentState.copyWith(loggerOutputMode: mode));
  }

  @override
  String get className => 'DevConsoleNotifier';
}

/// Провайдер репозитория для dev console
@riverpod
IDevConsoleRepository devConsoleRepository(Ref ref) {
  return DevConsoleRepository();
}
