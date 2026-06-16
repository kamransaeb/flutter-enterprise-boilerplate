// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_cart_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateCartItemRequestModel _$UpdateCartItemRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_UpdateCartItemRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['id', 'quantity']);
  final val = _UpdateCartItemRequestModel(
    id: $checkedConvert('id', (v) => v as String),
    quantity: $checkedConvert('quantity', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$UpdateCartItemRequestModelToJson(
  _UpdateCartItemRequestModel instance,
) => <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
