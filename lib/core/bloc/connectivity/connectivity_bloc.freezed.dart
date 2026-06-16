// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connectivity_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConnectivityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityEvent()';
}


}

/// @nodoc
class $ConnectivityEventCopyWith<$Res>  {
$ConnectivityEventCopyWith(ConnectivityEvent _, $Res Function(ConnectivityEvent) __);
}


/// Adds pattern-matching-related methods to [ConnectivityEvent].
extension ConnectivityEventPatterns on ConnectivityEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loaded,TResult Function( bool isConnected,  String? connectionType,  bool isCellular,  bool isWifi,  bool isVpn,  bool isRoaming)?  changed,TResult Function()?  lost,TResult Function( Duration offlineDuration)?  restored,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventLoaded() when loaded != null:
return loaded();case _EventChanged() when changed != null:
return changed(_that.isConnected,_that.connectionType,_that.isCellular,_that.isWifi,_that.isVpn,_that.isRoaming);case _EventLost() when lost != null:
return lost();case _EventRestored() when restored != null:
return restored(_that.offlineDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loaded,required TResult Function( bool isConnected,  String? connectionType,  bool isCellular,  bool isWifi,  bool isVpn,  bool isRoaming)  changed,required TResult Function()  lost,required TResult Function( Duration offlineDuration)  restored,}) {final _that = this;
switch (_that) {
case _EventLoaded():
return loaded();case _EventChanged():
return changed(_that.isConnected,_that.connectionType,_that.isCellular,_that.isWifi,_that.isVpn,_that.isRoaming);case _EventLost():
return lost();case _EventRestored():
return restored(_that.offlineDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loaded,TResult? Function( bool isConnected,  String? connectionType,  bool isCellular,  bool isWifi,  bool isVpn,  bool isRoaming)?  changed,TResult? Function()?  lost,TResult? Function( Duration offlineDuration)?  restored,}) {final _that = this;
switch (_that) {
case _EventLoaded() when loaded != null:
return loaded();case _EventChanged() when changed != null:
return changed(_that.isConnected,_that.connectionType,_that.isCellular,_that.isWifi,_that.isVpn,_that.isRoaming);case _EventLost() when lost != null:
return lost();case _EventRestored() when restored != null:
return restored(_that.offlineDuration);case _:
  return null;

}
}

}

/// @nodoc


class _EventLoaded extends ConnectivityEvent {
  const _EventLoaded(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityEvent.loaded()';
}


}




/// @nodoc


class _EventChanged extends ConnectivityEvent {
  const _EventChanged({required this.isConnected, this.connectionType, this.isCellular = false, this.isWifi = false, this.isVpn = false, this.isRoaming = false}): super._();
  

 final  bool isConnected;
 final  String? connectionType;
@JsonKey() final  bool isCellular;
@JsonKey() final  bool isWifi;
@JsonKey() final  bool isVpn;
@JsonKey() final  bool isRoaming;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventChangedCopyWith<_EventChanged> get copyWith => __$EventChangedCopyWithImpl<_EventChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventChanged&&(identical(other.isConnected, isConnected) || other.isConnected == isConnected)&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.isCellular, isCellular) || other.isCellular == isCellular)&&(identical(other.isWifi, isWifi) || other.isWifi == isWifi)&&(identical(other.isVpn, isVpn) || other.isVpn == isVpn)&&(identical(other.isRoaming, isRoaming) || other.isRoaming == isRoaming));
}


@override
int get hashCode => Object.hash(runtimeType,isConnected,connectionType,isCellular,isWifi,isVpn,isRoaming);

@override
String toString() {
  return 'ConnectivityEvent.changed(isConnected: $isConnected, connectionType: $connectionType, isCellular: $isCellular, isWifi: $isWifi, isVpn: $isVpn, isRoaming: $isRoaming)';
}


}

