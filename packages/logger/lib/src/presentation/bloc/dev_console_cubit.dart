import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:logger/src/app_logger.dart';
import 'package:logger/src/domain/entity/entity.dart';
import 'package:logger/src/domain/repository/dev_console_repository_i.dart';
import 'package:logger/src/mixin/mixin.dart';
import 'package:logger/src/presentation/bloc/dev_console_state.dart';

export 'dev_console_state.dart';

@injectable
class DevConsoleCubit extends Cubit<DevConsoleState> with LogErrorMixin {
  DevConsoleCubit(this.repository)
    : super(
        DevConsoleState(
          debugInfoState: const DebugInfoEntityLoading(),
          loggerOutputMode: AppLogger.outputMode,
        ),
      );

  final IDevConsoleRepository repository;

  Future<void> fetchDebugInfo() async {
    try {
      emit(state.copyWith(debugInfoState: const DebugInfoEntityLoading()));
      final data = await repository.fetchDebugInfo();
      emit(state.copyWith(debugInfoState: data));
    } catch (e, s) {
      logError(e, stackTrace: s, methodName: 'fetchDebugInfo');
      emit(state.copyWith(debugInfoState: DebugInfoEntityError(e.toString())));
    }
  }

  void toggleLoggerOutputMode() {
    final mode = switch (state.loggerOutputMode) {
      AppLoggerOutputMode.compact => AppLoggerOutputMode.full,
      AppLoggerOutputMode.full => AppLoggerOutputMode.compact,
    };

    AppLogger.setOutputMode(mode);
    emit(state.copyWith(loggerOutputMode: mode));
  }

  @override
  String get className => 'DevConsoleCubit';
}
