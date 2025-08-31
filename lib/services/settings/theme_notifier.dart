import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geo_track/services/settings/app_theme.dart';
import 'package:geo_track/utils/light_theme.dart';
import 'package:geo_track/utils/dark_theme.dart';

class ThemeNotifier with ChangeNotifier {
  static const String _themeKey = 'theme_key';
  static const String _themeTypeKey = 'theme_type_key';
  ThemeData _currentTheme;
  bool _isDarkMode;
  AppTheme _themeType;

  ThemeNotifier()
      : _isDarkMode = false,
        _themeType = AppTheme.system,
        _currentTheme = ThemeData.light() {
    _loadTheme();
  }

  AppTheme get themeType => _themeType;

  ThemeData get currentTheme => _currentTheme;

  String get name =>
      _currentTheme.brightness == Brightness.dark ? "Dark" : "Light";

  ThemeData get customLightTheme => lightTheme;

  ThemeData get customDarkTheme => darkTheme;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    _saveTheme();
    notifyListeners();
  }

  void setTheme(AppTheme theme, BuildContext context) {
    _themeType = theme;
    switch (theme) {
      case AppTheme.system:
        initSystemTheme();
        break;
      case AppTheme.dark:
        _isDarkMode = true;
        _currentTheme = ThemeData.dark();
        break;
      case AppTheme.light:
        _isDarkMode = false;
        _currentTheme = ThemeData.light();
        break;
    }
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeType =
        AppTheme.values[prefs.getInt(_themeTypeKey) ?? AppTheme.system.index];
    if (_themeType == AppTheme.system) {
      initSystemTheme();
    } else {
      _isDarkMode = _themeType == AppTheme.dark;
      _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    }
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeTypeKey, _themeType.index);
  }

  void updateThemeBasedOnSystem(BuildContext context) {
    var brightness = MediaQuery.platformBrightnessOf(context);
    _isDarkMode = brightness == Brightness.dark;
    _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void initSystemTheme() {
    // Add listener for platform brightness changes
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      if (_themeType == AppTheme.system) {
        var brightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        _isDarkMode = brightness == Brightness.dark;
        _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
        notifyListeners();
      }
    };

    // Initial theme setup
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _isDarkMode = brightness == Brightness.dark;
    _currentTheme = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void updateThemeMode() {
    final window = WidgetsBinding.instance.window;
    final brightness = window.platformBrightness;
    notifyListeners();
  }

  @override
  void dispose() {
    SchedulerBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        null;
    super.dispose();
  }
}
