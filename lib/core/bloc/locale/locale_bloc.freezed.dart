// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocaleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleEvent()';
}


}

/// @nodoc
class $LocaleEventCopyWith<$Res>  {
$LocaleEventCopyWith(LocaleEvent _, $Res Function(LocaleEvent) __);
}


/// Adds pattern-matching-related methods to [LocaleEvent].
extension LocaleEventPatterns on LocaleEvent {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loaded,TResult Function( Locale locale)?  changed,TResult Function( String languageCode,  String? countryCode)?  changedByCode,TResult Function()?  resetToSystem,TResult Function()?  fallbackToDefault,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventLoaded() when loaded != null:
return loaded();case _EventChanged() when changed != null:
return changed(_that.locale);case _EventChangedByCode() when changedByCode != null:
return changedByCode(_that.languageCode,_that.countryCode);case _EventResetToSystem() when resetToSystem != null:
return resetToSystem();case _EventFallbackToDefault() when fallbackToDefault != null:
return fallbackToDefault();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loaded,required TResult Function( Locale locale)  changed,required TResult Function( String languageCode,  String? countryCode)  changedByCode,required TResult Function()  resetToSystem,required TResult Function()  fallbackToDefault,}) {final _that = this;
switch (_that) {
case _EventLoaded():
return loaded();case _EventChanged():
return changed(_that.locale);case _EventChangedByCode():
return changedByCode(_that.languageCode,_that.countryCode);case _EventResetToSystem():
return resetToSystem();case _EventFallbackToDefault():
return fallbackToDefault();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loaded,TResult? Function( Locale locale)?  changed,TResult? Function( String languageCode,  String? countryCode)?  changedByCode,TResult? Function()?  resetToSystem,TResult? Function()?  fallbackToDefault,}) {final _that = this;
switch (_that) {
case _EventLoaded() when loaded != null:
return loaded();case _EventChanged() when changed != null:
return changed(_that.locale);case _EventChangedByCode() when changedByCode != null:
return changedByCode(_that.languageCode,_that.countryCode);case _EventResetToSystem() when resetToSystem != null:
return resetToSystem();case _EventFallbackToDefault() when fallbackToDefault != null:
return fallbackToDefault();case _:
  return null;

}
}

}

/// @nodoc


class _EventLoaded extends LocaleEvent {
  const _EventLoaded(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleEvent.loaded()';
}


}




/// @nodoc


class _EventChanged extends LocaleEvent {
  const _EventChanged({required this.locale}): super._();
  

