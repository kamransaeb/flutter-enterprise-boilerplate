part of 'locale_bloc.dart';

@freezed
class LocaleState with _$LocaleState {
  const LocaleState._();

  const factory LocaleState.initial() = _StateInitial;
  const factory LocaleState.loading({Locale? previousLocale}) = _StateLoading;

  factory LocaleState.loaded({
    required Locale locale,
    @Default(AppConstants.supportedLocales) List<Locale> supportedLocales,
    @Default(AppConstants.fallbackLocale) Locale fallbackLocale,
  }) = _StateLoaded;

  const factory LocaleState.failure({
    required String message,
    Locale? lastLocale,
  }) = _StateFailure;

  // ---- Convenience Methods ----
  Locale get locale => maybeWhen(
    loaded: (locale, _, __) => locale,
    loading: (previous) => previous ?? AppConstants.defaultLocale,
    failure: (_, lastLocale) => lastLocale ?? AppConstants.defaultLocale,
    orElse: () => AppConstants.defaultLocale,
  );

  List<Locale> get supportedLocales => maybeWhen(
    loaded: (_, supportedLocales, __) => supportedLocales,
    orElse: () => AppConstants.supportedLocales,
  );

  Locale get fallbackLocale => maybeWhen(
    loaded: (_, __, fallbackLocale) => fallbackLocale,
    orElse: () => AppConstants.fallbackLocale,
  );

  String? get errorMessage =>
      maybeWhen(failure: (message, _) => message, orElse: () => null);

  String get languageCode => locale.languageCode;
  String get countryCode => locale.countryCode ?? '';
  String get displayName => _getDisplayName(locale);

  bool get isInitial => maybeWhen(initial: () => true, orElse: () => false);
  bool get isLoading => maybeWhen(loading: (_) => true, orElse: () => false);
  bool get isLoaded => maybeWhen(loaded: (_, __, ___) => true, orElse: () => false);
  bool get isFailure => maybeWhen(failure: (_, __) => true, orElse: () => false);

  bool get isSuccess => isLoaded;
  bool get hasError => isFailure;

  String _getDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
