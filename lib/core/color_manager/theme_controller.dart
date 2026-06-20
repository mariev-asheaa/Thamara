import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:thamara/core/constants/app_cached.dart';

import '../locals/shared_preferences.dart';

@lazySingleton
class ThemeController {
  ThemeController(this._prefs);

  final SharedPrefServices _prefs;

  final ValueNotifier<ThemeMode> themeMode =
  ValueNotifier(ThemeMode.light);

  bool isDark = false;

  Future<void> init() async {
    final saved = _prefs.getData(key:  AppCached.isDarkMode) ?? false;

    isDark = saved;

    themeMode.value =
    isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle(bool value) async {
    isDark = value;

    themeMode.value =
    value ? ThemeMode.dark : ThemeMode.light;

    await _prefs.saveData( AppCached.isDarkMode, value);
  }
}
