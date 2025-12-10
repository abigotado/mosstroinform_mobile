import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/l10n/generated/l10n.dart';
import 'package:logger/src/app_logger.dart';
import 'package:logger/src/domain/domain.dart';
import 'package:logger/src/presentation/notifier/dev_console_notifier.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DevConsoleScreen extends ConsumerWidget {
  const DevConsoleScreen({super.key});

  static const _talkerScreenTheme = TalkerScreenTheme();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final s = LoggerL10n.of(context);
    final stateAsync = ref.watch(devConsoleProvider);

    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primaryContainer: Colors.purple,
        ),
      ),
      child: Scaffold(
        endDrawer: Drawer(
          backgroundColor: _talkerScreenTheme.backgroundColor,
          child: SafeArea(
            child: stateAsync.when(
              data: (state) {
                final debugInfo = state.debugInfoState;
                return switch (debugInfo) {
                  DebugInfoEntityLoading() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  final DebugInfoEntityData data => DefaultTextStyle(
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: _talkerScreenTheme.textColor,
                    ),
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
                          Text(
                            '${s.devConsoleDebugInfoAppVersion}: ${data.appVersion}',
                          ),
                          Text(
                            '${s.devConsoleDebugInfoAppBuildNumber}: ${data.appBuildNumber}',
                          ),
                          Text(
                            '${s.devConsoleDebugInfoFlavor}: ${data.flavor}',
                          ),
                          Text(
                            '${s.devConsoleDebugInfoDeviceModel}: ${data.deviceModel}',
                          ),
                          Text(
                            '${s.devConsoleDebugInfoDeviceOS}: ${data.deviceOS}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  _ => Center(child: Text(s.devConsoleDebugInfoNoData)),
                };
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ),
        body: stateAsync.when(
          data: (state) => TalkerScreen(
            appBarTitle: s.devConsoleTitle,
            talker: AppLogger.talker,
            appBarLeading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            customSettings: [
              CustomSettingsGroup(
                title: s.devConsoleLogsFullMode,
                enabled: state.loggerOutputMode == AppLoggerOutputMode.full,
                onToggleEnabled: (_) => ref
                    .read(devConsoleProvider.notifier)
                    .toggleLoggerOutputMode(),
              ),
            ],
          ),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
