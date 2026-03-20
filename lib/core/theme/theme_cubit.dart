import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._storage) : super(_loadSavedTheme(_storage));

  final LocalStorageService _storage;

  static const _themeKey = 'theme_mode';

  static ThemeMode _loadSavedTheme(LocalStorageService storage) {
    final saved = storage.readSetting<String>(_themeKey);
    return switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  bool get isDark => state == ThemeMode.dark;

  void toggleTheme() => setTheme(isDark ? ThemeMode.light : ThemeMode.dark);

  void setTheme(ThemeMode mode) {
    _storage.saveSetting(_themeKey, mode.name);
    emit(mode);
  }
}
