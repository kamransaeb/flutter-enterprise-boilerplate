// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'return_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReturnOrderRequestModel {

 String? get reason;@JsonKey(name: 'item_ids') List<String>? get itemIds;
/// Create a copy of ReturnOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReturnOrderRequestModelCopyWith<ReturnOrderRequestModel> get copyWith => _$ReturnOrderRequestModelCopyWithImpl<ReturnOrderRequestModel>(this as ReturnOrderRequestModel, _$identity);

  /// Serializes this ReturnOrderRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReturnOrderRequestModel&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.itemIds, itemIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,const DeepCollectionEquality().hash(itemIds));

@override
String toString() {
  return 'ReturnOrderRequestModel(reason: $reason, itemIds: $itemIds)';
}


}

/// @nodoc
abstract mixin class $ReturnOrderRequestModelCopyWith<$Res>  {
  factory $ReturnOrderRequestModelCopyWith(ReturnOrderRequestModel value, $Res Function(ReturnOrderRequestModel) _then) = _$ReturnOrderRequestModelCopyWithImpl;
@useResult
$Res call({
 String? reason,@JsonKey(name: 'item_ids') List<String>? itemIds
});




}
/// @nodoc
class _$ReturnOrderRequestModelCopyWithImpl<$Res>
    implements $ReturnOrderRequestModelCopyWith<$Res> {
  _$ReturnOrderRequestModelCopyWithImpl(this._self, this._then);

  final ReturnOrderRequestModel _self;
  final $Res Function(ReturnOrderRequestModel) _then;

/// Create a copy of ReturnOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reason = freezed,Object? itemIds = freezed,}) {
  return _then(_self.copyWith(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,itemIds: freezed == itemIds ? _self.itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReturnOrderRequestModel].
extension ReturnOrderRequestModelPatterns on ReturnOrderRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? reason, @JsonKey(name: 'item_ids')  List<String>? itemIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReturnOrderRequestModel() when $default != null:
return $default(_that.reason,_that.itemIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? reason, @JsonKey(name: 'item_ids')  List<String>? itemIds)  $default,) {final _that = this;
switch (_that) {
case _ReturnOrderRequestModel():
return $default(_that.reason,_that.itemIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? reason, @JsonKey(name: 'item_ids')  List<String>? itemIds)?  $default,) {final _that = this;
switch (_that) {
case _ReturnOrderRequestModel() when $default != null:
return $default(_that.reason,_that.itemIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReturnOrderRequestModel implements ReturnOrderRequestModel {
  const _ReturnOrderRequestModel({this.reason, @JsonKey(name: 'item_ids') final  List<String>? itemIds}): _itemIds = itemIds;
  factory _ReturnOrderRequestModel.fromJson(Map<String, dynamic> json) => _$ReturnOrderRequestModelFromJson(json);

@override final  String? reason;
 final  List<String>? _itemIds;
@override@JsonKey(name: 'item_ids') List<String>? get itemIds {
  final value = _itemIds;
  if (value == null) return null;
  if (_itemIds is EqualUnmodifiableListView) return _itemIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ReturnOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReturnOrderRequestModelCopyWith<_ReturnOrderRequestModel> get copyWith => __$ReturnOrderRequestModelCopyWithImpl<_ReturnOrderRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReturnOrderRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReturnOrderRequestModel&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other._itemIds, _itemIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reason,const DeepCollectionEquality().hash(_itemIds));

@override
String toString() {
  return 'ReturnOrderRequestModel(reason: $reason, itemIds: $itemIds)';
}


}

/// @nodoc
abstract mixin class _$ReturnOrderRequestModelCopyWith<$Res> implements $ReturnOrderRequestModelCopyWith<$Res> {
  factory _$ReturnOrderRequestModelCopyWith(_ReturnOrderRequestModel value, $Res Function(_ReturnOrderRequestModel) _then) = __$ReturnOrderRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String? reason,@JsonKey(name: 'item_ids') List<String>? itemIds
});




}
/// @nodoc
class __$ReturnOrderRequestModelCopyWithImpl<$Res>
    implements _$ReturnOrderRequestModelCopyWith<$Res> {
  __$ReturnOrderRequestModelCopyWithImpl(this._self, this._then);

  final _ReturnOrderRequestModel _self;
  final $Res Function(_ReturnOrderRequestModel) _then;

/// Create a copy of ReturnOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reason = freezed,Object? itemIds = freezed,}) {
  return _then(_ReturnOrderRequestModel(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,itemIds: freezed == itemIds ? _self._itemIds : itemIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
