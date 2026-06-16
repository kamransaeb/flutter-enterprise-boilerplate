// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequestModel _$UpdateProfileRequestModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_UpdateProfileRequestModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'first_name',
        'last_name',
        'phone_number',
        'avatar_url',
      ],
    );
    final val = _UpdateProfileRequestModel(
      firstName: $checkedConvert('first_name', (v) => v as String?),
      lastName: $checkedConvert('last_name', (v) => v as String?),
      phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
      avatarUrl: $checkedConvert('avatar_url', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'firstName': 'first_name',
    'lastName': 'last_name',
    'phoneNumber': 'phone_number',
    'avatarUrl': 'avatar_url',
  },
);

Map<String, dynamic> _$UpdateProfileRequestModelToJson(
  _UpdateProfileRequestModel instance,
) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone_number': instance.phoneNumber,
  'avatar_url': instance.avatarUrl,
};
