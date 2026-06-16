// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyPaymentRequestModel {

@JsonKey(name: 'payment_id') String? get paymentId;@JsonKey(name: 'transaction_id') String? get transactionId;@JsonKey(name: 'client_secret') String? get clientSecret;
/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentRequestModelCopyWith<VerifyPaymentRequestModel> get copyWith => _$VerifyPaymentRequestModelCopyWithImpl<VerifyPaymentRequestModel>(this as VerifyPaymentRequestModel, _$identity);

  /// Serializes this VerifyPaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentRequestModel&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionId,clientSecret);

@override
String toString() {
  return 'VerifyPaymentRequestModel(paymentId: $paymentId, transactionId: $transactionId, clientSecret: $clientSecret)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentRequestModelCopyWith<$Res>  {
  factory $VerifyPaymentRequestModelCopyWith(VerifyPaymentRequestModel value, $Res Function(VerifyPaymentRequestModel) _then) = _$VerifyPaymentRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'payment_id') String? paymentId,@JsonKey(name: 'transaction_id') String? transactionId,@JsonKey(name: 'client_secret') String? clientSecret
});




}
/// @nodoc
class _$VerifyPaymentRequestModelCopyWithImpl<$Res>
    implements $VerifyPaymentRequestModelCopyWith<$Res> {
  _$VerifyPaymentRequestModelCopyWithImpl(this._self, this._then);

  final VerifyPaymentRequestModel _self;
  final $Res Function(VerifyPaymentRequestModel) _then;

/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = freezed,Object? transactionId = freezed,Object? clientSecret = freezed,}) {
  return _then(_self.copyWith(
paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPaymentRequestModel].
extension VerifyPaymentRequestModelPatterns on VerifyPaymentRequestModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'payment_id')  String? paymentId, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'client_secret')  String? clientSecret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
return $default(_that.paymentId,_that.transactionId,_that.clientSecret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'payment_id')  String? paymentId, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'client_secret')  String? clientSecret)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel():
return $default(_that.paymentId,_that.transactionId,_that.clientSecret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'payment_id')  String? paymentId, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'client_secret')  String? clientSecret)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
return $default(_that.paymentId,_that.transactionId,_that.clientSecret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentRequestModel implements VerifyPaymentRequestModel {
  const _VerifyPaymentRequestModel({@JsonKey(name: 'payment_id') this.paymentId, @JsonKey(name: 'transaction_id') this.transactionId, @JsonKey(name: 'client_secret') this.clientSecret});
  factory _VerifyPaymentRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyPaymentRequestModelFromJson(json);

@override@JsonKey(name: 'payment_id') final  String? paymentId;
@override@JsonKey(name: 'transaction_id') final  String? transactionId;
@override@JsonKey(name: 'client_secret') final  String? clientSecret;

/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentRequestModelCopyWith<_VerifyPaymentRequestModel> get copyWith => __$VerifyPaymentRequestModelCopyWithImpl<_VerifyPaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentRequestModel&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionId,clientSecret);

@override
String toString() {
  return 'VerifyPaymentRequestModel(paymentId: $paymentId, transactionId: $transactionId, clientSecret: $clientSecret)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentRequestModelCopyWith<$Res> implements $VerifyPaymentRequestModelCopyWith<$Res> {
  factory _$VerifyPaymentRequestModelCopyWith(_VerifyPaymentRequestModel value, $Res Function(_VerifyPaymentRequestModel) _then) = __$VerifyPaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'payment_id') String? paymentId,@JsonKey(name: 'transaction_id') String? transactionId,@JsonKey(name: 'client_secret') String? clientSecret
});




}
/// @nodoc
class __$VerifyPaymentRequestModelCopyWithImpl<$Res>
    implements _$VerifyPaymentRequestModelCopyWith<$Res> {
  __$VerifyPaymentRequestModelCopyWithImpl(this._self, this._then);

  final _VerifyPaymentRequestModel _self;
  final $Res Function(_VerifyPaymentRequestModel) _then;

/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = freezed,Object? transactionId = freezed,Object? clientSecret = freezed,}) {
  return _then(_VerifyPaymentRequestModel(
paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
