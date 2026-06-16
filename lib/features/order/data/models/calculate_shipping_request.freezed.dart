// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculate_shipping_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalculateShippingRequestModel {

@JsonKey(name: 'address_id') String? get addressId;@JsonKey(name: 'shipping_address') Map<String, dynamic>? get shippingAddress;@JsonKey(name: 'line_items') List<Map<String, dynamic>>? get lineItems;
/// Create a copy of CalculateShippingRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalculateShippingRequestModelCopyWith<CalculateShippingRequestModel> get copyWith => _$CalculateShippingRequestModelCopyWithImpl<CalculateShippingRequestModel>(this as CalculateShippingRequestModel, _$identity);

  /// Serializes this CalculateShippingRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalculateShippingRequestModel&&(identical(other.addressId, addressId) || other.addressId == addressId)&&const DeepCollectionEquality().equals(other.shippingAddress, shippingAddress)&&const DeepCollectionEquality().equals(other.lineItems, lineItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,addressId,const DeepCollectionEquality().hash(shippingAddress),const DeepCollectionEquality().hash(lineItems));

@override
String toString() {
  return 'CalculateShippingRequestModel(addressId: $addressId, shippingAddress: $shippingAddress, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class $CalculateShippingRequestModelCopyWith<$Res>  {
  factory $CalculateShippingRequestModelCopyWith(CalculateShippingRequestModel value, $Res Function(CalculateShippingRequestModel) _then) = _$CalculateShippingRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'address_id') String? addressId,@JsonKey(name: 'shipping_address') Map<String, dynamic>? shippingAddress,@JsonKey(name: 'line_items') List<Map<String, dynamic>>? lineItems
});




}
/// @nodoc
class _$CalculateShippingRequestModelCopyWithImpl<$Res>
    implements $CalculateShippingRequestModelCopyWith<$Res> {
  _$CalculateShippingRequestModelCopyWithImpl(this._self, this._then);

  final CalculateShippingRequestModel _self;
  final $Res Function(CalculateShippingRequestModel) _then;

/// Create a copy of CalculateShippingRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addressId = freezed,Object? shippingAddress = freezed,Object? lineItems = freezed,}) {
  return _then(_self.copyWith(
addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,shippingAddress: freezed == shippingAddress ? _self.shippingAddress : shippingAddress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,lineItems: freezed == lineItems ? _self.lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CalculateShippingRequestModel].
extension CalculateShippingRequestModelPatterns on CalculateShippingRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'shipping_address')  Map<String, dynamic>? shippingAddress, @JsonKey(name: 'line_items')  List<Map<String, dynamic>>? lineItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalculateShippingRequestModel() when $default != null:
return $default(_that.addressId,_that.shippingAddress,_that.lineItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'shipping_address')  Map<String, dynamic>? shippingAddress, @JsonKey(name: 'line_items')  List<Map<String, dynamic>>? lineItems)  $default,) {final _that = this;
switch (_that) {
case _CalculateShippingRequestModel():
return $default(_that.addressId,_that.shippingAddress,_that.lineItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'address_id')  String? addressId, @JsonKey(name: 'shipping_address')  Map<String, dynamic>? shippingAddress, @JsonKey(name: 'line_items')  List<Map<String, dynamic>>? lineItems)?  $default,) {final _that = this;
switch (_that) {
case _CalculateShippingRequestModel() when $default != null:
return $default(_that.addressId,_that.shippingAddress,_that.lineItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CalculateShippingRequestModel implements CalculateShippingRequestModel {
  const _CalculateShippingRequestModel({@JsonKey(name: 'address_id') this.addressId, @JsonKey(name: 'shipping_address') final  Map<String, dynamic>? shippingAddress, @JsonKey(name: 'line_items') final  List<Map<String, dynamic>>? lineItems}): _shippingAddress = shippingAddress,_lineItems = lineItems;
  factory _CalculateShippingRequestModel.fromJson(Map<String, dynamic> json) => _$CalculateShippingRequestModelFromJson(json);

@override@JsonKey(name: 'address_id') final  String? addressId;
 final  Map<String, dynamic>? _shippingAddress;
@override@JsonKey(name: 'shipping_address') Map<String, dynamic>? get shippingAddress {
  final value = _shippingAddress;
  if (value == null) return null;
  if (_shippingAddress is EqualUnmodifiableMapView) return _shippingAddress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Map<String, dynamic>>? _lineItems;
@override@JsonKey(name: 'line_items') List<Map<String, dynamic>>? get lineItems {
  final value = _lineItems;
  if (value == null) return null;
  if (_lineItems is EqualUnmodifiableListView) return _lineItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CalculateShippingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalculateShippingRequestModelCopyWith<_CalculateShippingRequestModel> get copyWith => __$CalculateShippingRequestModelCopyWithImpl<_CalculateShippingRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CalculateShippingRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalculateShippingRequestModel&&(identical(other.addressId, addressId) || other.addressId == addressId)&&const DeepCollectionEquality().equals(other._shippingAddress, _shippingAddress)&&const DeepCollectionEquality().equals(other._lineItems, _lineItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,addressId,const DeepCollectionEquality().hash(_shippingAddress),const DeepCollectionEquality().hash(_lineItems));

@override
String toString() {
  return 'CalculateShippingRequestModel(addressId: $addressId, shippingAddress: $shippingAddress, lineItems: $lineItems)';
}


}

/// @nodoc
abstract mixin class _$CalculateShippingRequestModelCopyWith<$Res> implements $CalculateShippingRequestModelCopyWith<$Res> {
  factory _$CalculateShippingRequestModelCopyWith(_CalculateShippingRequestModel value, $Res Function(_CalculateShippingRequestModel) _then) = __$CalculateShippingRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'address_id') String? addressId,@JsonKey(name: 'shipping_address') Map<String, dynamic>? shippingAddress,@JsonKey(name: 'line_items') List<Map<String, dynamic>>? lineItems
});




}
/// @nodoc
class __$CalculateShippingRequestModelCopyWithImpl<$Res>
    implements _$CalculateShippingRequestModelCopyWith<$Res> {
  __$CalculateShippingRequestModelCopyWithImpl(this._self, this._then);

  final _CalculateShippingRequestModel _self;
  final $Res Function(_CalculateShippingRequestModel) _then;

/// Create a copy of CalculateShippingRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addressId = freezed,Object? shippingAddress = freezed,Object? lineItems = freezed,}) {
  return _then(_CalculateShippingRequestModel(
addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,shippingAddress: freezed == shippingAddress ? _self._shippingAddress : shippingAddress // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,lineItems: freezed == lineItems ? _self._lineItems : lineItems // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>?,
  ));
}


}

// dart format on
