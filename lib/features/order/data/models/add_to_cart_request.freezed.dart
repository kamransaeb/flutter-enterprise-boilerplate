// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_cart_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddToCartRequestModel {

@JsonKey(name: 'product_id') String get productId;@JsonKey(name: 'variant_id') String? get variantId; int get quantity;
/// Create a copy of AddToCartRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToCartRequestModelCopyWith<AddToCartRequestModel> get copyWith => _$AddToCartRequestModelCopyWithImpl<AddToCartRequestModel>(this as AddToCartRequestModel, _$identity);

  /// Serializes this AddToCartRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToCartRequestModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,variantId,quantity);

@override
String toString() {
  return 'AddToCartRequestModel(productId: $productId, variantId: $variantId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $AddToCartRequestModelCopyWith<$Res>  {
  factory $AddToCartRequestModelCopyWith(AddToCartRequestModel value, $Res Function(AddToCartRequestModel) _then) = _$AddToCartRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'variant_id') String? variantId, int quantity
});




}
/// @nodoc
class _$AddToCartRequestModelCopyWithImpl<$Res>
    implements $AddToCartRequestModelCopyWith<$Res> {
  _$AddToCartRequestModelCopyWithImpl(this._self, this._then);

  final AddToCartRequestModel _self;
  final $Res Function(AddToCartRequestModel) _then;

/// Create a copy of AddToCartRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? variantId = freezed,Object? quantity = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AddToCartRequestModel].
extension AddToCartRequestModelPatterns on AddToCartRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'variant_id')  String? variantId,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddToCartRequestModel() when $default != null:
return $default(_that.productId,_that.variantId,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'variant_id')  String? variantId,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _AddToCartRequestModel():
return $default(_that.productId,_that.variantId,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_id')  String productId, @JsonKey(name: 'variant_id')  String? variantId,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _AddToCartRequestModel() when $default != null:
return $default(_that.productId,_that.variantId,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddToCartRequestModel implements AddToCartRequestModel {
  const _AddToCartRequestModel({@JsonKey(name: 'product_id') required this.productId, @JsonKey(name: 'variant_id') this.variantId, required this.quantity});
  factory _AddToCartRequestModel.fromJson(Map<String, dynamic> json) => _$AddToCartRequestModelFromJson(json);

@override@JsonKey(name: 'product_id') final  String productId;
@override@JsonKey(name: 'variant_id') final  String? variantId;
@override final  int quantity;

/// Create a copy of AddToCartRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToCartRequestModelCopyWith<_AddToCartRequestModel> get copyWith => __$AddToCartRequestModelCopyWithImpl<_AddToCartRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddToCartRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToCartRequestModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.variantId, variantId) || other.variantId == variantId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,variantId,quantity);

@override
String toString() {
  return 'AddToCartRequestModel(productId: $productId, variantId: $variantId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$AddToCartRequestModelCopyWith<$Res> implements $AddToCartRequestModelCopyWith<$Res> {
  factory _$AddToCartRequestModelCopyWith(_AddToCartRequestModel value, $Res Function(_AddToCartRequestModel) _then) = __$AddToCartRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_id') String productId,@JsonKey(name: 'variant_id') String? variantId, int quantity
});




}
/// @nodoc
class __$AddToCartRequestModelCopyWithImpl<$Res>
    implements _$AddToCartRequestModelCopyWith<$Res> {
  __$AddToCartRequestModelCopyWithImpl(this._self, this._then);

  final _AddToCartRequestModel _self;
  final $Res Function(_AddToCartRequestModel) _then;

/// Create a copy of AddToCartRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? variantId = freezed,Object? quantity = null,}) {
  return _then(_AddToCartRequestModel(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,variantId: freezed == variantId ? _self.variantId : variantId // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
