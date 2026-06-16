import 'dart:ui';

import 'package:flutter_enterprise_boilerplate/core/constants/app_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:injectable/injectable.dart';

part 'locale_event.dart';
part 'locale_state.dart';
part 'locale_bloc.freezed.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LocalStorage _localStorage;

  LocaleBloc({@Named('shared_prefs') required LocalStorage localStorage})
    : // initializer list
      _localStorage = localStorage,
      super(const LocaleState.initial()) {
    on<_EventLoaded>(_onEventLoaded);
    on<_EventChanged>(_onEventChanged);
    on<_EventChangedByCode>(_onEventChangedByCode);
    on<_EventResetToSystem>(_onEventResetToSystem);
    on<_EventFallbackToDefault>(_onEventFallbackToDefault);
    add(const LocaleEvent.loaded());
  }

  Future<void> _onEventLoaded(
    _EventLoaded event,
    Emitter<LocaleState> emit,
  ) async {
    logger.i('LocaleBloc: Loading saved locale preferences');
    emit(LocaleState.loading(previousLocale: state.locale));
    try {
      final locale = await _getSavedLocale() ?? await _getSystemLocale();
      logger.i('LocaleBloc: Locale loaded - $locale');
      emit(LocaleState.loaded(locale: locale));
      await _saveLocale(locale);
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error loading locale',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        LocaleState.failure(
          message: error.toString(),
          lastLocale: state.locale,
        ),
      );
    }
  }

  Future<void> _onEventChanged(
    _EventChanged event,
    Emitter<LocaleState> emit,
  ) async {
    logger.i('LocaleBloc: Changing locale to ${event.locale}');
    emit(LocaleState.loading(previousLocale: state.locale));
    try {
      await _saveLocale(event.locale);
      logger.i('LocaleBloc: Locale changed successfully');
      // Update the app locale
      //await _updateAppLocale(event.locale);
      emit(LocaleState.loaded(locale: event.locale));
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error changing locale',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        LocaleState.failure(
          message: error.toString(),
          lastLocale: state.locale,
        ),
      );
    }
  }

  Future<void> _onEventChangedByCode(
    _EventChangedByCode event,
    Emitter<LocaleState> emit,
  ) async {
    logger.i('LocaleBloc: Changing locale by code to ${event.languageCode}');
    final locale = event.countryCode != null
        ? Locale(event.languageCode, event.countryCode!)
        : Locale(event.languageCode);
    emit(LocaleState.loading(previousLocale: state.locale));
    try {
      await _saveLocale(locale);
      logger.i('LocaleBloc: Locale changed successfully');
      emit(LocaleState.loaded(locale: locale));
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error changing locale by code',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        LocaleState.failure(
          message: error.toString(),
          lastLocale: state.locale,
        ),
      );
    }
  }

  Future<void> _onEventResetToSystem(
    _EventResetToSystem event,
    Emitter<LocaleState> emit,
  ) async {
    logger.i('LocaleBloc: Resetting locale to system');
    emit(LocaleState.loading(previousLocale: state.locale));
    try {
      final systemLocale = await _getSystemLocale();
      await _saveLocale(systemLocale);
      logger.i('LocaleBloc: Locale reset to system successfully');
      emit(LocaleState.loaded(locale: systemLocale));
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error resetting locale to system',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        LocaleState.failure(
          message: error.toString(),
          lastLocale: state.locale,
        ),
      );
    }
  }

  Future<void> _onEventFallbackToDefault(
    _EventFallbackToDefault event,
    Emitter<LocaleState> emit,
  ) async {
    logger.i('LocaleBloc: Falling back to default locale');
    emit(LocaleState.loading(previousLocale: state.locale));
    try {
      final defaultLocale = AppConstants.defaultLocale;
      await _saveLocale(defaultLocale);
      logger.i('LocaleBloc: Locale fallback to default successfully');
      emit(LocaleState.loaded(locale: defaultLocale));
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error falling back to default locale',
        error: error,
        stackTrace: stackTrace,
      );
      emit(
        LocaleState.failure(
          message: error.toString(),
          lastLocale: state.locale,
        ),
      );
    }
  }

  Future<Locale?> _getSavedLocale() async {
    try {
      final languageCode = await _localStorage.read<String>(
        StorageConstants.languageCodeKey,
      );
      if (languageCode == null) return null;
      final countryCode = await _localStorage.read<String>(
        StorageConstants.countryCodeKey,
      );
      return (countryCode != null)
          ? Locale(languageCode, countryCode)
          : Locale(languageCode);
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error getting saved locale',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<Locale> _getSystemLocale() async {
    try {
      // Get the system locale
      final systemLocale = PlatformDispatcher.instance.locale;
      // Check if the system locale is supported
      if (AppConstants.supportedLocales.contains(systemLocale)) {
        return systemLocale;
      }

      final isSupported = AppConstants.supportedLocales.any(
        (locale) => locale.languageCode == systemLocale.languageCode,
      );

      if (isSupported) {
        return systemLocale;
      }

      // If not, return the default locale
      return AppConstants.defaultLocale;
    } catch (error, stackTrace) {
      logger.e(
        'LocaleBloc: Error getting system locale',
        error: error,
        stackTrace: stackTrace,
      );
      return AppConstants.defaultLocale;
    }
  }

  Future<void> _saveLocale(Locale locale) async {
    await _localStorage.write(StorageConstants.localeKey, locale.toString());
    await _localStorage.write(
      StorageConstants.languageCodeKey,
      locale.languageCode,
    );
    if (locale.countryCode != null) {
      await _localStorage.write(
        StorageConstants.countryCodeKey,
        locale.countryCode,
      );
    } else {
      await _localStorage.delete(StorageConstants.countryCodeKey);
    }
  }
}
