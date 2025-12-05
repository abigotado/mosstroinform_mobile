import 'package:flutter/material.dart';

/// Основная тема приложения
/// Подготовлена для будущей мультитематизации
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2196F3),
        brightness: Brightness.light,
      ),
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
    );
  }

  static ThemeData get darkTheme {
    // Создаем более контрастную цветовую схему для темной темы
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF42A5F5), // Более яркий синий для лучшей видимости
      brightness: Brightness.dark,
    );
    
    // Увеличиваем контрастность всех элементов
    final darkColorScheme = baseColorScheme.copyWith(
      primary: const Color(0xFF64B5F6), // Более яркий primary цвет
      onPrimary: Colors.black, // Контрастный текст на primary
      secondary: const Color(0xFF81C784), // Более яркий secondary
      onSecondary: Colors.black,
      surface: const Color(0xFF353535), // Более светлый фон для карточек
      onSurface: Colors.white, // Более яркий текст на surface
      surfaceContainerHighest: const Color(0xFF454545), // Еще более светлый для контейнеров
      onSurfaceVariant: const Color(0xFFE0E0E0), // Более яркий вариантный текст
      outline: const Color(0xFF757575), // Более видимые границы
      outlineVariant: const Color(0xFF5A5A5A),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: _darkTextTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      iconTheme: _darkIconTheme,
      listTileTheme: _darkListTileTheme,
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
  );

  // Более контрастная тема AppBar для темной темы
  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.white, // Яркие иконки в AppBar
      opacity: 1.0,
    ),
  );

  static const CardThemeData _cardTheme = CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  // Более контрастная тема карточек для темной темы
  static const CardThemeData _darkCardTheme = CardThemeData(
    elevation: 6, // Увеличена elevation для большего контраста
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  // Более яркие иконки для темной темы
  static const IconThemeData _darkIconTheme = IconThemeData(
    color: Color(0xFFE0E0E0), // Более яркие иконки
    opacity: 1.0,
  );

  // Более контрастная тема для ListTile в темной теме
  static const ListTileThemeData _darkListTileTheme = ListTileThemeData(
    iconColor: Color(0xFFE0E0E0), // Яркие иконки в списках
    textColor: Colors.white, // Яркий текст
  );

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Более яркие кнопки для темной темы
  static ElevatedButtonThemeData get _darkElevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4, // Больше elevation для контраста
      ),
    );
  }

  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Более контрастная тема для полей ввода в темной теме
  static const InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFF757575)), // Более видимые границы
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFF757575)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFF64B5F6), width: 2), // Яркая граница при фокусе
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Более контрастный текст для темной темы
  static TextTheme get _darkTextTheme {
    return _textTheme.apply(
      bodyColor: Colors.white, // Яркий белый текст
      displayColor: Colors.white,
      decorationColor: Colors.white,
    );
  }
}
