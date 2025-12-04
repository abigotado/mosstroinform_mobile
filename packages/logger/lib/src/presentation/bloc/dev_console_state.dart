import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:logger/src/domain/domain.dart';

part 'dev_console_state.freezed.dart';

@freezed
abstract class DevConsoleState with _$DevConsoleState {
  const factory DevConsoleState({
    required DebugInfoEntity debugInfoState,
    required AppLoggerOutputMode loggerOutputMode,
  }) = _DevConsoleState;
}