/// @nodoc
abstract mixin class _$EventChangedCopyWith<$Res> implements $ConnectivityEventCopyWith<$Res> {
  factory _$EventChangedCopyWith(_EventChanged value, $Res Function(_EventChanged) _then) = __$EventChangedCopyWithImpl;
@useResult
$Res call({
 bool isConnected, String? connectionType, bool isCellular, bool isWifi, bool isVpn, bool isRoaming
});




}
/// @nodoc
class __$EventChangedCopyWithImpl<$Res>
    implements _$EventChangedCopyWith<$Res> {
  __$EventChangedCopyWithImpl(this._self, this._then);

  final _EventChanged _self;
  final $Res Function(_EventChanged) _then;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isConnected = null,Object? connectionType = freezed,Object? isCellular = null,Object? isWifi = null,Object? isVpn = null,Object? isRoaming = null,}) {
  return _then(_EventChanged(
isConnected: null == isConnected ? _self.isConnected : isConnected // ignore: cast_nullable_to_non_nullable
as bool,connectionType: freezed == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as String?,isCellular: null == isCellular ? _self.isCellular : isCellular // ignore: cast_nullable_to_non_nullable
as bool,isWifi: null == isWifi ? _self.isWifi : isWifi // ignore: cast_nullable_to_non_nullable
as bool,isVpn: null == isVpn ? _self.isVpn : isVpn // ignore: cast_nullable_to_non_nullable
as bool,isRoaming: null == isRoaming ? _self.isRoaming : isRoaming // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _EventLost extends ConnectivityEvent {
  const _EventLost(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLost);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityEvent.lost()';
}


}




/// @nodoc


class _EventRestored extends ConnectivityEvent {
  const _EventRestored({required this.offlineDuration}): super._();
  

 final  Duration offlineDuration;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRestoredCopyWith<_EventRestored> get copyWith => __$EventRestoredCopyWithImpl<_EventRestored>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRestored&&(identical(other.offlineDuration, offlineDuration) || other.offlineDuration == offlineDuration));
}


@override
int get hashCode => Object.hash(runtimeType,offlineDuration);

@override
String toString() {
  return 'ConnectivityEvent.restored(offlineDuration: $offlineDuration)';
}


}

/// @nodoc
abstract mixin class _$EventRestoredCopyWith<$Res> implements $ConnectivityEventCopyWith<$Res> {
  factory _$EventRestoredCopyWith(_EventRestored value, $Res Function(_EventRestored) _then) = __$EventRestoredCopyWithImpl;
@useResult
$Res call({
 Duration offlineDuration
});




}
/// @nodoc
class __$EventRestoredCopyWithImpl<$Res>
    implements _$EventRestoredCopyWith<$Res> {
  __$EventRestoredCopyWithImpl(this._self, this._then);

  final _EventRestored _self;
  final $Res Function(_EventRestored) _then;

/// Create a copy of ConnectivityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? offlineDuration = null,}) {
  return _then(_EventRestored(
offlineDuration: null == offlineDuration ? _self.offlineDuration : offlineDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc
mixin _$ConnectivityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectivityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityState()';
}


}

/// @nodoc
class $ConnectivityStateCopyWith<$Res>  {
$ConnectivityStateCopyWith(ConnectivityState _, $Res Function(ConnectivityState) __);
}


/// Adds pattern-matching-related methods to [ConnectivityState].
extension ConnectivityStatePatterns on ConnectivityState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType,  DateTime? lastConnectedAt,  Duration? offlineDuration)?  connected,TResult Function( DateTime? lastDisconnectedAt,  Duration? offlineDuration)?  disconnected,TResult Function()?  connecting,TResult Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType)?  slowConnection,TResult Function( String errorMessage)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateLoading() when loading != null:
return loading();case _StateConnected() when connected != null:
return connected(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType,_that.lastConnectedAt,_that.offlineDuration);case _StateDisconnected() when disconnected != null:
return disconnected(_that.lastDisconnectedAt,_that.offlineDuration);case _StateConnecting() when connecting != null:
return connecting();case _StateSlowConnection() when slowConnection != null:
return slowConnection(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType);case _StateFailure() when failure != null:
return failure(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType,  DateTime? lastConnectedAt,  Duration? offlineDuration)  connected,required TResult Function( DateTime? lastDisconnectedAt,  Duration? offlineDuration)  disconnected,required TResult Function()  connecting,required TResult Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType)  slowConnection,required TResult Function( String errorMessage)  failure,}) {final _that = this;
switch (_that) {
case _StateInitial():
return initial();case _StateLoading():
return loading();case _StateConnected():
return connected(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType,_that.lastConnectedAt,_that.offlineDuration);case _StateDisconnected():
return disconnected(_that.lastDisconnectedAt,_that.offlineDuration);case _StateConnecting():
return connecting();case _StateSlowConnection():
return slowConnection(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType);case _StateFailure():
return failure(_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType,  DateTime? lastConnectedAt,  Duration? offlineDuration)?  connected,TResult? Function( DateTime? lastDisconnectedAt,  Duration? offlineDuration)?  disconnected,TResult? Function()?  connecting,TResult? Function( bool isWifi,  bool isCellular,  bool isVpn,  String? connectionType)?  slowConnection,TResult? Function( String errorMessage)?  failure,}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateLoading() when loading != null:
return loading();case _StateConnected() when connected != null:
return connected(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType,_that.lastConnectedAt,_that.offlineDuration);case _StateDisconnected() when disconnected != null:
return disconnected(_that.lastDisconnectedAt,_that.offlineDuration);case _StateConnecting() when connecting != null:
return connecting();case _StateSlowConnection() when slowConnection != null:
return slowConnection(_that.isWifi,_that.isCellular,_that.isVpn,_that.connectionType);case _StateFailure() when failure != null:
return failure(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StateInitial extends ConnectivityState {
  const _StateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityState.initial()';
}


}




/// @nodoc


class _StateLoading extends ConnectivityState {
  const _StateLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityState.loading()';
}


}




