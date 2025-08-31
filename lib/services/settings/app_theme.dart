enum AppTheme {
  light,
  dark,
  system,
  // Add more themes as needed
}


extension AppThemeExtension on AppTheme {
  String get name {
    switch (this) {
      case AppTheme.system:
        return "System";
      case AppTheme.light:
        return "Light";
      case AppTheme.dark:
        return "Dark";
      // Add more cases for additional themes
      default:
        return "Unknown";
    }
  }
} 