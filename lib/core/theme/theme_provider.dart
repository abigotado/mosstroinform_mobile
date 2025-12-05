import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Ключ для хранения выбранной темы в Hive
const String _themeModeKey = 'theme_mode';

/// Провайдер для управления темой приложения
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    // Загружаем сохраненную тему из Hive или используем системную по умолчанию
    try {
      final settingsBox = Hive.box('settings');
      final savedThemeMode = settingsBox.get(_themeModeKey) as String?;
      
      if (savedThemeMode != null) {
        switch (savedThemeMode) {
          case 'light':
            return ThemeMode.light;
          case 'dark':
            return ThemeMode.dark;
          case 'system':
            return ThemeMode.system;
        }
      }
    } catch (_) {
      // Если Hive не инициализирован или произошла ошибка, используем системную тему
    }
    
    return ThemeMode.system;
  }

  /// Установить тему
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    
    // Сохраняем выбор в Hive
    try {
      Box settingsBox;
      if (Hive.isBoxOpen('settings')) {
        settingsBox = Hive.box('settings');
      } else {
        settingsBox = await Hive.openBox('settings');
      }
      
      String themeModeString;
      switch (mode) {
        case ThemeMode.light:
          themeModeString = 'light';
          break;
        case ThemeMode.dark:
          themeModeString = 'dark';
          break;
        case ThemeMode.system:
          themeModeString = 'system';
          break;
      }
      
      await settingsBox.put(_themeModeKey, themeModeString);
    } catch (e) {
      // Игнорируем ошибки сохранения, тема все равно будет работать
      debugPrint('Ошибка сохранения темы: $e');
    }
  }
}

