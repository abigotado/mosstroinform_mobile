// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_settings/widgets/talker_setting_card.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheet extends StatefulWidget {
  const TalkerSettingsBottomSheet({
    required this.talkerScreenTheme,
    required this.talker,
    required this.customSettings,
    super.key,
  });

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final ValueNotifier<Talker> talker;

  /// Custom settings
  final List<CustomSettingsGroup> customSettings;

  @override
  State<TalkerSettingsBottomSheet> createState() => _TalkerSettingsBottomSheetState();
}

class _TalkerSettingsBottomSheetState extends State<TalkerSettingsBottomSheet> {
  late final listenableCustomSettings = ValueNotifier(widget.customSettings);

  @override
  void initState() {
    widget.talker.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final talker = widget.talker.value;
    final theme = Theme.of(context);
    final settings = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Talker settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      TalkerSettingsCard(
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Enabled',
        enabled: talker.settings.enabled,
        onChanged: (enabled) {
          (enabled ? talker.enable : talker.disable).call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: talker.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Use console logs',
        enabled: talker.settings.useConsoleLogs,
        onChanged: (enabled) {
          talker.configure(
            settings: talker.settings.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: talker.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Use history',
        enabled: talker.settings.useHistory,
        onChanged: (enabled) {
          talker.configure(
            settings: talker.settings.copyWith(
              useHistory: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Packages settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ...widget.talker.value.settings.registeredKeys.map(
        (key) => TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: key,
          enabled: talker.filter.disabledKeys.isEmpty || !talker.filter.disabledKeys.contains(key),
          onChanged: (enabled) => _toggleKeySelected(enabled, key),
        ),
      ),
      ...listenableCustomSettings.value.map(
        (group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  group.title,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: widget.talkerScreenTheme.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TalkerSettingsCard(
                talkerScreenTheme: widget.talkerScreenTheme,
                title: 'Enabled',
                enabled: group.enabled,
                onChanged: (val) {
                  group.onChanged.call(val);
                  widget.talker.notifyListeners();
                },
              ),
              ...group.items.map(
                (item) => TalkerSettingsCard(
                  canEdit: group.enabled,
                  enabled: item.value,
                  talkerScreenTheme: widget.talkerScreenTheme,
                  title: item.name,
                  onChanged: (val) {
                    item.onChanged(val);
                    widget.talker.notifyListeners();
                  },
                  trailing: item.widgetBuilder(
                    context,
                    item.value,
                    group.enabled,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ];

    return BaseBottomSheet(
      title: 'Settings',
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ...settings,
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _toggleKeySelected(bool enabled, String e) {
    final talker = widget.talker.value;
    final keys = talker.filter.disabledKeys.toList();
    if (!enabled) {
      keys.add(e);
    } else {
      keys.remove(e);
    }
    talker.configure(filter: talker.filter.copyWith(disabledKeys: keys));
    widget.talker.notifyListeners();
  }
}
