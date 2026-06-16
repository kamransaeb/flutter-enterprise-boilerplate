// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InitiatePaymentRequestModel _$InitiatePaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_InitiatePaymentRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'order_id',
        'payment_method_id',
        'return_url',
        'cancel_url',
      ],
    );
    final val = _InitiatePaymentRequestModel(
      orderId: $checkedConvert('order_id', (v) => v as String),
      paymentMethodId: $checkedConvert('payment_method_id', (v) => v as String),
      returnUrl: $checkedConvert('return_url', (v) => v as String?),
      cancelUrl: $checkedConvert('cancel_url', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'orderId': 'order_id',
    'paymentMethodId': 'payment_method_id',
    'returnUrl': 'return_url',
    'cancelUrl': 'cancel_url',
  },
);

Map<String, dynamic> _$InitiatePaymentRequestModelToJson(
  _InitiatePaymentRequestModel instance,
) => <String, dynamic>{
  'order_id': instance.orderId,
  'payment_method_id': instance.paymentMethodId,
  'return_url': instance.returnUrl,
  'cancel_url': instance.cancelUrl,
};
