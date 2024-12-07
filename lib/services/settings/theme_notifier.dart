// import 'package:flutter/material.dart';
// import 'package:geo_track/utils/dark_theme.dart';
// import 'package:geo_track/utils/light_theme.dart';

// enum AppTheme { system, light, dark }

// extension AppThemeExtension on AppTheme {
//   String get name {
//     switch (this) {
//       case AppTheme.light:
//         return 'Light';
//       case AppTheme.dark:
//         return 'Dark';
//       case AppTheme.system:
//       default:
//         return 'System Default';
//     }
//   }
// }

// class ThemeNotifier with ChangeNotifier {
//   AppTheme _currentTheme = AppTheme.system;

//   ThemeNotifier() {
//     // _loadTheme();
//   }

//   AppTheme get currentTheme => _currentTheme;

//   // Rename the getters to avoid conflicts with imported theme variables
//   ThemeData get customLightTheme => lightTheme;
//   ThemeData get customDarkTheme => darkTheme;

//   void setTheme(AppTheme theme) {
//     _currentTheme = theme;
//     // _saveTheme(theme);
//     notifyListeners();
//   }

//   ThemeMode get themeMode {
//     switch (_currentTheme) {
//       case AppTheme.light:
//         return ThemeMode.light;
//       case AppTheme.dark:
//         return ThemeMode.dark;
//       default:
//         return ThemeMode.system;
//     }
//   }

//   // void _loadTheme() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   int themeIndex = prefs.getInt('theme') ?? 0;
//   //   _currentTheme = AppTheme.values[themeIndex];
//   //   notifyListeners();
//   // }

//   // void _saveTheme(AppTheme theme) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setInt('theme', theme.index);
//   // }
// }

import 'package:flutter/material.dart';
import 'package:geo_track/utils/dark_theme.dart';
import 'package:geo_track/utils/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:geo_track/services/providers/map_type_provider.dart';

enum AppTheme { system, light, dark }

extension AppThemeExtension on AppTheme {
  String get name {
    switch (this) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.system:
      default:
        return 'System Default';
    }
  }
}

class ThemeNotifier with ChangeNotifier {
  AppTheme _currentTheme = AppTheme.system;
  AppTheme get currentTheme => _currentTheme;

  ThemeData get customLightTheme => lightTheme;
  ThemeData get customDarkTheme => darkTheme;

  void setTheme(AppTheme theme, BuildContext context) {
    _currentTheme = theme;
    notifyListeners();

    // Get MapTypeProvider and update the map type based on the selected theme
    final brightness = theme == AppTheme.dark
        ? Brightness.dark
        : (theme == AppTheme.light ? Brightness.light : MediaQuery.platformBrightnessOf(context));

    context.read<MapTypeProvider>().updateMapTypeBasedOnTheme(brightness);
  }

  ThemeMode get themeMode {
    switch (_currentTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
