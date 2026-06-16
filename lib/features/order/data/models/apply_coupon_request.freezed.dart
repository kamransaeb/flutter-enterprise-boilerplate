// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply_coupon_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplyCouponRequestModel {

@JsonKey(name: 'coupon_code') String get couponCode;
/// Create a copy of ApplyCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyCouponRequestModelCopyWith<ApplyCouponRequestModel> get copyWith => _$ApplyCouponRequestModelCopyWithImpl<ApplyCouponRequestModel>(this as ApplyCouponRequestModel, _$identity);

  /// Serializes this ApplyCouponRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyCouponRequestModel&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponCode);

@override
String toString() {
  return 'ApplyCouponRequestModel(couponCode: $couponCode)';
}


}

/// @nodoc
abstract mixin class $ApplyCouponRequestModelCopyWith<$Res>  {
  factory $ApplyCouponRequestModelCopyWith(ApplyCouponRequestModel value, $Res Function(ApplyCouponRequestModel) _then) = _$ApplyCouponRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'coupon_code') String couponCode
});




}
/// @nodoc
class _$ApplyCouponRequestModelCopyWithImpl<$Res>
    implements $ApplyCouponRequestModelCopyWith<$Res> {
  _$ApplyCouponRequestModelCopyWithImpl(this._self, this._then);

  final ApplyCouponRequestModel _self;
  final $Res Function(ApplyCouponRequestModel) _then;

/// Create a copy of ApplyCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponCode = null,}) {
  return _then(_self.copyWith(
couponCode: null == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplyCouponRequestModel].
extension ApplyCouponRequestModelPatterns on ApplyCouponRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'coupon_code')  String couponCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyCouponRequestModel() when $default != null:
return $default(_that.couponCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'coupon_code')  String couponCode)  $default,) {final _that = this;
switch (_that) {
case _ApplyCouponRequestModel():
return $default(_that.couponCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'coupon_code')  String couponCode)?  $default,) {final _that = this;
switch (_that) {
case _ApplyCouponRequestModel() when $default != null:
return $default(_that.couponCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplyCouponRequestModel implements ApplyCouponRequestModel {
  const _ApplyCouponRequestModel({@JsonKey(name: 'coupon_code') required this.couponCode});
  factory _ApplyCouponRequestModel.fromJson(Map<String, dynamic> json) => _$ApplyCouponRequestModelFromJson(json);

@override@JsonKey(name: 'coupon_code') final  String couponCode;

/// Create a copy of ApplyCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyCouponRequestModelCopyWith<_ApplyCouponRequestModel> get copyWith => __$ApplyCouponRequestModelCopyWithImpl<_ApplyCouponRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplyCouponRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyCouponRequestModel&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponCode);

@override
String toString() {
  return 'ApplyCouponRequestModel(couponCode: $couponCode)';
}


}

/// @nodoc
abstract mixin class _$ApplyCouponRequestModelCopyWith<$Res> implements $ApplyCouponRequestModelCopyWith<$Res> {
  factory _$ApplyCouponRequestModelCopyWith(_ApplyCouponRequestModel value, $Res Function(_ApplyCouponRequestModel) _then) = __$ApplyCouponRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'coupon_code') String couponCode
});




}
/// @nodoc
class __$ApplyCouponRequestModelCopyWithImpl<$Res>
    implements _$ApplyCouponRequestModelCopyWith<$Res> {
  __$ApplyCouponRequestModelCopyWithImpl(this._self, this._then);

  final _ApplyCouponRequestModel _self;
  final $Res Function(_ApplyCouponRequestModel) _then;

/// Create a copy of ApplyCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponCode = null,}) {
  return _then(_ApplyCouponRequestModel(
couponCode: null == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
