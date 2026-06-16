// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequestModel _$RegisterRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RegisterRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'email',
        'password',
        'first_name',
        'last_name',
        'phone_number',
        'device_id',
        'fcm_token',
      ],
    );
    final val = _RegisterRequestModel(
      email: $checkedConvert('email', (v) => v as String),
      password: $checkedConvert('password', (v) => v as String),
      firstName: $checkedConvert('first_name', (v) => v as String),
      lastName: $checkedConvert('last_name', (v) => v as String),
      phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
      deviceId: $checkedConvert('device_id', (v) => v as String?),
      fcmToken: $checkedConvert('fcm_token', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'firstName': 'first_name',
    'lastName': 'last_name',
    'phoneNumber': 'phone_number',
    'deviceId': 'device_id',
    'fcmToken': 'fcm_token',
  },
);

Map<String, dynamic> _$RegisterRequestModelToJson(
  _RegisterRequestModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'device_id': instance.deviceId,
  'fcm_token': instance.fcmToken,
};
