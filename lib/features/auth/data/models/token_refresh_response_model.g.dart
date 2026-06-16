// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenRefreshResponseModel _$TokenRefreshResponseModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TokenRefreshResponseModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'access_token',
        'expires_at',
        'issued_at',
        'refresh_token',
      ],
    );
    final val = _TokenRefreshResponseModel(
      accessToken: $checkedConvert('access_token', (v) => v as String),
      expiresAt: $checkedConvert(
        'expires_at',
        (v) => DateTime.parse(v as String),
      ),
      issuedAt: $checkedConvert(
        'issued_at',
        (v) => DateTime.parse(v as String),
      ),
      refreshToken: $checkedConvert('refresh_token', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'accessToken': 'access_token',
    'expiresAt': 'expires_at',
    'issuedAt': 'issued_at',
    'refreshToken': 'refresh_token',
  },
);

Map<String, dynamic> _$TokenRefreshResponseModelToJson(
  _TokenRefreshResponseModel instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'expires_at': instance.expiresAt.toIso8601String(),
  'issued_at': instance.issuedAt.toIso8601String(),
  'refresh_token': instance.refreshToken,
};
