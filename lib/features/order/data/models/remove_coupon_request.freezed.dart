// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remove_coupon_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoveCouponRequestModel {

@JsonKey(name: 'coupon_code') String? get couponCode;
/// Create a copy of RemoveCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveCouponRequestModelCopyWith<RemoveCouponRequestModel> get copyWith => _$RemoveCouponRequestModelCopyWithImpl<RemoveCouponRequestModel>(this as RemoveCouponRequestModel, _$identity);

  /// Serializes this RemoveCouponRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveCouponRequestModel&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponCode);

@override
String toString() {
  return 'RemoveCouponRequestModel(couponCode: $couponCode)';
}


}

/// @nodoc
abstract mixin class $RemoveCouponRequestModelCopyWith<$Res>  {
  factory $RemoveCouponRequestModelCopyWith(RemoveCouponRequestModel value, $Res Function(RemoveCouponRequestModel) _then) = _$RemoveCouponRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'coupon_code') String? couponCode
});




}
/// @nodoc
class _$RemoveCouponRequestModelCopyWithImpl<$Res>
    implements $RemoveCouponRequestModelCopyWith<$Res> {
  _$RemoveCouponRequestModelCopyWithImpl(this._self, this._then);

  final RemoveCouponRequestModel _self;
  final $Res Function(RemoveCouponRequestModel) _then;

/// Create a copy of RemoveCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponCode = freezed,}) {
  return _then(_self.copyWith(
couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoveCouponRequestModel].
extension RemoveCouponRequestModelPatterns on RemoveCouponRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'coupon_code')  String? couponCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoveCouponRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'coupon_code')  String? couponCode)  $default,) {final _that = this;
switch (_that) {
case _RemoveCouponRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'coupon_code')  String? couponCode)?  $default,) {final _that = this;
switch (_that) {
case _RemoveCouponRequestModel() when $default != null:
return $default(_that.couponCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoveCouponRequestModel implements RemoveCouponRequestModel {
  const _RemoveCouponRequestModel({@JsonKey(name: 'coupon_code') this.couponCode});
  factory _RemoveCouponRequestModel.fromJson(Map<String, dynamic> json) => _$RemoveCouponRequestModelFromJson(json);

@override@JsonKey(name: 'coupon_code') final  String? couponCode;

/// Create a copy of RemoveCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveCouponRequestModelCopyWith<_RemoveCouponRequestModel> get copyWith => __$RemoveCouponRequestModelCopyWithImpl<_RemoveCouponRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoveCouponRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveCouponRequestModel&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponCode);

@override
String toString() {
  return 'RemoveCouponRequestModel(couponCode: $couponCode)';
}


}

/// @nodoc
abstract mixin class _$RemoveCouponRequestModelCopyWith<$Res> implements $RemoveCouponRequestModelCopyWith<$Res> {
  factory _$RemoveCouponRequestModelCopyWith(_RemoveCouponRequestModel value, $Res Function(_RemoveCouponRequestModel) _then) = __$RemoveCouponRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'coupon_code') String? couponCode
});




}
/// @nodoc
class __$RemoveCouponRequestModelCopyWithImpl<$Res>
    implements _$RemoveCouponRequestModelCopyWith<$Res> {
  __$RemoveCouponRequestModelCopyWithImpl(this._self, this._then);

  final _RemoveCouponRequestModel _self;
  final $Res Function(_RemoveCouponRequestModel) _then;

/// Create a copy of RemoveCouponRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponCode = freezed,}) {
  return _then(_RemoveCouponRequestModel(
couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
