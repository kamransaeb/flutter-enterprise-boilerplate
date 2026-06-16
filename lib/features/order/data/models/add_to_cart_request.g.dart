// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AddToCartRequestModel _$AddToCartRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_AddToCartRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['product_id', 'variant_id', 'quantity'],
    );
    final val = _AddToCartRequestModel(
      productId: $checkedConvert('product_id', (v) => v as String),
      variantId: $checkedConvert('variant_id', (v) => v as String?),
      quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {'productId': 'product_id', 'variantId': 'variant_id'},
);

Map<String, dynamic> _$AddToCartRequestModelToJson(
  _AddToCartRequestModel instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'variant_id': instance.variantId,
  'quantity': instance.quantity,
};
