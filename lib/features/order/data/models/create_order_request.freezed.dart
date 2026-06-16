// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateOrderRequestModel {

@JsonKey(name: 'shipping_address_id') String? get shippingAddressId;@JsonKey(name: 'billing_address_id') String? get billingAddressId;@JsonKey(name: 'payment_method_id') String? get paymentMethodId; String? get notes;@JsonKey(name: 'coupon_code') String? get couponCode;@JsonKey(name: 'line_items') List<Map<String, dynamic>> get lineItems;
/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderRequestModelCopyWith<CreateOrderRequestModel> get copyWith => _$CreateOrderRequestModelCopyWithImpl<CreateOrderRequestModel>(this as CreateOrderRequestModel, _$identity);

  /// Serializes this CreateOrderRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderRequestModel&&(identical(other.shippingAddressId, shippingAddressId) || other.shippingAddressId == shippingAddressId)&&(identical(other.billingAddressId, billingAddressId) || other.billingAddressId == billingAddressId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&const DeepCollectionEquality().equals(other.lineItems, lineItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shippingAddressId,billingAddressId,paymentMethodId,notes,couponCode,const DeepCollectionEquality().hash(lineItems));

@override
String toString() {
  return 'CreateOrderRequestModel(shippingAddressId: $shippingAddressId, billingAddressId: $billingAddressId, paymentMethodId: $paymentMethodId, notes: $notes, couponCode: $couponCode, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class $CreateOrderRequestModelCopyWith<$Res>  {
  factory $CreateOrderRequestModelCopyWith(CreateOrderRequestModel value, $Res Function(CreateOrderRequestModel) _then) = _$CreateOrderRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'shipping_address_id') String? shippingAddressId,@JsonKey(name: 'billing_address_id') String? billingAddressId,@JsonKey(name: 'payment_method_id') String? paymentMethodId, String? notes,@JsonKey(name: 'coupon_code') String? couponCode,@JsonKey(name: 'line_items') List<Map<String, dynamic>> lineItems
});




}
/// @nodoc
class _$CreateOrderRequestModelCopyWithImpl<$Res>
    implements $CreateOrderRequestModelCopyWith<$Res> {
  _$CreateOrderRequestModelCopyWithImpl(this._self, this._then);

  final CreateOrderRequestModel _self;
  final $Res Function(CreateOrderRequestModel) _then;

/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shippingAddressId = freezed,Object? billingAddressId = freezed,Object? paymentMethodId = freezed,Object? notes = freezed,Object? couponCode = freezed,Object? lineItems = null,}) {
  return _then(_self.copyWith(
shippingAddressId: freezed == shippingAddressId ? _self.shippingAddressId : shippingAddressId // ignore: cast_nullable_to_non_nullable
as String?,billingAddressId: freezed == billingAddressId ? _self.billingAddressId : billingAddressId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,lineItems: null == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderRequestModel].
extension CreateOrderRequestModelPatterns on CreateOrderRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'shipping_address_id')  String? shippingAddressId, @JsonKey(name: 'billing_address_id')  String? billingAddressId, @JsonKey(name: 'payment_method_id')  String? paymentMethodId,  String? notes, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'line_items')  List<Map<String, dynamic>> lineItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
return $default(_that.shippingAddressId,_that.billingAddressId,_that.paymentMethodId,_that.notes,_that.couponCode,_that.lineItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'shipping_address_id')  String? shippingAddressId, @JsonKey(name: 'billing_address_id')  String? billingAddressId, @JsonKey(name: 'payment_method_id')  String? paymentMethodId,  String? notes, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'line_items')  List<Map<String, dynamic>> lineItems)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel():
return $default(_that.shippingAddressId,_that.billingAddressId,_that.paymentMethodId,_that.notes,_that.couponCode,_that.lineItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'shipping_address_id')  String? shippingAddressId, @JsonKey(name: 'billing_address_id')  String? billingAddressId, @JsonKey(name: 'payment_method_id')  String? paymentMethodId,  String? notes, @JsonKey(name: 'coupon_code')  String? couponCode, @JsonKey(name: 'line_items')  List<Map<String, dynamic>> lineItems)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderRequestModel() when $default != null:
return $default(_that.shippingAddressId,_that.billingAddressId,_that.paymentMethodId,_that.notes,_that.couponCode,_that.lineItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateOrderRequestModel implements CreateOrderRequestModel {
  const _CreateOrderRequestModel({@JsonKey(name: 'shipping_address_id') this.shippingAddressId, @JsonKey(name: 'billing_address_id') this.billingAddressId, @JsonKey(name: 'payment_method_id') this.paymentMethodId, this.notes, @JsonKey(name: 'coupon_code') this.couponCode, @JsonKey(name: 'line_items') required final  List<Map<String, dynamic>> lineItems}): _lineItems = lineItems;
  factory _CreateOrderRequestModel.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestModelFromJson(json);

@override@JsonKey(name: 'shipping_address_id') final  String? shippingAddressId;
@override@JsonKey(name: 'billing_address_id') final  String? billingAddressId;
@override@JsonKey(name: 'payment_method_id') final  String? paymentMethodId;
@override final  String? notes;
@override@JsonKey(name: 'coupon_code') final  String? couponCode;
 final  List<Map<String, dynamic>> _lineItems;
@override@JsonKey(name: 'line_items') List<Map<String, dynamic>> get lineItems {
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineItems);
}


/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderRequestModelCopyWith<_CreateOrderRequestModel> get copyWith => __$CreateOrderRequestModelCopyWithImpl<_CreateOrderRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateOrderRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderRequestModel&&(identical(other.shippingAddressId, shippingAddressId) || other.shippingAddressId == shippingAddressId)&&(identical(other.billingAddressId, billingAddressId) || other.billingAddressId == billingAddressId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shippingAddressId,billingAddressId,paymentMethodId,notes,couponCode,const DeepCollectionEquality().hash(_lineItems));

@override
String toString() {
  return 'CreateOrderRequestModel(shippingAddressId: $shippingAddressId, billingAddressId: $billingAddressId, paymentMethodId: $paymentMethodId, notes: $notes, couponCode: $couponCode, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderRequestModelCopyWith<$Res> implements $CreateOrderRequestModelCopyWith<$Res> {
  factory _$CreateOrderRequestModelCopyWith(_CreateOrderRequestModel value, $Res Function(_CreateOrderRequestModel) _then) = __$CreateOrderRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'shipping_address_id') String? shippingAddressId,@JsonKey(name: 'billing_address_id') String? billingAddressId,@JsonKey(name: 'payment_method_id') String? paymentMethodId, String? notes,@JsonKey(name: 'coupon_code') String? couponCode,@JsonKey(name: 'line_items') List<Map<String, dynamic>> lineItems
});




}
/// @nodoc
class __$CreateOrderRequestModelCopyWithImpl<$Res>
    implements _$CreateOrderRequestModelCopyWith<$Res> {
  __$CreateOrderRequestModelCopyWithImpl(this._self, this._then);

  final _CreateOrderRequestModel _self;
  final $Res Function(_CreateOrderRequestModel) _then;

/// Create a copy of CreateOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shippingAddressId = freezed,Object? billingAddressId = freezed,Object? paymentMethodId = freezed,Object? notes = freezed,Object? couponCode = freezed,Object? lineItems = null,}) {
  return _then(_CreateOrderRequestModel(
shippingAddressId: freezed == shippingAddressId ? _self.shippingAddressId : shippingAddressId // ignore: cast_nullable_to_non_nullable
as String?,billingAddressId: freezed == billingAddressId ? _self.billingAddressId : billingAddressId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethodId: freezed == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,lineItems: null == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
