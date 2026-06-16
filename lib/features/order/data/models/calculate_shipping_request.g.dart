// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_shipping_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalculateShippingRequestModel _$CalculateShippingRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CalculateShippingRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['address_id', 'shipping_address', 'line_items'],
    );
    final val = _CalculateShippingRequestModel(
      addressId: $checkedConvert('address_id', (v) => v as String?),
      shippingAddress: $checkedConvert(
        'shipping_address',
        (v) => v as Map<String, dynamic>?,
      ),
      lineItems: $checkedConvert(
        'line_items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'addressId': 'address_id',
    'shippingAddress': 'shipping_address',
    'lineItems': 'line_items',
  },
);

Map<String, dynamic> _$CalculateShippingRequestModelToJson(
  _CalculateShippingRequestModel instance,
) => <String, dynamic>{
  'address_id': instance.addressId,
  'shipping_address': instance.shippingAddress,
  'line_items': instance.lineItems,
};
