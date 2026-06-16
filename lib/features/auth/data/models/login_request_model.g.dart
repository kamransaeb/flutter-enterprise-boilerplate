// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_LoginRequestModel',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'email',
            'password',
            'device_id',
            'device_name',
            'fcm_token',
          ],
        );
        final val = _LoginRequestModel(
          email: $checkedConvert('email', (v) => v as String),
          password: $checkedConvert('password', (v) => v as String),
          deviceId: $checkedConvert('device_id', (v) => v as String?),
          deviceName: $checkedConvert('device_name', (v) => v as String?),
          fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'deviceId': 'device_id',
        'deviceName': 'device_name',
        'fcmToken': 'fcm_token',
      },
    );

Map<String, dynamic> _$LoginRequestModelToJson(_LoginRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'fcm_token': instance.fcmToken,
    };
