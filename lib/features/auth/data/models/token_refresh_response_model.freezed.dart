// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_refresh_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenRefreshResponseModel {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'expires_at') DateTime get expiresAt;@JsonKey(name: 'issued_at') DateTime get issuedAt;@JsonKey(name: 'refresh_token') String get refreshToken;
/// Create a copy of TokenRefreshResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenRefreshResponseModelCopyWith<TokenRefreshResponseModel> get copyWith => _$TokenRefreshResponseModelCopyWithImpl<TokenRefreshResponseModel>(this as TokenRefreshResponseModel, _$identity);

  /// Serializes this TokenRefreshResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenRefreshResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,issuedAt,refreshToken);

@override
String toString() {
  return 'TokenRefreshResponseModel(accessToken: $accessToken, expiresAt: $expiresAt, issuedAt: $issuedAt, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $TokenRefreshResponseModelCopyWith<$Res>  {
  factory $TokenRefreshResponseModelCopyWith(TokenRefreshResponseModel value, $Res Function(TokenRefreshResponseModel) _then) = _$TokenRefreshResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'issued_at') DateTime issuedAt,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class _$TokenRefreshResponseModelCopyWithImpl<$Res>
    implements $TokenRefreshResponseModelCopyWith<$Res> {
  _$TokenRefreshResponseModelCopyWithImpl(this._self, this._then);

  final TokenRefreshResponseModel _self;
  final $Res Function(TokenRefreshResponseModel) _then;

/// Create a copy of TokenRefreshResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? expiresAt = null,Object? issuedAt = null,Object? refreshToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenRefreshResponseModel].
extension TokenRefreshResponseModelPatterns on TokenRefreshResponseModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenRefreshResponseModel() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.issuedAt,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'refresh_token')  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshResponseModel():
return $default(_that.accessToken,_that.expiresAt,_that.issuedAt,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'expires_at')  DateTime expiresAt, @JsonKey(name: 'issued_at')  DateTime issuedAt, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _TokenRefreshResponseModel() when $default != null:
return $default(_that.accessToken,_that.expiresAt,_that.issuedAt,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenRefreshResponseModel implements TokenRefreshResponseModel {
  const _TokenRefreshResponseModel({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'expires_at') required this.expiresAt, @JsonKey(name: 'issued_at') required this.issuedAt, @JsonKey(name: 'refresh_token') required this.refreshToken});
  factory _TokenRefreshResponseModel.fromJson(Map<String, dynamic> json) => _$TokenRefreshResponseModelFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'expires_at') final  DateTime expiresAt;
@override@JsonKey(name: 'issued_at') final  DateTime issuedAt;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;

/// Create a copy of TokenRefreshResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenRefreshResponseModelCopyWith<_TokenRefreshResponseModel> get copyWith => __$TokenRefreshResponseModelCopyWithImpl<_TokenRefreshResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenRefreshResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenRefreshResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,expiresAt,issuedAt,refreshToken);

@override
String toString() {
  return 'TokenRefreshResponseModel(accessToken: $accessToken, expiresAt: $expiresAt, issuedAt: $issuedAt, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$TokenRefreshResponseModelCopyWith<$Res> implements $TokenRefreshResponseModelCopyWith<$Res> {
  factory _$TokenRefreshResponseModelCopyWith(_TokenRefreshResponseModel value, $Res Function(_TokenRefreshResponseModel) _then) = __$TokenRefreshResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'expires_at') DateTime expiresAt,@JsonKey(name: 'issued_at') DateTime issuedAt,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class __$TokenRefreshResponseModelCopyWithImpl<$Res>
    implements _$TokenRefreshResponseModelCopyWith<$Res> {
  __$TokenRefreshResponseModelCopyWithImpl(this._self, this._then);

  final _TokenRefreshResponseModel _self;
  final $Res Function(_TokenRefreshResponseModel) _then;

/// Create a copy of TokenRefreshResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? expiresAt = null,Object? issuedAt = null,Object? refreshToken = null,}) {
  return _then(_TokenRefreshResponseModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
