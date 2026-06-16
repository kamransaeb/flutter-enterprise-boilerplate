// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ErrorResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['code', 'message', 'details', 'errors', 'debug_info'],
  );
  final val = ErrorResponse(
    code: $checkedConvert('code', (v) => v as String?),
    message: $checkedConvert('message', (v) => v as String?),
    details: $checkedConvert('details', (v) => v as Map<String, dynamic>?),
    errors: $checkedConvert(
      'errors',
      (v) => (v as List<dynamic>?)
          ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    debugInfo: $checkedConvert('debug_info', (v) => v as Map<String, dynamic>?),
  );
  return val;
}, fieldKeyMap: const {'debugInfo': 'debug_info'});

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'debug_info': instance.debugInfo,
    };

ValidationError _$ValidationErrorFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ValidationError', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['field', 'message', 'rejected_value', 'constraints'],
  );
  final val = ValidationError(
    field: $checkedConvert('field', (v) => v as String?),
    message: $checkedConvert('message', (v) => v as String?),
    rejectedValue: $checkedConvert('rejected_value', (v) => v),
    constraints: $checkedConvert(
      'constraints',
      (v) =>
          (v as Map<String, dynamic>?)?.map((k, e) => MapEntry(k, e as String)),
    ),
  );
  return val;
}, fieldKeyMap: const {'rejectedValue': 'rejected_value'});

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
      'rejected_value': instance.rejectedValue,
      'constraints': instance.constraints,
    };
