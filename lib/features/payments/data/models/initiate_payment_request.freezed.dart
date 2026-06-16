// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initiate_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InitiatePaymentRequestModel {

@JsonKey(name: 'order_id') String get orderId;@JsonKey(name: 'payment_method_id') String get paymentMethodId;@JsonKey(name: 'return_url') String? get returnUrl;@JsonKey(name: 'cancel_url') String? get cancelUrl;
/// Create a copy of InitiatePaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitiatePaymentRequestModelCopyWith<InitiatePaymentRequestModel> get copyWith => _$InitiatePaymentRequestModelCopyWithImpl<InitiatePaymentRequestModel>(this as InitiatePaymentRequestModel, _$identity);

  /// Serializes this InitiatePaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitiatePaymentRequestModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,paymentMethodId,returnUrl,cancelUrl);

@override
String toString() {
  return 'InitiatePaymentRequestModel(orderId: $orderId, paymentMethodId: $paymentMethodId, returnUrl: $returnUrl, cancelUrl: $cancelUrl)';
}


}

/// @nodoc
abstract mixin class $InitiatePaymentRequestModelCopyWith<$Res>  {
  factory $InitiatePaymentRequestModelCopyWith(InitiatePaymentRequestModel value, $Res Function(InitiatePaymentRequestModel) _then) = _$InitiatePaymentRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'order_id') String orderId,@JsonKey(name: 'payment_method_id') String paymentMethodId,@JsonKey(name: 'return_url') String? returnUrl,@JsonKey(name: 'cancel_url') String? cancelUrl
});




}
/// @nodoc
class _$InitiatePaymentRequestModelCopyWithImpl<$Res>
    implements $InitiatePaymentRequestModelCopyWith<$Res> {
  _$InitiatePaymentRequestModelCopyWithImpl(this._self, this._then);

  final InitiatePaymentRequestModel _self;
  final $Res Function(InitiatePaymentRequestModel) _then;

/// Create a copy of InitiatePaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? paymentMethodId = null,Object? returnUrl = freezed,Object? cancelUrl = freezed,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,paymentMethodId: null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InitiatePaymentRequestModel].
extension InitiatePaymentRequestModelPatterns on InitiatePaymentRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'payment_method_id')  String paymentMethodId, @JsonKey(name: 'return_url')  String? returnUrl, @JsonKey(name: 'cancel_url')  String? cancelUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiatePaymentRequestModel() when $default != null:
return $default(_that.orderId,_that.paymentMethodId,_that.returnUrl,_that.cancelUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'payment_method_id')  String paymentMethodId, @JsonKey(name: 'return_url')  String? returnUrl, @JsonKey(name: 'cancel_url')  String? cancelUrl)  $default,) {final _that = this;
switch (_that) {
case _InitiatePaymentRequestModel():
return $default(_that.orderId,_that.paymentMethodId,_that.returnUrl,_that.cancelUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'order_id')  String orderId, @JsonKey(name: 'payment_method_id')  String paymentMethodId, @JsonKey(name: 'return_url')  String? returnUrl, @JsonKey(name: 'cancel_url')  String? cancelUrl)?  $default,) {final _that = this;
switch (_that) {
case _InitiatePaymentRequestModel() when $default != null:
return $default(_that.orderId,_that.paymentMethodId,_that.returnUrl,_that.cancelUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitiatePaymentRequestModel implements InitiatePaymentRequestModel {
  const _InitiatePaymentRequestModel({@JsonKey(name: 'order_id') required this.orderId, @JsonKey(name: 'payment_method_id') required this.paymentMethodId, @JsonKey(name: 'return_url') this.returnUrl, @JsonKey(name: 'cancel_url') this.cancelUrl});
  factory _InitiatePaymentRequestModel.fromJson(Map<String, dynamic> json) => _$InitiatePaymentRequestModelFromJson(json);

@override@JsonKey(name: 'order_id') final  String orderId;
@override@JsonKey(name: 'payment_method_id') final  String paymentMethodId;
@override@JsonKey(name: 'return_url') final  String? returnUrl;
@override@JsonKey(name: 'cancel_url') final  String? cancelUrl;

/// Create a copy of InitiatePaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiatePaymentRequestModelCopyWith<_InitiatePaymentRequestModel> get copyWith => __$InitiatePaymentRequestModelCopyWithImpl<_InitiatePaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitiatePaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiatePaymentRequestModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.paymentMethodId, paymentMethodId) || other.paymentMethodId == paymentMethodId)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,paymentMethodId,returnUrl,cancelUrl);

@override
String toString() {
  return 'InitiatePaymentRequestModel(orderId: $orderId, paymentMethodId: $paymentMethodId, returnUrl: $returnUrl, cancelUrl: $cancelUrl)';
}


}

/// @nodoc
abstract mixin class _$InitiatePaymentRequestModelCopyWith<$Res> implements $InitiatePaymentRequestModelCopyWith<$Res> {
  factory _$InitiatePaymentRequestModelCopyWith(_InitiatePaymentRequestModel value, $Res Function(_InitiatePaymentRequestModel) _then) = __$InitiatePaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'order_id') String orderId,@JsonKey(name: 'payment_method_id') String paymentMethodId,@JsonKey(name: 'return_url') String? returnUrl,@JsonKey(name: 'cancel_url') String? cancelUrl
});




}
/// @nodoc
class __$InitiatePaymentRequestModelCopyWithImpl<$Res>
    implements _$InitiatePaymentRequestModelCopyWith<$Res> {
  __$InitiatePaymentRequestModelCopyWithImpl(this._self, this._then);

  final _InitiatePaymentRequestModel _self;
  final $Res Function(_InitiatePaymentRequestModel) _then;

/// Create a copy of InitiatePaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? paymentMethodId = null,Object? returnUrl = freezed,Object? cancelUrl = freezed,}) {
  return _then(_InitiatePaymentRequestModel(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,paymentMethodId: null == paymentMethodId ? _self.paymentMethodId : paymentMethodId // ignore: cast_nullable_to_non_nullable
as String,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
