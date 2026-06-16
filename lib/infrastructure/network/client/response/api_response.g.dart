// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('ApiResponse', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'status',
      'message',
      'data',
      'status_code',
      'timestamp',
      'path',
      'error',
    ],
  );
  final val = ApiResponse<T>(
    status: $checkedConvert('status', (v) => v as String?),
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => _$nullableGenericFromJson(v, fromJsonT),
    ),
    statusCode: $checkedConvert('status_code', (v) => (v as num?)?.toInt()),
    timestamp: $checkedConvert(
      'timestamp',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    path: $checkedConvert('path', (v) => v as String?),
    error: $checkedConvert(
      'error',
      (v) =>
          v == null ? null : ErrorResponse.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'statusCode': 'status_code'});

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'status_code': instance.statusCode,
  'timestamp': instance.timestamp?.toIso8601String(),
  'path': instance.path,
  'error': instance.error?.toJson(),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
