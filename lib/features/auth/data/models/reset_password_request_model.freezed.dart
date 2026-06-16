// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResetPasswordRequestModel {

 String get token; String get password;@JsonKey(name: 'confirm_password') String get confirmPassword;
/// Create a copy of ResetPasswordRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordRequestModelCopyWith<ResetPasswordRequestModel> get copyWith => _$ResetPasswordRequestModelCopyWithImpl<ResetPasswordRequestModel>(this as ResetPasswordRequestModel, _$identity);

  /// Serializes this ResetPasswordRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,password,confirmPassword);

@override
String toString() {
  return 'ResetPasswordRequestModel(token: $token, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordRequestModelCopyWith<$Res>  {
  factory $ResetPasswordRequestModelCopyWith(ResetPasswordRequestModel value, $Res Function(ResetPasswordRequestModel) _then) = _$ResetPasswordRequestModelCopyWithImpl;
@useResult
$Res call({
 String token, String password,@JsonKey(name: 'confirm_password') String confirmPassword
});




}
/// @nodoc
class _$ResetPasswordRequestModelCopyWithImpl<$Res>
    implements $ResetPasswordRequestModelCopyWith<$Res> {
  _$ResetPasswordRequestModelCopyWithImpl(this._self, this._then);

  final ResetPasswordRequestModel _self;
  final $Res Function(ResetPasswordRequestModel) _then;

/// Create a copy of ResetPasswordRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? password = null,Object? confirmPassword = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordRequestModel].
extension ResetPasswordRequestModelPatterns on ResetPasswordRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String password, @JsonKey(name: 'confirm_password')  String confirmPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordRequestModel() when $default != null:
return $default(_that.token,_that.password,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String password, @JsonKey(name: 'confirm_password')  String confirmPassword)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestModel():
return $default(_that.token,_that.password,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String password, @JsonKey(name: 'confirm_password')  String confirmPassword)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordRequestModel() when $default != null:
return $default(_that.token,_that.password,_that.confirmPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPasswordRequestModel implements ResetPasswordRequestModel {
  const _ResetPasswordRequestModel({required this.token, required this.password, @JsonKey(name: 'confirm_password') required this.confirmPassword});
  factory _ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestModelFromJson(json);

@override final  String token;
@override final  String password;
@override@JsonKey(name: 'confirm_password') final  String confirmPassword;

/// Create a copy of ResetPasswordRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordRequestModelCopyWith<_ResetPasswordRequestModel> get copyWith => __$ResetPasswordRequestModelCopyWithImpl<_ResetPasswordRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordRequestModel&&(identical(other.token, token) || other.token == token)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,password,confirmPassword);

@override
String toString() {
  return 'ResetPasswordRequestModel(token: $token, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordRequestModelCopyWith<$Res> implements $ResetPasswordRequestModelCopyWith<$Res> {
  factory _$ResetPasswordRequestModelCopyWith(_ResetPasswordRequestModel value, $Res Function(_ResetPasswordRequestModel) _then) = __$ResetPasswordRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String token, String password,@JsonKey(name: 'confirm_password') String confirmPassword
});




}
/// @nodoc
class __$ResetPasswordRequestModelCopyWithImpl<$Res>
    implements _$ResetPasswordRequestModelCopyWith<$Res> {
  __$ResetPasswordRequestModelCopyWithImpl(this._self, this._then);

  final _ResetPasswordRequestModel _self;
  final $Res Function(_ResetPasswordRequestModel) _then;

/// Create a copy of ResetPasswordRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? password = null,Object? confirmPassword = null,}) {
  return _then(_ResetPasswordRequestModel(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
