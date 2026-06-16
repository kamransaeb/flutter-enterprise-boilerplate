part of 'locale_bloc.dart';

@freezed
abstract class LocaleEvent with _$LocaleEvent {

  const LocaleEvent._();
  const factory LocaleEvent.loaded() = _EventLoaded;
  
  const factory LocaleEvent.changed({
    required Locale locale,
  }) = _EventChanged;

  const factory LocaleEvent.changedByCode({
    required String languageCode,
    String? countryCode,
  }) = _EventChangedByCode;

  const factory LocaleEvent.resetToSystem() = _EventResetToSystem;

  const factory LocaleEvent.fallbackToDefault() = _EventFallbackToDefault;
}