// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_lifecycle_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppLifecycleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLifecycleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent()';
}


}

/// @nodoc
class $AppLifecycleEventCopyWith<$Res>  {
$AppLifecycleEventCopyWith(AppLifecycleEvent _, $Res Function(AppLifecycleEvent) __);
}


/// Adds pattern-matching-related methods to [AppLifecycleEvent].
extension AppLifecycleEventPatterns on AppLifecycleEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( flutter.AppLifecycleState? state)?  changed,TResult Function()?  resumed,TResult Function()?  paused,TResult Function()?  inactive,TResult Function()?  detached,TResult Function()?  backgroundEntered,TResult Function()?  foregroundEntered,TResult Function()?  sessionStarted,TResult Function( Duration sessionDuration)?  sessionEnded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventChanged() when changed != null:
return changed(_that.state);case _EventResumed() when resumed != null:
return resumed();case _EventPaused() when paused != null:
return paused();case _EventInactive() when inactive != null:
return inactive();case _EventDetached() when detached != null:
return detached();case _EventBackgroundEntered() when backgroundEntered != null:
return backgroundEntered();case _EventForegroundEntered() when foregroundEntered != null:
return foregroundEntered();case _EventSessionStarted() when sessionStarted != null:
return sessionStarted();case _EventSessionEnded() when sessionEnded != null:
return sessionEnded(_that.sessionDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( flutter.AppLifecycleState? state)  changed,required TResult Function()  resumed,required TResult Function()  paused,required TResult Function()  inactive,required TResult Function()  detached,required TResult Function()  backgroundEntered,required TResult Function()  foregroundEntered,required TResult Function()  sessionStarted,required TResult Function( Duration sessionDuration)  sessionEnded,}) {final _that = this;
switch (_that) {
case _EventChanged():
return changed(_that.state);case _EventResumed():
return resumed();case _EventPaused():
return paused();case _EventInactive():
return inactive();case _EventDetached():
return detached();case _EventBackgroundEntered():
return backgroundEntered();case _EventForegroundEntered():
return foregroundEntered();case _EventSessionStarted():
return sessionStarted();case _EventSessionEnded():
return sessionEnded(_that.sessionDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( flutter.AppLifecycleState? state)?  changed,TResult? Function()?  resumed,TResult? Function()?  paused,TResult? Function()?  inactive,TResult? Function()?  detached,TResult? Function()?  backgroundEntered,TResult? Function()?  foregroundEntered,TResult? Function()?  sessionStarted,TResult? Function( Duration sessionDuration)?  sessionEnded,}) {final _that = this;
switch (_that) {
case _EventChanged() when changed != null:
return changed(_that.state);case _EventResumed() when resumed != null:
return resumed();case _EventPaused() when paused != null:
return paused();case _EventInactive() when inactive != null:
return inactive();case _EventDetached() when detached != null:
return detached();case _EventBackgroundEntered() when backgroundEntered != null:
return backgroundEntered();case _EventForegroundEntered() when foregroundEntered != null:
return foregroundEntered();case _EventSessionStarted() when sessionStarted != null:
return sessionStarted();case _EventSessionEnded() when sessionEnded != null:
return sessionEnded(_that.sessionDuration);case _:
  return null;

}
}

}

/// @nodoc


class _EventChanged extends AppLifecycleEvent {
  const _EventChanged(this.state): super._();
  

 final  flutter.AppLifecycleState? state;

/// Create a copy of AppLifecycleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventChangedCopyWith<_EventChanged> get copyWith => __$EventChangedCopyWithImpl<_EventChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventChanged&&(identical(other.state, state) || other.state == state));
}


@override
int get hashCode => Object.hash(runtimeType,state);

@override
String toString() {
  return 'AppLifecycleEvent.changed(state: $state)';
}


}

/// @nodoc
abstract mixin class _$EventChangedCopyWith<$Res> implements $AppLifecycleEventCopyWith<$Res> {
  factory _$EventChangedCopyWith(_EventChanged value, $Res Function(_EventChanged) _then) = __$EventChangedCopyWithImpl;
@useResult
$Res call({
 flutter.AppLifecycleState? state
});




}
/// @nodoc
class __$EventChangedCopyWithImpl<$Res>
    implements _$EventChangedCopyWith<$Res> {
  __$EventChangedCopyWithImpl(this._self, this._then);

  final _EventChanged _self;
  final $Res Function(_EventChanged) _then;

/// Create a copy of AppLifecycleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? state = freezed,}) {
  return _then(_EventChanged(
freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as flutter.AppLifecycleState?,
  ));
}


}

/// @nodoc


