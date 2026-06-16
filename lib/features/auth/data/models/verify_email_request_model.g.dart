// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyEmailRequestModel _$VerifyEmailRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_VerifyEmailRequestModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['token', 'email']);
  final val = _VerifyEmailRequestModel(
    token: $checkedConvert('token', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$VerifyEmailRequestModelToJson(
  _VerifyEmailRequestModel instance,
) => <String, dynamic>{'token': instance.token, 'email': instance.email};
