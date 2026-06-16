// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenRefreshRequestModel _$TokenRefreshRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TokenRefreshRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(json, allowedKeys: const ['refresh_token']);
    final val = _TokenRefreshRequestModel(
      refreshToken: $checkedConvert('refresh_token', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'refreshToken': 'refresh_token'},
);

Map<String, dynamic> _$TokenRefreshRequestModelToJson(
  _TokenRefreshRequestModel instance,
) => <String, dynamic>{'refresh_token': instance.refreshToken};
