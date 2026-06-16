// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_cart_item_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateCartItemRequestModel {

 String get id; int get quantity;
/// Create a copy of UpdateCartItemRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCartItemRequestModelCopyWith<UpdateCartItemRequestModel> get copyWith => _$UpdateCartItemRequestModelCopyWithImpl<UpdateCartItemRequestModel>(this as UpdateCartItemRequestModel, _$identity);

  /// Serializes this UpdateCartItemRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCartItemRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantity);

@override
String toString() {
  return 'UpdateCartItemRequestModel(id: $id, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $UpdateCartItemRequestModelCopyWith<$Res>  {
  factory $UpdateCartItemRequestModelCopyWith(UpdateCartItemRequestModel value, $Res Function(UpdateCartItemRequestModel) _then) = _$UpdateCartItemRequestModelCopyWithImpl;
@useResult
$Res call({
 String id, int quantity
});




}
/// @nodoc
class _$UpdateCartItemRequestModelCopyWithImpl<$Res>
    implements $UpdateCartItemRequestModelCopyWith<$Res> {
  _$UpdateCartItemRequestModelCopyWithImpl(this._self, this._then);

  final UpdateCartItemRequestModel _self;
  final $Res Function(UpdateCartItemRequestModel) _then;

/// Create a copy of UpdateCartItemRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateCartItemRequestModel].
extension UpdateCartItemRequestModelPatterns on UpdateCartItemRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateCartItemRequestModel() when $default != null:
return $default(_that.id,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _UpdateCartItemRequestModel():
return $default(_that.id,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _UpdateCartItemRequestModel() when $default != null:
return $default(_that.id,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateCartItemRequestModel implements UpdateCartItemRequestModel {
  const _UpdateCartItemRequestModel({required this.id, required this.quantity});
  factory _UpdateCartItemRequestModel.fromJson(Map<String, dynamic> json) => _$UpdateCartItemRequestModelFromJson(json);

@override final  String id;
@override final  int quantity;

/// Create a copy of UpdateCartItemRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCartItemRequestModelCopyWith<_UpdateCartItemRequestModel> get copyWith => __$UpdateCartItemRequestModelCopyWithImpl<_UpdateCartItemRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateCartItemRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCartItemRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantity);

@override
String toString() {
  return 'UpdateCartItemRequestModel(id: $id, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$UpdateCartItemRequestModelCopyWith<$Res> implements $UpdateCartItemRequestModelCopyWith<$Res> {
  factory _$UpdateCartItemRequestModelCopyWith(_UpdateCartItemRequestModel value, $Res Function(_UpdateCartItemRequestModel) _then) = __$UpdateCartItemRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int quantity
});




}
/// @nodoc
class __$UpdateCartItemRequestModelCopyWithImpl<$Res>
    implements _$UpdateCartItemRequestModelCopyWith<$Res> {
  __$UpdateCartItemRequestModelCopyWithImpl(this._self, this._then);

  final _UpdateCartItemRequestModel _self;
  final $Res Function(_UpdateCartItemRequestModel) _then;

/// Create a copy of UpdateCartItemRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quantity = null,}) {
  return _then(_UpdateCartItemRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
