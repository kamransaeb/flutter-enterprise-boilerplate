part of 'theme_bloc.dart';

enum AppThemeStatus {
  light,
  dark,
  system,
}

extension AppThemeExtension on AppThemeStatus {
  String get displayName {
    switch (this) {
      case AppThemeStatus.light:
        return 'Light';
      case AppThemeStatus.dark:
        return 'Dark';
      case AppThemeStatus.system:
        return 'System Default';
    }
  }

  IconData get icon {
    switch (this) {
      case AppThemeStatus.light:
        return Icons.light_mode;
      case AppThemeStatus.dark:
        return Icons.dark_mode;
      case AppThemeStatus.system:
        return Icons.settings;
    }
  }

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeStatus.light:
        return ThemeMode.light;
      case AppThemeStatus.dark:
        return ThemeMode.dark;
      case AppThemeStatus.system:
        return ThemeMode.system;
    }
  }
}

@freezed
abstract class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState.initial({
  @Default(AppThemeStatus.system) AppThemeStatus currentThemeStatus,
  @Default(false) bool useDynamicColor, // Material You
  @Default(1.0) double fontSizeScale,
  @Default(false) bool highContrast,
  }) = _StateInitial;
  

  bool get isLightTheme => 
      currentThemeStatus == AppThemeStatus.light ||
      (currentThemeStatus == AppThemeStatus.system && 
       WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light);
  
  bool get isDarkTheme => currentThemeStatus == AppThemeStatus.dark ||
      (currentThemeStatus == AppThemeStatus.system &&
       WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

}