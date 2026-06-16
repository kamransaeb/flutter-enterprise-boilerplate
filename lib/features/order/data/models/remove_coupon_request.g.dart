// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_coupon_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoveCouponRequestModel _$RemoveCouponRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RemoveCouponRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['coupon_code']);
  final val = _RemoveCouponRequestModel(
    couponCode: $checkedConvert('coupon_code', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'couponCode': 'coupon_code'});

Map<String, dynamic> _$RemoveCouponRequestModelToJson(
  _RemoveCouponRequestModel instance,
) => <String, dynamic>{'coupon_code': instance.couponCode};