/// @nodoc


class _StateConnected extends ConnectivityState {
   _StateConnected({this.isWifi = false, this.isCellular = false, this.isVpn = false, this.connectionType, this.lastConnectedAt, this.offlineDuration}): super._();
  

@JsonKey() final  bool isWifi;
@JsonKey() final  bool isCellular;
@JsonKey() final  bool isVpn;
 final  String? connectionType;
 final  DateTime? lastConnectedAt;
/// Set when coming back online after offline (for snackbar).
 final  Duration? offlineDuration;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateConnectedCopyWith<_StateConnected> get copyWith => __$StateConnectedCopyWithImpl<_StateConnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateConnected&&(identical(other.isWifi, isWifi) || other.isWifi == isWifi)&&(identical(other.isCellular, isCellular) || other.isCellular == isCellular)&&(identical(other.isVpn, isVpn) || other.isVpn == isVpn)&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType)&&(identical(other.lastConnectedAt, lastConnectedAt) || other.lastConnectedAt == lastConnectedAt)&&(identical(other.offlineDuration, offlineDuration) || other.offlineDuration == offlineDuration));
}


@override
int get hashCode => Object.hash(runtimeType,isWifi,isCellular,isVpn,connectionType,lastConnectedAt,offlineDuration);

@override
String toString() {
  return 'ConnectivityState.connected(isWifi: $isWifi, isCellular: $isCellular, isVpn: $isVpn, connectionType: $connectionType, lastConnectedAt: $lastConnectedAt, offlineDuration: $offlineDuration)';
}


}

/// @nodoc
abstract mixin class _$StateConnectedCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$StateConnectedCopyWith(_StateConnected value, $Res Function(_StateConnected) _then) = __$StateConnectedCopyWithImpl;
@useResult
$Res call({
 bool isWifi, bool isCellular, bool isVpn, String? connectionType, DateTime? lastConnectedAt, Duration? offlineDuration
});




}
/// @nodoc
class __$StateConnectedCopyWithImpl<$Res>
    implements _$StateConnectedCopyWith<$Res> {
  __$StateConnectedCopyWithImpl(this._self, this._then);

  final _StateConnected _self;
  final $Res Function(_StateConnected) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isWifi = null,Object? isCellular = null,Object? isVpn = null,Object? connectionType = freezed,Object? lastConnectedAt = freezed,Object? offlineDuration = freezed,}) {
  return _then(_StateConnected(
isWifi: null == isWifi ? _self.isWifi : isWifi // ignore: cast_nullable_to_non_nullable
as bool,isCellular: null == isCellular ? _self.isCellular : isCellular // ignore: cast_nullable_to_non_nullable
as bool,isVpn: null == isVpn ? _self.isVpn : isVpn // ignore: cast_nullable_to_non_nullable
as bool,connectionType: freezed == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as String?,lastConnectedAt: freezed == lastConnectedAt ? _self.lastConnectedAt : lastConnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offlineDuration: freezed == offlineDuration ? _self.offlineDuration : offlineDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

/// @nodoc


class _StateDisconnected extends ConnectivityState {
   _StateDisconnected({this.lastDisconnectedAt, this.offlineDuration}): super._();
  

 final  DateTime? lastDisconnectedAt;
 final  Duration? offlineDuration;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateDisconnectedCopyWith<_StateDisconnected> get copyWith => __$StateDisconnectedCopyWithImpl<_StateDisconnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateDisconnected&&(identical(other.lastDisconnectedAt, lastDisconnectedAt) || other.lastDisconnectedAt == lastDisconnectedAt)&&(identical(other.offlineDuration, offlineDuration) || other.offlineDuration == offlineDuration));
}


@override
int get hashCode => Object.hash(runtimeType,lastDisconnectedAt,offlineDuration);

@override
String toString() {
  return 'ConnectivityState.disconnected(lastDisconnectedAt: $lastDisconnectedAt, offlineDuration: $offlineDuration)';
}


}

/// @nodoc
abstract mixin class _$StateDisconnectedCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$StateDisconnectedCopyWith(_StateDisconnected value, $Res Function(_StateDisconnected) _then) = __$StateDisconnectedCopyWithImpl;
@useResult
$Res call({
 DateTime? lastDisconnectedAt, Duration? offlineDuration
});




}
/// @nodoc
class __$StateDisconnectedCopyWithImpl<$Res>
    implements _$StateDisconnectedCopyWith<$Res> {
  __$StateDisconnectedCopyWithImpl(this._self, this._then);

  final _StateDisconnected _self;
  final $Res Function(_StateDisconnected) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastDisconnectedAt = freezed,Object? offlineDuration = freezed,}) {
  return _then(_StateDisconnected(
lastDisconnectedAt: freezed == lastDisconnectedAt ? _self.lastDisconnectedAt : lastDisconnectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offlineDuration: freezed == offlineDuration ? _self.offlineDuration : offlineDuration // ignore: cast_nullable_to_non_nullable
as Duration?,
  ));
}


}

