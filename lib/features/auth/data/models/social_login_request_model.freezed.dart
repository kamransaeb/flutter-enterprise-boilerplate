// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginRequestModel {

 String get provider;// google, facebook, apple
 String get token;@JsonKey(name: 'device_id') String? get deviceId;@JsonKey(name: 'fcm_token') String? get fcmToken;
/// Create a copy of SocialLoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginRequestModelCopyWith<SocialLoginRequestModel> get copyWith => _$SocialLoginRequestModelCopyWithImpl<SocialLoginRequestModel>(this as SocialLoginRequestModel, _$identity);

  /// Serializes this SocialLoginRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginRequestModel&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.token, token) || other.token == token)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,token,deviceId,fcmToken);

@override
String toString() {
  return 'SocialLoginRequestModel(provider: $provider, token: $token, deviceId: $deviceId, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class $SocialLoginRequestModelCopyWith<$Res>  {
  factory $SocialLoginRequestModelCopyWith(SocialLoginRequestModel value, $Res Function(SocialLoginRequestModel) _then) = _$SocialLoginRequestModelCopyWithImpl;
@useResult
$Res call({
 String provider, String token,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class _$SocialLoginRequestModelCopyWithImpl<$Res>
    implements $SocialLoginRequestModelCopyWith<$Res> {
  _$SocialLoginRequestModelCopyWithImpl(this._self, this._then);

  final SocialLoginRequestModel _self;
  final $Res Function(SocialLoginRequestModel) _then;

/// Create a copy of SocialLoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? token = null,Object? deviceId = freezed,Object? fcmToken = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLoginRequestModel].
extension SocialLoginRequestModelPatterns on SocialLoginRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  String token, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLoginRequestModel() when $default != null:
return $default(_that.provider,_that.token,_that.deviceId,_that.fcmToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  String token, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'fcm_token')  String? fcmToken)  $default,) {final _that = this;
switch (_that) {
case _SocialLoginRequestModel():
return $default(_that.provider,_that.token,_that.deviceId,_that.fcmToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  String token, @JsonKey(name: 'device_id')  String? deviceId, @JsonKey(name: 'fcm_token')  String? fcmToken)?  $default,) {final _that = this;
switch (_that) {
case _SocialLoginRequestModel() when $default != null:
return $default(_that.provider,_that.token,_that.deviceId,_that.fcmToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLoginRequestModel implements SocialLoginRequestModel {
  const _SocialLoginRequestModel({required this.provider, required this.token, @JsonKey(name: 'device_id') this.deviceId, @JsonKey(name: 'fcm_token') this.fcmToken});
  factory _SocialLoginRequestModel.fromJson(Map<String, dynamic> json) => _$SocialLoginRequestModelFromJson(json);

@override final  String provider;
// google, facebook, apple
@override final  String token;
@override@JsonKey(name: 'device_id') final  String? deviceId;
@override@JsonKey(name: 'fcm_token') final  String? fcmToken;

/// Create a copy of SocialLoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginRequestModelCopyWith<_SocialLoginRequestModel> get copyWith => __$SocialLoginRequestModelCopyWithImpl<_SocialLoginRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLoginRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLoginRequestModel&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.token, token) || other.token == token)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,token,deviceId,fcmToken);

@override
String toString() {
  return 'SocialLoginRequestModel(provider: $provider, token: $token, deviceId: $deviceId, fcmToken: $fcmToken)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginRequestModelCopyWith<$Res> implements $SocialLoginRequestModelCopyWith<$Res> {
  factory _$SocialLoginRequestModelCopyWith(_SocialLoginRequestModel value, $Res Function(_SocialLoginRequestModel) _then) = __$SocialLoginRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String provider, String token,@JsonKey(name: 'device_id') String? deviceId,@JsonKey(name: 'fcm_token') String? fcmToken
});




}
/// @nodoc
class __$SocialLoginRequestModelCopyWithImpl<$Res>
    implements _$SocialLoginRequestModelCopyWith<$Res> {
  __$SocialLoginRequestModelCopyWithImpl(this._self, this._then);

  final _SocialLoginRequestModel _self;
  final $Res Function(_SocialLoginRequestModel) _then;

/// Create a copy of SocialLoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? token = null,Object? deviceId = freezed,Object? fcmToken = freezed,}) {
  return _then(_SocialLoginRequestModel(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