class _EventResumed extends AppLifecycleEvent {
  const _EventResumed(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.resumed()';
}


}




/// @nodoc


class _EventPaused extends AppLifecycleEvent {
  const _EventPaused(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPaused);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.paused()';
}


}




/// @nodoc


class _EventInactive extends AppLifecycleEvent {
  const _EventInactive(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventInactive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.inactive()';
}


}




/// @nodoc


class _EventDetached extends AppLifecycleEvent {
  const _EventDetached(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetached);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.detached()';
}


}




/// @nodoc


class _EventBackgroundEntered extends AppLifecycleEvent {
  const _EventBackgroundEntered(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventBackgroundEntered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.backgroundEntered()';
}


}




/// @nodoc


class _EventForegroundEntered extends AppLifecycleEvent {
  const _EventForegroundEntered(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventForegroundEntered);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.foregroundEntered()';
}


}




/// @nodoc


class _EventSessionStarted extends AppLifecycleEvent {
  const _EventSessionStarted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventSessionStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppLifecycleEvent.sessionStarted()';
}


}




/// @nodoc


class _EventSessionEnded extends AppLifecycleEvent {
  const _EventSessionEnded(this.sessionDuration): super._();
  

 final  Duration sessionDuration;

/// Create a copy of AppLifecycleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventSessionEndedCopyWith<_EventSessionEnded> get copyWith => __$EventSessionEndedCopyWithImpl<_EventSessionEnded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventSessionEnded&&(identical(other.sessionDuration, sessionDuration) || other.sessionDuration == sessionDuration));
}


@override
int get hashCode => Object.hash(runtimeType,sessionDuration);

@override
String toString() {
  return 'AppLifecycleEvent.sessionEnded(sessionDuration: $sessionDuration)';
}


}

