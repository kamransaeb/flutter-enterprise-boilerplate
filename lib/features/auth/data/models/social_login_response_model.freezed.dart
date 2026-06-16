// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLoginResponseModel {

 UserModel get userModel; AuthTokensModel get authTokensModel;@JsonKey(name: 'is_new_user') bool get isNewUser;
/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginResponseModelCopyWith<SocialLoginResponseModel> get copyWith => _$SocialLoginResponseModelCopyWithImpl<SocialLoginResponseModel>(this as SocialLoginResponseModel, _$identity);

  /// Serializes this SocialLoginResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginResponseModel&&(identical(other.userModel, userModel) || other.userModel == userModel)&&(identical(other.authTokensModel, authTokensModel) || other.authTokensModel == authTokensModel)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userModel,authTokensModel,isNewUser);

@override
String toString() {
  return 'SocialLoginResponseModel(userModel: $userModel, authTokensModel: $authTokensModel, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class $SocialLoginResponseModelCopyWith<$Res>  {
  factory $SocialLoginResponseModelCopyWith(SocialLoginResponseModel value, $Res Function(SocialLoginResponseModel) _then) = _$SocialLoginResponseModelCopyWithImpl;
@useResult
$Res call({
 UserModel userModel, AuthTokensModel authTokensModel,@JsonKey(name: 'is_new_user') bool isNewUser
});


$UserModelCopyWith<$Res> get userModel;$AuthTokensModelCopyWith<$Res> get authTokensModel;

}
/// @nodoc
class _$SocialLoginResponseModelCopyWithImpl<$Res>
    implements $SocialLoginResponseModelCopyWith<$Res> {
  _$SocialLoginResponseModelCopyWithImpl(this._self, this._then);

  final SocialLoginResponseModel _self;
  final $Res Function(SocialLoginResponseModel) _then;

/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userModel = null,Object? authTokensModel = null,Object? isNewUser = null,}) {
  return _then(_self.copyWith(
userModel: null == userModel ? _self.userModel : userModel // ignore: cast_nullable_to_non_nullable
as UserModel,authTokensModel: null == authTokensModel ? _self.authTokensModel : authTokensModel // ignore: cast_nullable_to_non_nullable
as AuthTokensModel,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get userModel {
  
  return $UserModelCopyWith<$Res>(_self.userModel, (value) {
    return _then(_self.copyWith(userModel: value));
  });
}/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthTokensModelCopyWith<$Res> get authTokensModel {
  
  return $AuthTokensModelCopyWith<$Res>(_self.authTokensModel, (value) {
    return _then(_self.copyWith(authTokensModel: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialLoginResponseModel].
extension SocialLoginResponseModelPatterns on SocialLoginResponseModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserModel userModel,  AuthTokensModel authTokensModel, @JsonKey(name: 'is_new_user')  bool isNewUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLoginResponseModel() when $default != null:
return $default(_that.userModel,_that.authTokensModel,_that.isNewUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserModel userModel,  AuthTokensModel authTokensModel, @JsonKey(name: 'is_new_user')  bool isNewUser)  $default,) {final _that = this;
switch (_that) {
case _SocialLoginResponseModel():
return $default(_that.userModel,_that.authTokensModel,_that.isNewUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserModel userModel,  AuthTokensModel authTokensModel, @JsonKey(name: 'is_new_user')  bool isNewUser)?  $default,) {final _that = this;
switch (_that) {
case _SocialLoginResponseModel() when $default != null:
return $default(_that.userModel,_that.authTokensModel,_that.isNewUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLoginResponseModel implements SocialLoginResponseModel {
  const _SocialLoginResponseModel({required this.userModel, required this.authTokensModel, @JsonKey(name: 'is_new_user') this.isNewUser = false});
  factory _SocialLoginResponseModel.fromJson(Map<String, dynamic> json) => _$SocialLoginResponseModelFromJson(json);

@override final  UserModel userModel;
@override final  AuthTokensModel authTokensModel;
@override@JsonKey(name: 'is_new_user') final  bool isNewUser;

/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginResponseModelCopyWith<_SocialLoginResponseModel> get copyWith => __$SocialLoginResponseModelCopyWithImpl<_SocialLoginResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLoginResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLoginResponseModel&&(identical(other.userModel, userModel) || other.userModel == userModel)&&(identical(other.authTokensModel, authTokensModel) || other.authTokensModel == authTokensModel)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userModel,authTokensModel,isNewUser);

@override
String toString() {
  return 'SocialLoginResponseModel(userModel: $userModel, authTokensModel: $authTokensModel, isNewUser: $isNewUser)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginResponseModelCopyWith<$Res> implements $SocialLoginResponseModelCopyWith<$Res> {
  factory _$SocialLoginResponseModelCopyWith(_SocialLoginResponseModel value, $Res Function(_SocialLoginResponseModel) _then) = __$SocialLoginResponseModelCopyWithImpl;
@override @useResult
$Res call({
 UserModel userModel, AuthTokensModel authTokensModel,@JsonKey(name: 'is_new_user') bool isNewUser
});


@override $UserModelCopyWith<$Res> get userModel;@override $AuthTokensModelCopyWith<$Res> get authTokensModel;

}
/// @nodoc
class __$SocialLoginResponseModelCopyWithImpl<$Res>
    implements _$SocialLoginResponseModelCopyWith<$Res> {
  __$SocialLoginResponseModelCopyWithImpl(this._self, this._then);

  final _SocialLoginResponseModel _self;
  final $Res Function(_SocialLoginResponseModel) _then;

/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userModel = null,Object? authTokensModel = null,Object? isNewUser = null,}) {
  return _then(_SocialLoginResponseModel(
userModel: null == userModel ? _self.userModel : userModel // ignore: cast_nullable_to_non_nullable
as UserModel,authTokensModel: null == authTokensModel ? _self.authTokensModel : authTokensModel // ignore: cast_nullable_to_non_nullable
as AuthTokensModel,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get userModel {
  
  return $UserModelCopyWith<$Res>(_self.userModel, (value) {
    return _then(_self.copyWith(userModel: value));
  });
}/// Create a copy of SocialLoginResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthTokensModelCopyWith<$Res> get authTokensModel {
  
  return $AuthTokensModelCopyWith<$Res>(_self.authTokensModel, (value) {
    return _then(_self.copyWith(authTokensModel: value));
  });
}
}

// dart format on
