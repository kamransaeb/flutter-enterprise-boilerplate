// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateOrderRequestModel _$CreateOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CreateOrderRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'shipping_address_id',
        'billing_address_id',
        'payment_method_id',
        'notes',
        'coupon_code',
        'line_items',
      ],
    );
    final val = _CreateOrderRequestModel(
      shippingAddressId: $checkedConvert(
        'shipping_address_id',
        (v) => v as String?,
      ),
      billingAddressId: $checkedConvert(
        'billing_address_id',
        (v) => v as String?,
      ),
      paymentMethodId: $checkedConvert(
        'payment_method_id',
        (v) => v as String?,
      ),
      notes: $checkedConvert('notes', (v) => v as String?),
      couponCode: $checkedConvert('coupon_code', (v) => v as String?),
      lineItems: $checkedConvert(
        'line_items',
        (v) =>
            (v as List<dynamic>).map((e) => e as Map<String, dynamic>).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'shippingAddressId': 'shipping_address_id',
    'billingAddressId': 'billing_address_id',
    'paymentMethodId': 'payment_method_id',
    'couponCode': 'coupon_code',
    'lineItems': 'line_items',
  },
);

Map<String, dynamic> _$CreateOrderRequestModelToJson(
  _CreateOrderRequestModel instance,
) => <String, dynamic>{
  'shipping_address_id': instance.shippingAddressId,
  'billing_address_id': instance.billingAddressId,
  'payment_method_id': instance.paymentMethodId,
  'notes': instance.notes,
  'coupon_code': instance.couponCode,
  'line_items': instance.lineItems,
};
