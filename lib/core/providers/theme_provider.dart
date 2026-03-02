import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        setTheme(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setTheme(ThemeMode.light);
        break;
      case ThemeMode.system:
        setTheme(ThemeMode.light);
        break;
    }
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);
