// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReturnOrderRequestModel _$ReturnOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ReturnOrderRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['reason', 'item_ids']);
  final val = _ReturnOrderRequestModel(
    reason: $checkedConvert('reason', (v) => v as String?),
    itemIds: $checkedConvert(
      'item_ids',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'itemIds': 'item_ids'});

Map<String, dynamic> _$ReturnOrderRequestModelToJson(
  _ReturnOrderRequestModel instance,
) => <String, dynamic>{'reason': instance.reason, 'item_ids': instance.itemIds};
