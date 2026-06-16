// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResetPasswordRequestModel _$ResetPasswordRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ResetPasswordRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const ['token', 'password', 'confirm_password'],
    );
    final val = _ResetPasswordRequestModel(
      token: $checkedConvert('token', (v) => v as String),
      password: $checkedConvert('password', (v) => v as String),
      confirmPassword: $checkedConvert('confirm_password', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'confirmPassword': 'confirm_password'},
);

Map<String, dynamic> _$ResetPasswordRequestModelToJson(
  _ResetPasswordRequestModel instance,
) => <String, dynamic>{
  'token': instance.token,
  'password': instance.password,
  'confirm_password': instance.confirmPassword,
};
