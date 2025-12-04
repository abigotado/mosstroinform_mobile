/*
 * Copyright (C) 2025 Finharbor DOO. - All Rights Reserved
 *
 * Unauthorized copying or redistribution of this file in source and binary forms via any medium
 * is strictly prohibited.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class DevConsoleScreen extends StatelessWidget {
  const DevConsoleScreen({super.key});

  static const _talkerScreenTheme = TalkerScreenTheme();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = LoggerL10n.of(context);

    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primaryContainer: Colors.purple),
      ),
      child: Scaffold(
        endDrawer: Drawer(
          backgroundColor: _talkerScreenTheme.backgroundColor,
          child: SafeArea(
            child: BlocSelector<DevConsoleCubit, DevConsoleState, DebugInfoEntity>(
              selector: (state) => state.debugInfoState,
              builder: (context, state) => switch (state) {
                DebugInfoEntityLoading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                final DebugInfoEntityData data => DefaultTextStyle(
                  style: theme.textTheme.bodyLarge!.copyWith(color: _talkerScreenTheme.textColor),
                  child: SelectableRegion(
                    selectionControls: MaterialTextSelectionControls(),
                    child: Column(
                      spacing: 16,
                      children: [
                        DrawerHeader(
                          child: Text(
                            s.devConsoleDebugInfo,
                            style: theme.textTheme.headlineLarge!.copyWith(
                              color: _talkerScreenTheme.textColor,
                            ),
                          ),
                        ),
                        Text('${s.devConsoleDebugInfoAppVersion}: ${data.appVersion}'),
                        Text('${s.devConsoleDebugInfoAppBuildNumber}: ${data.appBuildNumber}'),
                        Text('${s.devConsoleDebugInfoFlavor}: ${data.flavor}'),
                        Text('${s.devConsoleDebugInfoDeviceModel}: ${data.deviceModel}'),
                        Text('${s.devConsoleDebugInfoDeviceOS}: ${data.deviceOS}'),
                      ],
                    ),
                  ),
                ),
                _ => Center(child: Text(s.devConsoleDebugInfoNoData)),
              },
            ),
          ),
        ),
        body: BlocSelector<DevConsoleCubit, DevConsoleState, AppLoggerOutputMode>(
          selector: (state) => state.loggerOutputMode,
          builder: (context, loggerOutputMode) => TalkerScreen(
            appBarTitle: s.devConsoleTitle,
            talker: AppLogger.talker,
            customSettings: [
              CustomSettingsGroup(
                title: s.devConsoleLogsFullMode,
                enabled: loggerOutputMode == AppLoggerOutputMode.full,
                onToggleEnabled: (_) => context.read<DevConsoleCubit>().toggleLoggerOutputMode(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
