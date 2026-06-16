// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_coupon_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplyCouponRequestModel _$ApplyCouponRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ApplyCouponRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['coupon_code']);
  final val = _ApplyCouponRequestModel(
    couponCode: $checkedConvert('coupon_code', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'couponCode': 'coupon_code'});

Map<String, dynamic> _$ApplyCouponRequestModelToJson(
  _ApplyCouponRequestModel instance,
) => <String, dynamic>{'coupon_code': instance.couponCode};
