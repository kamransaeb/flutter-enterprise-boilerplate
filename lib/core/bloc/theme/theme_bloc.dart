import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/themes/app_theme.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

part 'theme_bloc.freezed.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LoggerService _logger;
  final LocalStorage _localStorage;
  
  static const String _themeStatusKey = 'app_theme_status';
  static const String _dynamicColorKey = 'dynamic_color';
  static const String _fontSizeKey = 'font_size_scale';
  static const String _highContrastKey = 'high_contrast';

  ThemeBloc({
    @Named('hive_storage') required LocalStorage localStorage,
    required LoggerService logger,
  })  : _localStorage = localStorage,
        _logger = logger,
       
        super(ThemeState.initial()) {
    on<_EventLoaded>(_onEventLoaded);
    on<_EventChanged>(_onEventChanged);
    on<_EventToggleRequested>(_onEventToggleRequested);
    on<_EventDynamicColorToggled>(_onEventDynamicColorToggled);
    on<_EventFontSizeScaled>(_onEventFontSizeScaled);
    on<_EventHighContrastToggled>(_onEventHighContrastToggled);
    on<_EventResetToDefault>(_onEventResetToDefault);
    
    add(const ThemeEvent.loaded());
  }

  Future<void> _onEventLoaded(
    _EventLoaded event,
    Emitter<ThemeState> emit,
  ) async {
    _logger.d('ThemeBloc: Loading saved theme preferences');
    
    try {
      final savedThemeStatus = await _getSavedThemeStatus();
      final savedDynamicColor = await _getSavedDynamicColor();
      final savedFontSize = await _getSavedFontSize();
      final savedHighContrast = await _getSavedHighContrast();
      
      emit(state.copyWith(
        currentThemeStatus: savedThemeStatus,
        useDynamicColor: savedDynamicColor,
        fontSizeScale: savedFontSize,
        highContrast: savedHighContrast,
      ));
      
      _logger.i('ThemeBloc: Theme loaded - ${savedThemeStatus.displayName}');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error loading theme', 
          error: error, stackTrace: stackTrace);
      // Keep initial state on error
    }
  }

  Future<void> _onEventChanged(
    _EventChanged event,
    Emitter<ThemeState> emit,
  ) async {
    _logger.i('ThemeBloc: Changing theme to ${event.themeStatus.displayName}');
    
    try {
      await _saveThemeStatus(event.themeStatus);
      emit(state.copyWith(currentThemeStatus: event.themeStatus));
      _logger.d('ThemeBloc: Theme changed successfully');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error saving theme', 
          error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _onEventToggleRequested(
    _EventToggleRequested event,
    Emitter<ThemeState> emit,
  ) async {
    final newThemeStatus = _getNextThemeStatus(state.currentThemeStatus);
    _logger.d('ThemeBloc: Toggling theme to ${newThemeStatus.displayName}');
    add(ThemeEvent.changed(themeStatus: newThemeStatus));
  }

  Future<void> _onEventDynamicColorToggled(
    _EventDynamicColorToggled event,
    Emitter<ThemeState> emit,
  ) async {
    _logger.d('ThemeBloc: Setting dynamic color to ${event.enabled}');
    
    try {
      await _saveDynamicColor(event.enabled);
      emit(state.copyWith(useDynamicColor: event.enabled));
      _logger.d('ThemeBloc: Dynamic color updated');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error saving dynamic color setting',
          error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _onEventFontSizeScaled(
    _EventFontSizeScaled event,
    Emitter<ThemeState> emit,
  ) async {
    final clampedScale = event.scale.clamp(0.8, 1.5);
    _logger.d('ThemeBloc: Scaling font size to $clampedScale');
    
    try {
      await _saveFontSize(clampedScale);
      emit(state.copyWith(fontSizeScale: clampedScale));
        _logger.d('ThemeBloc: Font size updated');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error saving font size setting',
          error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _onEventHighContrastToggled(
    _EventHighContrastToggled event,
    Emitter<ThemeState> emit,
  ) async {
    _logger.d('ThemeBloc: Setting high contrast to ${event.enabled}');
    
    try {
      await _saveHighContrast(event.enabled);
      emit(state.copyWith(highContrast: event.enabled));
      _logger.d('ThemeBloc: High contrast updated');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error saving high contrast setting',
          error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _onEventResetToDefault(
    _EventResetToDefault event,
    Emitter<ThemeState> emit,
  ) async {
    _logger.i('ThemeBloc: Resetting theme to default');
    
    try {
      await _clearThemeSettings();
      emit(const ThemeState.initial());
      _logger.d('ThemeBloc: Theme reset successfully');
    } catch (error, stackTrace) {
      _logger.e('ThemeBloc: Error resetting theme',
          error: error, stackTrace: stackTrace);
    }
  }

  // MARK: - Private Helper Methods

  AppThemeStatus _getNextThemeStatus(AppThemeStatus currentThemeStatus) {
    switch (currentThemeStatus) {
      case AppThemeStatus.light:
        return AppThemeStatus.dark;
      case AppThemeStatus.dark:
        return AppThemeStatus.system;
      case AppThemeStatus.system:
        return AppThemeStatus.light;
    }
  }

  Future<AppThemeStatus> _getSavedThemeStatus() async {
    final themeString = await _localStorage.read<String>(_themeStatusKey);
    if (themeString != null) {
      return AppThemeStatus.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => AppThemeStatus.system,
      );
    }
    return AppThemeStatus.system;
  }

  Future<bool> _getSavedDynamicColor() async {
    return await _localStorage.read<bool>(_dynamicColorKey) ?? false;
  }

  Future<double> _getSavedFontSize() async {
    return await _localStorage.read<double>(_fontSizeKey) ?? 1.0;
  }

  Future<bool> _getSavedHighContrast() async {
    return await _localStorage.read<bool>(_highContrastKey) ?? false;
  }

  Future<void> _saveThemeStatus(AppThemeStatus themeStatus) async {
    await _localStorage.write(_themeStatusKey, themeStatus.toString());
  }

  Future<void> _saveDynamicColor(bool enabled) async {
    await _localStorage.write(_dynamicColorKey, enabled);
  }

  Future<void> _saveFontSize(double scale) async {
    await _localStorage.write(_fontSizeKey, scale);
  }

  Future<void> _saveHighContrast(bool enabled) async {
    await _localStorage.write(_highContrastKey, enabled);
  }

  Future<void> _clearThemeSettings() async {
    await _localStorage.delete(_themeStatusKey);
    await _localStorage.delete(_dynamicColorKey);
    await _localStorage.delete(_fontSizeKey);
    await _localStorage.delete(_highContrastKey);
  }
}