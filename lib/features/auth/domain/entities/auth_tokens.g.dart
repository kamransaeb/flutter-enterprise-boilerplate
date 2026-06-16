// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokens _$AuthTokensFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AuthTokens', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const [
      'accessToken',
      'refreshToken',
      'expiresAt',
      'issuedAt',
      'tokenType',
    ],
  );
  final val = _AuthTokens(
    accessToken: $checkedConvert('accessToken', (v) => v as String),
    refreshToken: $checkedConvert('refreshToken', (v) => v as String),
    expiresAt: $checkedConvert('expiresAt', (v) => DateTime.parse(v as String)),
    issuedAt: $checkedConvert('issuedAt', (v) => DateTime.parse(v as String)),
    tokenType: $checkedConvert('tokenType', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'issuedAt': instance.issuedAt.toIso8601String(),
      'tokenType': instance.tokenType,
    };
