// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefundPaymentRequestModel _$RefundPaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RefundPaymentRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['amount', 'reason']);
  final val = _RefundPaymentRequestModel(
    amount: $checkedConvert('amount', (v) => (v as num?)?.toDouble()),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$RefundPaymentRequestModelToJson(
  _RefundPaymentRequestModel instance,
) => <String, dynamic>{'amount': instance.amount, 'reason': instance.reason};
