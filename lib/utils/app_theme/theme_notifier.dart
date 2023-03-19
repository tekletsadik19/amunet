import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {

  ThemeMode themeMode = ThemeMode.light;
  SharedPreferences? prefs;

  ThemeNotifier() {
    _init();
  }

  _init() async {
    prefs = await SharedPreferences.getInstance();
    int _theme = prefs?.getInt("theme") ?? themeMode.index;
    themeMode = ThemeMode.values[_theme];
    notifyListeners();
  }

  toggleTheme(){
    (themeMode == ThemeMode.light) ?
    themeMode = ThemeMode.dark:themeMode = ThemeMode.light;
    setTheme(themeMode);
  }
  setTheme(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
    prefs?.setInt("theme", mode.index);
  }

}