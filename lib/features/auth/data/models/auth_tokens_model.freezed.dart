// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_tokens_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthTokensModel {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'refresh_token') String get refreshToken;@JsonKey(name: 'issued_at') DateTime get issuedAt;@JsonKey(name: 'expires_at') DateTime get expiresAt;@JsonKey(name: 'token_type') String get tokenType;
/// Create a copy of AuthTokensModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthTokensModelCopyWith<AuthTokensModel> get copyWith => _$AuthTokensModelCopyWithImpl<AuthTokensModel>(this as AuthTokensModel, _$identity);

  /// Serializes this AuthTokensModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthTokensModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,issuedAt,expiresAt,tokenType);

@override
String toString() {
  return 'AuthTokensModel(accessToken: $accessToken, refreshToken: $refreshToken, issuedAt: $issuedAt, expiresAt: $expiresAt, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class $AuthTokensModelCopyWith<$Res>  {
  factory $AuthTokensModelCopyWith(AuthTokensModel value, $Res Function(AuthTokensModel) _then) = _$AuthTokensModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'issued_at') DateTime issuedAt,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'token_type') String tokenType
});




}
/// @nodoc
class _$AuthTokensModelCopyWithImpl<$Res>
    implements $AuthTokensModelCopyWith<$Res> {
  _$AuthTokensModelCopyWithImpl(this._self, this._then);

  final AuthTokensModel _self;
  final $Res Function(AuthTokensModel) _then;

/// Create a copy of AuthTokensModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? issuedAt = null,Object? expiresAt = null,Object? tokenType = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthTokensModel].
extension AuthTokensModelPatterns on AuthTokensModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'token_type')  String tokenType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthTokensModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.issuedAt,_that.expiresAt,_that.tokenType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'token_type')  String tokenType)  $default,) {final _that = this;
switch (_that) {
case _AuthTokensModel():
return $default(_that.accessToken,_that.refreshToken,_that.issuedAt,_that.expiresAt,_that.tokenType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'token_type')  String tokenType)?  $default,) {final _that = this;
switch (_that) {
case _AuthTokensModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.issuedAt,_that.expiresAt,_that.tokenType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthTokensModel extends AuthTokensModel {
  const _AuthTokensModel({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'refresh_token') required this.refreshToken, @JsonKey(name: 'issued_at') required this.issuedAt, @JsonKey(name: 'expires_at') required this.expiresAt, @JsonKey(name: 'token_type') required this.tokenType}): super._();
  factory _AuthTokensModel.fromJson(Map<String, dynamic> json) => _$AuthTokensModelFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override@JsonKey(name: 'issued_at') final  DateTime issuedAt;
@override@JsonKey(name: 'expires_at') final  DateTime expiresAt;
@override@JsonKey(name: 'token_type') final  String tokenType;

/// Create a copy of AuthTokensModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthTokensModelCopyWith<_AuthTokensModel> get copyWith => __$AuthTokensModelCopyWithImpl<_AuthTokensModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthTokensModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthTokensModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,issuedAt,expiresAt,tokenType);

@override
String toString() {
  return 'AuthTokensModel(accessToken: $accessToken, refreshToken: $refreshToken, issuedAt: $issuedAt, expiresAt: $expiresAt, tokenType: $tokenType)';
}


}

/// @nodoc
abstract mixin class _$AuthTokensModelCopyWith<$Res> implements $AuthTokensModelCopyWith<$Res> {
  factory _$AuthTokensModelCopyWith(_AuthTokensModel value, $Res Function(_AuthTokensModel) _then) = __$AuthTokensModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'issued_at') DateTime issuedAt,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'token_type') String tokenType
});




}
/// @nodoc
class __$AuthTokensModelCopyWithImpl<$Res>
    implements _$AuthTokensModelCopyWith<$Res> {
  __$AuthTokensModelCopyWithImpl(this._self, this._then);

  final _AuthTokensModel _self;
  final $Res Function(_AuthTokensModel) _then;

/// Create a copy of AuthTokensModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? issuedAt = null,Object? expiresAt = null,Object? tokenType = null,}) {
  return _then(_AuthTokensModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
