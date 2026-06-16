// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_email_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyEmailRequestModel {

 String get token; String get email;
/// Create a copy of VerifyEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyEmailRequestModelCopyWith<VerifyEmailRequestModel> get copyWith => _$VerifyEmailRequestModelCopyWithImpl<VerifyEmailRequestModel>(this as VerifyEmailRequestModel, _$identity);

  /// Serializes this VerifyEmailRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyEmailRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,email);

@override
String toString() {
  return 'VerifyEmailRequestModel(token: $token, email: $email)';
}


}

/// @nodoc
abstract mixin class $VerifyEmailRequestModelCopyWith<$Res>  {
  factory $VerifyEmailRequestModelCopyWith(VerifyEmailRequestModel value, $Res Function(VerifyEmailRequestModel) _then) = _$VerifyEmailRequestModelCopyWithImpl;
@useResult
$Res call({
 String token, String email
});




}
/// @nodoc
class _$VerifyEmailRequestModelCopyWithImpl<$Res>
    implements $VerifyEmailRequestModelCopyWith<$Res> {
  _$VerifyEmailRequestModelCopyWithImpl(this._self, this._then);

  final VerifyEmailRequestModel _self;
  final $Res Function(VerifyEmailRequestModel) _then;

/// Create a copy of VerifyEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? email = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyEmailRequestModel].
extension VerifyEmailRequestModelPatterns on VerifyEmailRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyEmailRequestModel() when $default != null:
return $default(_that.token,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String email)  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailRequestModel():
return $default(_that.token,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String email)?  $default,) {final _that = this;
switch (_that) {
case _VerifyEmailRequestModel() when $default != null:
return $default(_that.token,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyEmailRequestModel implements VerifyEmailRequestModel {
  const _VerifyEmailRequestModel({required this.token, required this.email});
  factory _VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyEmailRequestModelFromJson(json);

@override final  String token;
@override final  String email;

/// Create a copy of VerifyEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyEmailRequestModelCopyWith<_VerifyEmailRequestModel> get copyWith => __$VerifyEmailRequestModelCopyWithImpl<_VerifyEmailRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyEmailRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyEmailRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,email);

@override
String toString() {
  return 'VerifyEmailRequestModel(token: $token, email: $email)';
}


}

/// @nodoc
abstract mixin class _$VerifyEmailRequestModelCopyWith<$Res> implements $VerifyEmailRequestModelCopyWith<$Res> {
  factory _$VerifyEmailRequestModelCopyWith(_VerifyEmailRequestModel value, $Res Function(_VerifyEmailRequestModel) _then) = __$VerifyEmailRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String token, String email
});




}
/// @nodoc
class __$VerifyEmailRequestModelCopyWithImpl<$Res>
    implements _$VerifyEmailRequestModelCopyWith<$Res> {
  __$VerifyEmailRequestModelCopyWithImpl(this._self, this._then);

  final _VerifyEmailRequestModel _self;
  final $Res Function(_VerifyEmailRequestModel) _then;

/// Create a copy of VerifyEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? email = null,}) {
  return _then(_VerifyEmailRequestModel(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
