// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginRequestModel _$SocialLoginRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SocialLoginRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['provider', 'token', 'device_id', 'fcm_token'],
    );
    final val = _SocialLoginRequestModel(
      provider: $checkedConvert('provider', (v) => v as String),
      token: $checkedConvert('token', (v) => v as String),
      deviceId: $checkedConvert('device_id', (v) => v as String?),
      fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'deviceId': 'device_id', 'fcmToken': 'fcm_token'},
);

Map<String, dynamic> _$SocialLoginRequestModelToJson(
  _SocialLoginRequestModel instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'token': instance.token,
  'device_id': instance.deviceId,
  'fcm_token': instance.fcmToken,
};
