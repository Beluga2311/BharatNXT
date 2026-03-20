import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorScheme.light,
        fontFamily: 'Poppins',
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: AppColorScheme.dark,
        fontFamily: 'Poppins',
      );
}

abstract final class AppColorScheme {
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1A6BCC),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD6E4FF),
    onPrimaryContainer: Color(0xFF001D45),
    secondary: Color(0xFF0D9E6B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFB8F0D8),
    onSecondaryContainer: Color(0xFF002117),
    tertiary: Color(0xFFF57C00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDDB3),
    onTertiaryContainer: Color(0xFF2D1600),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFF8F9FF),
    onSurface: Color(0xFF191C20),
    surfaceContainerHighest: Color(0xFFDDE3EA),
    onSurfaceVariant: Color(0xFF41484F),
    outline: Color(0xFF71787F),
    outlineVariant: Color(0xFFC1C7CE),
    inverseSurface: Color(0xFF2E3135),
    onInverseSurface: Color(0xFFEFF1F3),
    inversePrimary: Color(0xFFA8C8FF),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA8C8FF),
    onPrimary: Color(0xFF003272),
    primaryContainer: Color(0xFF00489E),
    onPrimaryContainer: Color(0xFFD6E4FF),
    secondary: Color(0xFF5DD4A5),
    onSecondary: Color(0xFF003826),
    secondaryContainer: Color(0xFF00513A),
    onSecondaryContainer: Color(0xFFB8F0D8),
    tertiary: Color(0xFFFFB95B),
    onTertiary: Color(0xFF4A2800),
    tertiaryContainer: Color(0xFF6A3C00),
    onTertiaryContainer: Color(0xFFFFDDB3),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF111318),
    onSurface: Color(0xFFE1E2E8),
    surfaceContainerHighest: Color(0xFF2A2D32),
    onSurfaceVariant: Color(0xFFC1C7CE),
    outline: Color(0xFF8B9198),
    outlineVariant: Color(0xFF41484F),
    inverseSurface: Color(0xFFE1E2E8),
    onInverseSurface: Color(0xFF2E3135),
    inversePrimary: Color(0xFF1A6BCC),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
