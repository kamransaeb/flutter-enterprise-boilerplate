part of 'theme_bloc.dart';

@freezed
abstract class ThemeEvent with _$ThemeEvent {
  const ThemeEvent._();
  
  const factory ThemeEvent.loaded() = _EventLoaded;
  
  const factory ThemeEvent.changed({
    required AppThemeStatus themeStatus,
  }) = _EventChanged;

  const factory ThemeEvent.toggleRequested() = _EventToggleRequested;

  const factory ThemeEvent.dynamicColorToggled({
    required bool enabled,
  }) = _EventDynamicColorToggled;

  const factory ThemeEvent.fontSizeScaled({
    required double scale,
  }) = _EventFontSizeScaled; 

  const factory ThemeEvent.highContrastToggled({
    required bool enabled,
  }) = _EventHighContrastToggled;

  const factory ThemeEvent.resetToDefault() = _EventResetToDefault;
}