 final  Locale locale;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventChangedCopyWith<_EventChanged> get copyWith => __$EventChangedCopyWithImpl<_EventChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventChanged&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LocaleEvent.changed(locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$EventChangedCopyWith<$Res> implements $LocaleEventCopyWith<$Res> {
  factory _$EventChangedCopyWith(_EventChanged value, $Res Function(_EventChanged) _then) = __$EventChangedCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class __$EventChangedCopyWithImpl<$Res>
    implements _$EventChangedCopyWith<$Res> {
  __$EventChangedCopyWithImpl(this._self, this._then);

  final _EventChanged _self;
  final $Res Function(_EventChanged) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(_EventChanged(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

/// @nodoc


class _EventChangedByCode extends LocaleEvent {
  const _EventChangedByCode({required this.languageCode, this.countryCode}): super._();
  

 final  String languageCode;
 final  String? countryCode;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventChangedByCodeCopyWith<_EventChangedByCode> get copyWith => __$EventChangedByCodeCopyWithImpl<_EventChangedByCode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventChangedByCode&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode => Object.hash(runtimeType,languageCode,countryCode);

@override
String toString() {
  return 'LocaleEvent.changedByCode(languageCode: $languageCode, countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$EventChangedByCodeCopyWith<$Res> implements $LocaleEventCopyWith<$Res> {
  factory _$EventChangedByCodeCopyWith(_EventChangedByCode value, $Res Function(_EventChangedByCode) _then) = __$EventChangedByCodeCopyWithImpl;
@useResult
$Res call({
 String languageCode, String? countryCode
});




}
/// @nodoc
class __$EventChangedByCodeCopyWithImpl<$Res>
    implements _$EventChangedByCodeCopyWith<$Res> {
  __$EventChangedByCodeCopyWithImpl(this._self, this._then);

  final _EventChangedByCode _self;
  final $Res Function(_EventChangedByCode) _then;

/// Create a copy of LocaleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? countryCode = freezed,}) {
  return _then(_EventChangedByCode(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _EventResetToSystem extends LocaleEvent {
  const _EventResetToSystem(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResetToSystem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleEvent.resetToSystem()';
}


}




/// @nodoc


class _EventFallbackToDefault extends LocaleEvent {
  const _EventFallbackToDefault(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFallbackToDefault);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleEvent.fallbackToDefault()';
}


}




/// @nodoc
mixin _$LocaleState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocaleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleState()';
}


}

/// @nodoc
class $LocaleStateCopyWith<$Res>  {
$LocaleStateCopyWith(LocaleState _, $Res Function(LocaleState) __);
}


/// Adds pattern-matching-related methods to [LocaleState].
extension LocaleStatePatterns on LocaleState {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( Locale? previousLocale)?  loading,TResult Function( Locale locale,  List<Locale> supportedLocales,  Locale fallbackLocale)?  loaded,TResult Function( String message,  Locale? lastLocale)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateLoading() when loading != null:
return loading(_that.previousLocale);case _StateLoaded() when loaded != null:
return loaded(_that.locale,_that.supportedLocales,_that.fallbackLocale);case _StateFailure() when failure != null:
return failure(_that.message,_that.lastLocale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( Locale? previousLocale)  loading,required TResult Function( Locale locale,  List<Locale> supportedLocales,  Locale fallbackLocale)  loaded,required TResult Function( String message,  Locale? lastLocale)  failure,}) {final _that = this;
switch (_that) {
case _StateInitial():
return initial();case _StateLoading():
return loading(_that.previousLocale);case _StateLoaded():
return loaded(_that.locale,_that.supportedLocales,_that.fallbackLocale);case _StateFailure():
return failure(_that.message,_that.lastLocale);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( Locale? previousLocale)?  loading,TResult? Function( Locale locale,  List<Locale> supportedLocales,  Locale fallbackLocale)?  loaded,TResult? Function( String message,  Locale? lastLocale)?  failure,}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateLoading() when loading != null:
return loading(_that.previousLocale);case _StateLoaded() when loaded != null:
return loaded(_that.locale,_that.supportedLocales,_that.fallbackLocale);case _StateFailure() when failure != null:
return failure(_that.message,_that.lastLocale);case _:
  return null;

}
}

}

/// @nodoc


class _StateInitial extends LocaleState {
  const _StateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocaleState.initial()';
}


}




/// @nodoc


class _StateLoading extends LocaleState {
  const _StateLoading({this.previousLocale}): super._();
  

 final  Locale? previousLocale;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateLoadingCopyWith<_StateLoading> get copyWith => __$StateLoadingCopyWithImpl<_StateLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLoading&&(identical(other.previousLocale, previousLocale) || other.previousLocale == previousLocale));
}


@override
int get hashCode => Object.hash(runtimeType,previousLocale);

@override
String toString() {
  return 'LocaleState.loading(previousLocale: $previousLocale)';
}


}

/// @nodoc
abstract mixin class _$StateLoadingCopyWith<$Res> implements $LocaleStateCopyWith<$Res> {
  factory _$StateLoadingCopyWith(_StateLoading value, $Res Function(_StateLoading) _then) = __$StateLoadingCopyWithImpl;
@useResult
$Res call({
 Locale? previousLocale
});




}
/// @nodoc
class __$StateLoadingCopyWithImpl<$Res>
    implements _$StateLoadingCopyWith<$Res> {
  __$StateLoadingCopyWithImpl(this._self, this._then);

  final _StateLoading _self;
  final $Res Function(_StateLoading) _then;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? previousLocale = freezed,}) {
  return _then(_StateLoading(
previousLocale: freezed == previousLocale ? _self.previousLocale : previousLocale // ignore: cast_nullable_to_non_nullable
as Locale?,
  ));
}


}

