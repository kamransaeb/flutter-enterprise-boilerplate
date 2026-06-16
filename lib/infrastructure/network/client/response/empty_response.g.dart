// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyResponse _$EmptyResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmptyResponse', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const ['success', 'code', 'timestamp', 'message'],
      );
      final val = EmptyResponse(
        success: $checkedConvert('success', (v) => v as bool? ?? true),
        message: $checkedConvert('message', (v) => v as String?),
        code: $checkedConvert('code', (v) => (v as num?)?.toInt()),
        timestamp: $checkedConvert(
          'timestamp',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EmptyResponseToJson(EmptyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'code': instance.code,
      'timestamp': instance.timestamp?.toIso8601String(),
      'message': instance.message,
    };