/// @nodoc


class _StateConnecting extends ConnectivityState {
  const _StateConnecting(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateConnecting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ConnectivityState.connecting()';
}


}




/// @nodoc


class _StateSlowConnection extends ConnectivityState {
  const _StateSlowConnection({this.isWifi = false, this.isCellular = false, this.isVpn = false, this.connectionType}): super._();
  

@JsonKey() final  bool isWifi;
@JsonKey() final  bool isCellular;
@JsonKey() final  bool isVpn;
 final  String? connectionType;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateSlowConnectionCopyWith<_StateSlowConnection> get copyWith => __$StateSlowConnectionCopyWithImpl<_StateSlowConnection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateSlowConnection&&(identical(other.isWifi, isWifi) || other.isWifi == isWifi)&&(identical(other.isCellular, isCellular) || other.isCellular == isCellular)&&(identical(other.isVpn, isVpn) || other.isVpn == isVpn)&&(identical(other.connectionType, connectionType) || other.connectionType == connectionType));
}


@override
int get hashCode => Object.hash(runtimeType,isWifi,isCellular,isVpn,connectionType);

@override
String toString() {
  return 'ConnectivityState.slowConnection(isWifi: $isWifi, isCellular: $isCellular, isVpn: $isVpn, connectionType: $connectionType)';
}


}

/// @nodoc
abstract mixin class _$StateSlowConnectionCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$StateSlowConnectionCopyWith(_StateSlowConnection value, $Res Function(_StateSlowConnection) _then) = __$StateSlowConnectionCopyWithImpl;
@useResult
$Res call({
 bool isWifi, bool isCellular, bool isVpn, String? connectionType
});




}
/// @nodoc
class __$StateSlowConnectionCopyWithImpl<$Res>
    implements _$StateSlowConnectionCopyWith<$Res> {
  __$StateSlowConnectionCopyWithImpl(this._self, this._then);

  final _StateSlowConnection _self;
  final $Res Function(_StateSlowConnection) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isWifi = null,Object? isCellular = null,Object? isVpn = null,Object? connectionType = freezed,}) {
  return _then(_StateSlowConnection(
isWifi: null == isWifi ? _self.isWifi : isWifi // ignore: cast_nullable_to_non_nullable
as bool,isCellular: null == isCellular ? _self.isCellular : isCellular // ignore: cast_nullable_to_non_nullable
as bool,isVpn: null == isVpn ? _self.isVpn : isVpn // ignore: cast_nullable_to_non_nullable
as bool,connectionType: freezed == connectionType ? _self.connectionType : connectionType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _StateFailure extends ConnectivityState {
  const _StateFailure(this.errorMessage): super._();
  

 final  String errorMessage;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateFailureCopyWith<_StateFailure> get copyWith => __$StateFailureCopyWithImpl<_StateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'ConnectivityState.failure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StateFailureCopyWith<$Res> implements $ConnectivityStateCopyWith<$Res> {
  factory _$StateFailureCopyWith(_StateFailure value, $Res Function(_StateFailure) _then) = __$StateFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$StateFailureCopyWithImpl<$Res>
    implements _$StateFailureCopyWith<$Res> {
  __$StateFailureCopyWithImpl(this._self, this._then);

  final _StateFailure _self;
  final $Res Function(_StateFailure) _then;

/// Create a copy of ConnectivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_StateFailure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
