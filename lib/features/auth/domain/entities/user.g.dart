// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_User',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'id',
        'email',
        'first_name',
        'last_name',
        'avatar_url',
        'phone_number',
        'email_verified',
        'phone_verified',
        'roles',
        'created_at',
        'updated_at',
        'logged_in_at',
        'is_profile_completed',
        'is_active',
      ],
    );
    final val = _User(
      id: $checkedConvert('id', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String),
      firstName: $checkedConvert('first_name', (v) => v as String?),
      lastName: $checkedConvert('last_name', (v) => v as String?),
      avatarUrl: $checkedConvert('avatar_url', (v) => v as String?),
      phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
      emailVerified: $checkedConvert(
        'email_verified',
        (v) => v as bool? ?? false,
      ),
      phoneVerified: $checkedConvert(
        'phone_verified',
        (v) => v as bool? ?? false,
      ),
      roles: $checkedConvert(
        'roles',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      createdAt: $checkedConvert(
        'created_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      loggedInAt: $checkedConvert(
        'logged_in_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      isProfileCompleted: $checkedConvert(
        'is_profile_completed',
        (v) => v as bool? ?? false,
      ),
      isActive: $checkedConvert('is_active', (v) => v as bool? ?? true),
    );
    return val;
  },
  fieldKeyMap: const {
    'firstName': 'first_name',
    'lastName': 'last_name',
    'avatarUrl': 'avatar_url',
    'phoneNumber': 'phone_number',
    'emailVerified': 'email_verified',
    'phoneVerified': 'phone_verified',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'loggedInAt': 'logged_in_at',
    'isProfileCompleted': 'is_profile_completed',
    'isActive': 'is_active',
  },
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'avatar_url': instance.avatarUrl,
  'phone_number': instance.phoneNumber,
  'email_verified': instance.emailVerified,
  'phone_verified': instance.phoneVerified,
  'roles': instance.roles,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'logged_in_at': instance.loggedInAt?.toIso8601String(),
  'is_profile_completed': instance.isProfileCompleted,
  'is_active': instance.isActive,
};