/// @nodoc


class _StateLoaded extends LocaleState {
   _StateLoaded({required this.locale, final  List<Locale> supportedLocales = AppConstants.supportedLocales, this.fallbackLocale = AppConstants.fallbackLocale}): _supportedLocales = supportedLocales,super._();
  

 final  Locale locale;
 final  List<Locale> _supportedLocales;
@JsonKey() List<Locale> get supportedLocales {
  if (_supportedLocales is EqualUnmodifiableListView) return _supportedLocales;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportedLocales);
}

@JsonKey() final  Locale fallbackLocale;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateLoadedCopyWith<_StateLoaded> get copyWith => __$StateLoadedCopyWithImpl<_StateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLoaded&&(identical(other.locale, locale) || other.locale == locale)&&const DeepCollectionEquality().equals(other._supportedLocales, _supportedLocales)&&(identical(other.fallbackLocale, fallbackLocale) || other.fallbackLocale == fallbackLocale));
}


@override
int get hashCode => Object.hash(runtimeType,locale,const DeepCollectionEquality().hash(_supportedLocales),fallbackLocale);

@override
String toString() {
  return 'LocaleState.loaded(locale: $locale, supportedLocales: $supportedLocales, fallbackLocale: $fallbackLocale)';
}


}

/// @nodoc
abstract mixin class _$StateLoadedCopyWith<$Res> implements $LocaleStateCopyWith<$Res> {
  factory _$StateLoadedCopyWith(_StateLoaded value, $Res Function(_StateLoaded) _then) = __$StateLoadedCopyWithImpl;
@useResult
$Res call({
 Locale locale, List<Locale> supportedLocales, Locale fallbackLocale
});




}
/// @nodoc
class __$StateLoadedCopyWithImpl<$Res>
    implements _$StateLoadedCopyWith<$Res> {
  __$StateLoadedCopyWithImpl(this._self, this._then);

  final _StateLoaded _self;
  final $Res Function(_StateLoaded) _then;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? supportedLocales = null,Object? fallbackLocale = null,}) {
  return _then(_StateLoaded(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,supportedLocales: null == supportedLocales ? _self._supportedLocales : supportedLocales // ignore: cast_nullable_to_non_nullable
as List<Locale>,fallbackLocale: null == fallbackLocale ? _self.fallbackLocale : fallbackLocale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

/// @nodoc


class _StateFailure extends LocaleState {
  const _StateFailure({required this.message, this.lastLocale}): super._();
  

 final  String message;
 final  Locale? lastLocale;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateFailureCopyWith<_StateFailure> get copyWith => __$StateFailureCopyWithImpl<_StateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateFailure&&(identical(other.message, message) || other.message == message)&&(identical(other.lastLocale, lastLocale) || other.lastLocale == lastLocale));
}


@override
int get hashCode => Object.hash(runtimeType,message,lastLocale);

@override
String toString() {
  return 'LocaleState.failure(message: $message, lastLocale: $lastLocale)';
}


}

/// @nodoc
abstract mixin class _$StateFailureCopyWith<$Res> implements $LocaleStateCopyWith<$Res> {
  factory _$StateFailureCopyWith(_StateFailure value, $Res Function(_StateFailure) _then) = __$StateFailureCopyWithImpl;
@useResult
$Res call({
 String message, Locale? lastLocale
});




}
/// @nodoc
class __$StateFailureCopyWithImpl<$Res>
    implements _$StateFailureCopyWith<$Res> {
  __$StateFailureCopyWithImpl(this._self, this._then);

  final _StateFailure _self;
  final $Res Function(_StateFailure) _then;

/// Create a copy of LocaleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? lastLocale = freezed,}) {
  return _then(_StateFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,lastLocale: freezed == lastLocale ? _self.lastLocale : lastLocale // ignore: cast_nullable_to_non_nullable
as Locale?,
  ));
}


}

// dart format on
