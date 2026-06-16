// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyPaymentRequestModel _$VerifyPaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_VerifyPaymentRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['payment_id', 'transaction_id', 'client_secret'],
    );
    final val = _VerifyPaymentRequestModel(
      paymentId: $checkedConvert('payment_id', (v) => v as String?),
      transactionId: $checkedConvert('transaction_id', (v) => v as String?),
      clientSecret: $checkedConvert('client_secret', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'paymentId': 'payment_id',
    'transactionId': 'transaction_id',
    'clientSecret': 'client_secret',
  },
);

Map<String, dynamic> _$VerifyPaymentRequestModelToJson(
  _VerifyPaymentRequestModel instance,
) => <String, dynamic>{
  'payment_id': instance.paymentId,
  'transaction_id': instance.transactionId,
  'client_secret': instance.clientSecret,
};
