// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_verification_email_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResendVerificationEmailRequestModel
_$ResendVerificationEmailRequestModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ResendVerificationEmailRequestModel', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, allowedKeys: const ['email']);
      final val = _ResendVerificationEmailRequestModel(
        email: $checkedConvert('email', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ResendVerificationEmailRequestModelToJson(
  _ResendVerificationEmailRequestModel instance,
) => <String, dynamic>{'email': instance.email};
