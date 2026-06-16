// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resend_verification_email_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResendVerificationEmailRequestModel {

 String get email;
/// Create a copy of ResendVerificationEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResendVerificationEmailRequestModelCopyWith<ResendVerificationEmailRequestModel> get copyWith => _$ResendVerificationEmailRequestModelCopyWithImpl<ResendVerificationEmailRequestModel>(this as ResendVerificationEmailRequestModel, _$identity);

  /// Serializes this ResendVerificationEmailRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResendVerificationEmailRequestModel&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ResendVerificationEmailRequestModel(email: $email)';
}


}

/// @nodoc
abstract mixin class $ResendVerificationEmailRequestModelCopyWith<$Res>  {
  factory $ResendVerificationEmailRequestModelCopyWith(ResendVerificationEmailRequestModel value, $Res Function(ResendVerificationEmailRequestModel) _then) = _$ResendVerificationEmailRequestModelCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ResendVerificationEmailRequestModelCopyWithImpl<$Res>
    implements $ResendVerificationEmailRequestModelCopyWith<$Res> {
  _$ResendVerificationEmailRequestModelCopyWithImpl(this._self, this._then);

  final ResendVerificationEmailRequestModel _self;
  final $Res Function(ResendVerificationEmailRequestModel) _then;

/// Create a copy of ResendVerificationEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResendVerificationEmailRequestModel].
extension ResendVerificationEmailRequestModelPatterns on ResendVerificationEmailRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResendVerificationEmailRequestModel() when $default != null:
return $default(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email)  $default,) {final _that = this;
switch (_that) {
case _ResendVerificationEmailRequestModel():
return $default(_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email)?  $default,) {final _that = this;
switch (_that) {
case _ResendVerificationEmailRequestModel() when $default != null:
return $default(_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResendVerificationEmailRequestModel implements ResendVerificationEmailRequestModel {
  const _ResendVerificationEmailRequestModel({required this.email});
  factory _ResendVerificationEmailRequestModel.fromJson(Map<String, dynamic> json) => _$ResendVerificationEmailRequestModelFromJson(json);

@override final  String email;

/// Create a copy of ResendVerificationEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResendVerificationEmailRequestModelCopyWith<_ResendVerificationEmailRequestModel> get copyWith => __$ResendVerificationEmailRequestModelCopyWithImpl<_ResendVerificationEmailRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResendVerificationEmailRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendVerificationEmailRequestModel&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'ResendVerificationEmailRequestModel(email: $email)';
}


}

/// @nodoc
abstract mixin class _$ResendVerificationEmailRequestModelCopyWith<$Res> implements $ResendVerificationEmailRequestModelCopyWith<$Res> {
  factory _$ResendVerificationEmailRequestModelCopyWith(_ResendVerificationEmailRequestModel value, $Res Function(_ResendVerificationEmailRequestModel) _then) = __$ResendVerificationEmailRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String email
});




}
/// @nodoc
class __$ResendVerificationEmailRequestModelCopyWithImpl<$Res>
    implements _$ResendVerificationEmailRequestModelCopyWith<$Res> {
  __$ResendVerificationEmailRequestModelCopyWithImpl(this._self, this._then);

  final _ResendVerificationEmailRequestModel _self;
  final $Res Function(_ResendVerificationEmailRequestModel) _then;

/// Create a copy of ResendVerificationEmailRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_ResendVerificationEmailRequestModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
