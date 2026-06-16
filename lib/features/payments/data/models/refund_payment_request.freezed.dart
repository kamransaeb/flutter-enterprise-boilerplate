// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RefundPaymentRequestModel {

 double? get amount; String? get reason;
/// Create a copy of RefundPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundPaymentRequestModelCopyWith<RefundPaymentRequestModel> get copyWith => _$RefundPaymentRequestModelCopyWithImpl<RefundPaymentRequestModel>(this as RefundPaymentRequestModel, _$identity);

  /// Serializes this RefundPaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundPaymentRequestModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,reason);

@override
String toString() {
  return 'RefundPaymentRequestModel(amount: $amount, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $RefundPaymentRequestModelCopyWith<$Res>  {
  factory $RefundPaymentRequestModelCopyWith(RefundPaymentRequestModel value, $Res Function(RefundPaymentRequestModel) _then) = _$RefundPaymentRequestModelCopyWithImpl;
@useResult
$Res call({
 double? amount, String? reason
});




}
/// @nodoc
class _$RefundPaymentRequestModelCopyWithImpl<$Res>
    implements $RefundPaymentRequestModelCopyWith<$Res> {
  _$RefundPaymentRequestModelCopyWithImpl(this._self, this._then);

  final RefundPaymentRequestModel _self;
  final $Res Function(RefundPaymentRequestModel) _then;

/// Create a copy of RefundPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = freezed,Object? reason = freezed,}) {
  return _then(_self.copyWith(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RefundPaymentRequestModel].
extension RefundPaymentRequestModelPatterns on RefundPaymentRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? amount,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefundPaymentRequestModel() when $default != null:
return $default(_that.amount,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? amount,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _RefundPaymentRequestModel():
return $default(_that.amount,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? amount,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _RefundPaymentRequestModel() when $default != null:
return $default(_that.amount,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefundPaymentRequestModel implements RefundPaymentRequestModel {
  const _RefundPaymentRequestModel({this.amount, this.reason});
  factory _RefundPaymentRequestModel.fromJson(Map<String, dynamic> json) => _$RefundPaymentRequestModelFromJson(json);

@override final  double? amount;
@override final  String? reason;

/// Create a copy of RefundPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundPaymentRequestModelCopyWith<_RefundPaymentRequestModel> get copyWith => __$RefundPaymentRequestModelCopyWithImpl<_RefundPaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefundPaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundPaymentRequestModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,reason);

@override
String toString() {
  return 'RefundPaymentRequestModel(amount: $amount, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$RefundPaymentRequestModelCopyWith<$Res> implements $RefundPaymentRequestModelCopyWith<$Res> {
  factory _$RefundPaymentRequestModelCopyWith(_RefundPaymentRequestModel value, $Res Function(_RefundPaymentRequestModel) _then) = __$RefundPaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
 double? amount, String? reason
});




}
/// @nodoc
class __$RefundPaymentRequestModelCopyWithImpl<$Res>
    implements _$RefundPaymentRequestModelCopyWith<$Res> {
  __$RefundPaymentRequestModelCopyWithImpl(this._self, this._then);

  final _RefundPaymentRequestModel _self;
  final $Res Function(_RefundPaymentRequestModel) _then;

/// Create a copy of RefundPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = freezed,Object? reason = freezed,}) {
  return _then(_RefundPaymentRequestModel(
amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