/// @nodoc
abstract mixin class _$EventSessionEndedCopyWith<$Res> implements $AppLifecycleEventCopyWith<$Res> {
  factory _$EventSessionEndedCopyWith(_EventSessionEnded value, $Res Function(_EventSessionEnded) _then) = __$EventSessionEndedCopyWithImpl;
@useResult
$Res call({
 Duration sessionDuration
});




}
/// @nodoc
class __$EventSessionEndedCopyWithImpl<$Res>
    implements _$EventSessionEndedCopyWith<$Res> {
  __$EventSessionEndedCopyWithImpl(this._self, this._then);

  final _EventSessionEnded _self;
  final $Res Function(_EventSessionEnded) _then;

/// Create a copy of AppLifecycleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionDuration = null,}) {
  return _then(_EventSessionEnded(
null == sessionDuration ? _self.sessionDuration : sessionDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc
mixin _$AppLifecycleState {

 Duration get totalForegroundTime; Duration get totalBackgroundTime; int get sessionCount;
/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppLifecycleStateCopyWith<AppLifecycleState> get copyWith => _$AppLifecycleStateCopyWithImpl<AppLifecycleState>(this as AppLifecycleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppLifecycleState&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState(totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class $AppLifecycleStateCopyWith<$Res>  {
  factory $AppLifecycleStateCopyWith(AppLifecycleState value, $Res Function(AppLifecycleState) _then) = _$AppLifecycleStateCopyWithImpl;
@useResult
$Res call({
 Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class _$AppLifecycleStateCopyWithImpl<$Res>
    implements $AppLifecycleStateCopyWith<$Res> {
  _$AppLifecycleStateCopyWithImpl(this._self, this._then);

  final AppLifecycleState _self;
  final $Res Function(AppLifecycleState) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_self.copyWith(
totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppLifecycleState].
extension AppLifecycleStatePatterns on AppLifecycleState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  initial,TResult Function( DateTime lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  resumed,TResult Function( DateTime? lastResumedAt,  DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  inactive,TResult Function( DateTime lastPausedAt,  DateTime? lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  paused,TResult Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  detached,TResult Function( DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  background,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateResumed() when resumed != null:
return resumed(_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateInactive() when inactive != null:
return inactive(_that.lastResumedAt,_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StatePaused() when paused != null:
return paused(_that.lastPausedAt,_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateDetached() when detached != null:
return detached(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateBackground() when background != null:
return background(_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  initial,required TResult Function( DateTime lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  resumed,required TResult Function( DateTime? lastResumedAt,  DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  inactive,required TResult Function( DateTime lastPausedAt,  DateTime? lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  paused,required TResult Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  detached,required TResult Function( DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)  background,}) {final _that = this;
switch (_that) {
case _StateInitial():
return initial(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateResumed():
return resumed(_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateInactive():
return inactive(_that.lastResumedAt,_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StatePaused():
return paused(_that.lastPausedAt,_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateDetached():
return detached(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateBackground():
return background(_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  initial,TResult? Function( DateTime lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  resumed,TResult? Function( DateTime? lastResumedAt,  DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  inactive,TResult? Function( DateTime lastPausedAt,  DateTime? lastResumedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  paused,TResult? Function( Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  detached,TResult? Function( DateTime? lastPausedAt,  Duration totalForegroundTime,  Duration totalBackgroundTime,  int sessionCount)?  background,}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateResumed() when resumed != null:
return resumed(_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateInactive() when inactive != null:
return inactive(_that.lastResumedAt,_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StatePaused() when paused != null:
return paused(_that.lastPausedAt,_that.lastResumedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateDetached() when detached != null:
return detached(_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _StateBackground() when background != null:
return background(_that.lastPausedAt,_that.totalForegroundTime,_that.totalBackgroundTime,_that.sessionCount);case _:
  return null;

}
}

}

/// @nodoc


class _StateInitial extends AppLifecycleState {
  const _StateInitial({this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateInitialCopyWith<_StateInitial> get copyWith => __$StateInitialCopyWithImpl<_StateInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateInitial&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.initial(totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StateInitialCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StateInitialCopyWith(_StateInitial value, $Res Function(_StateInitial) _then) = __$StateInitialCopyWithImpl;
@override @useResult
$Res call({
 Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StateInitialCopyWithImpl<$Res>
    implements _$StateInitialCopyWith<$Res> {
  __$StateInitialCopyWithImpl(this._self, this._then);

  final _StateInitial _self;
  final $Res Function(_StateInitial) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StateInitial(
totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StateResumed extends AppLifecycleState {
   _StateResumed({required this.lastResumedAt, this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

 final  DateTime lastResumedAt;
@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateResumedCopyWith<_StateResumed> get copyWith => __$StateResumedCopyWithImpl<_StateResumed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateResumed&&(identical(other.lastResumedAt, lastResumedAt) || other.lastResumedAt == lastResumedAt)&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,lastResumedAt,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.resumed(lastResumedAt: $lastResumedAt, totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StateResumedCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StateResumedCopyWith(_StateResumed value, $Res Function(_StateResumed) _then) = __$StateResumedCopyWithImpl;
@override @useResult
$Res call({
 DateTime lastResumedAt, Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StateResumedCopyWithImpl<$Res>
    implements _$StateResumedCopyWith<$Res> {
  __$StateResumedCopyWithImpl(this._self, this._then);

  final _StateResumed _self;
  final $Res Function(_StateResumed) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastResumedAt = null,Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StateResumed(
lastResumedAt: null == lastResumedAt ? _self.lastResumedAt : lastResumedAt // ignore: cast_nullable_to_non_nullable
as DateTime,totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StateInactive extends AppLifecycleState {
   _StateInactive({this.lastResumedAt, this.lastPausedAt, this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

 final  DateTime? lastResumedAt;
 final  DateTime? lastPausedAt;
@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateInactiveCopyWith<_StateInactive> get copyWith => __$StateInactiveCopyWithImpl<_StateInactive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateInactive&&(identical(other.lastResumedAt, lastResumedAt) || other.lastResumedAt == lastResumedAt)&&(identical(other.lastPausedAt, lastPausedAt) || other.lastPausedAt == lastPausedAt)&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,lastResumedAt,lastPausedAt,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.inactive(lastResumedAt: $lastResumedAt, lastPausedAt: $lastPausedAt, totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StateInactiveCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StateInactiveCopyWith(_StateInactive value, $Res Function(_StateInactive) _then) = __$StateInactiveCopyWithImpl;
@override @useResult
$Res call({
 DateTime? lastResumedAt, DateTime? lastPausedAt, Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StateInactiveCopyWithImpl<$Res>
    implements _$StateInactiveCopyWith<$Res> {
  __$StateInactiveCopyWithImpl(this._self, this._then);

  final _StateInactive _self;
  final $Res Function(_StateInactive) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastResumedAt = freezed,Object? lastPausedAt = freezed,Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StateInactive(
lastResumedAt: freezed == lastResumedAt ? _self.lastResumedAt : lastResumedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPausedAt: freezed == lastPausedAt ? _self.lastPausedAt : lastPausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StatePaused extends AppLifecycleState {
   _StatePaused({required this.lastPausedAt, this.lastResumedAt, this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

 final  DateTime lastPausedAt;
 final  DateTime? lastResumedAt;
@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatePausedCopyWith<_StatePaused> get copyWith => __$StatePausedCopyWithImpl<_StatePaused>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatePaused&&(identical(other.lastPausedAt, lastPausedAt) || other.lastPausedAt == lastPausedAt)&&(identical(other.lastResumedAt, lastResumedAt) || other.lastResumedAt == lastResumedAt)&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,lastPausedAt,lastResumedAt,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.paused(lastPausedAt: $lastPausedAt, lastResumedAt: $lastResumedAt, totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StatePausedCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StatePausedCopyWith(_StatePaused value, $Res Function(_StatePaused) _then) = __$StatePausedCopyWithImpl;
@override @useResult
$Res call({
 DateTime lastPausedAt, DateTime? lastResumedAt, Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StatePausedCopyWithImpl<$Res>
    implements _$StatePausedCopyWith<$Res> {
  __$StatePausedCopyWithImpl(this._self, this._then);

  final _StatePaused _self;
  final $Res Function(_StatePaused) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastPausedAt = null,Object? lastResumedAt = freezed,Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StatePaused(
lastPausedAt: null == lastPausedAt ? _self.lastPausedAt : lastPausedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastResumedAt: freezed == lastResumedAt ? _self.lastResumedAt : lastResumedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StateDetached extends AppLifecycleState {
  const _StateDetached({this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateDetachedCopyWith<_StateDetached> get copyWith => __$StateDetachedCopyWithImpl<_StateDetached>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateDetached&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.detached(totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StateDetachedCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StateDetachedCopyWith(_StateDetached value, $Res Function(_StateDetached) _then) = __$StateDetachedCopyWithImpl;
@override @useResult
$Res call({
 Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StateDetachedCopyWithImpl<$Res>
    implements _$StateDetachedCopyWith<$Res> {
  __$StateDetachedCopyWithImpl(this._self, this._then);

  final _StateDetached _self;
  final $Res Function(_StateDetached) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StateDetached(
totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StateBackground extends AppLifecycleState {
   _StateBackground({this.lastPausedAt, this.totalForegroundTime = Duration.zero, this.totalBackgroundTime = Duration.zero, this.sessionCount = 0}): super._();
  

 final  DateTime? lastPausedAt;
@override@JsonKey() final  Duration totalForegroundTime;
@override@JsonKey() final  Duration totalBackgroundTime;
@override@JsonKey() final  int sessionCount;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateBackgroundCopyWith<_StateBackground> get copyWith => __$StateBackgroundCopyWithImpl<_StateBackground>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateBackground&&(identical(other.lastPausedAt, lastPausedAt) || other.lastPausedAt == lastPausedAt)&&(identical(other.totalForegroundTime, totalForegroundTime) || other.totalForegroundTime == totalForegroundTime)&&(identical(other.totalBackgroundTime, totalBackgroundTime) || other.totalBackgroundTime == totalBackgroundTime)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount));
}


@override
int get hashCode => Object.hash(runtimeType,lastPausedAt,totalForegroundTime,totalBackgroundTime,sessionCount);

@override
String toString() {
  return 'AppLifecycleState.background(lastPausedAt: $lastPausedAt, totalForegroundTime: $totalForegroundTime, totalBackgroundTime: $totalBackgroundTime, sessionCount: $sessionCount)';
}


}

/// @nodoc
abstract mixin class _$StateBackgroundCopyWith<$Res> implements $AppLifecycleStateCopyWith<$Res> {
  factory _$StateBackgroundCopyWith(_StateBackground value, $Res Function(_StateBackground) _then) = __$StateBackgroundCopyWithImpl;
@override @useResult
$Res call({
 DateTime? lastPausedAt, Duration totalForegroundTime, Duration totalBackgroundTime, int sessionCount
});




}
/// @nodoc
class __$StateBackgroundCopyWithImpl<$Res>
    implements _$StateBackgroundCopyWith<$Res> {
  __$StateBackgroundCopyWithImpl(this._self, this._then);

  final _StateBackground _self;
  final $Res Function(_StateBackground) _then;

/// Create a copy of AppLifecycleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastPausedAt = freezed,Object? totalForegroundTime = null,Object? totalBackgroundTime = null,Object? sessionCount = null,}) {
  return _then(_StateBackground(
lastPausedAt: freezed == lastPausedAt ? _self.lastPausedAt : lastPausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalForegroundTime: null == totalForegroundTime ? _self.totalForegroundTime : totalForegroundTime // ignore: cast_nullable_to_non_nullable
as Duration,totalBackgroundTime: null == totalBackgroundTime ? _self.totalBackgroundTime : totalBackgroundTime // ignore: cast_nullable_to_non_nullable
as Duration,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
