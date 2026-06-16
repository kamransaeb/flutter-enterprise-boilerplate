// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginResponseModel _$SocialLoginResponseModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SocialLoginResponseModel', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['userModel', 'authTokensModel', 'is_new_user'],
  );
  final val = _SocialLoginResponseModel(
    userModel: $checkedConvert(
      'userModel',
      (v) => UserModel.fromJson(v as Map<String, dynamic>),
    ),
    authTokensModel: $checkedConvert(
      'authTokensModel',
      (v) => AuthTokensModel.fromJson(v as Map<String, dynamic>),
    ),
    isNewUser: $checkedConvert('is_new_user', (v) => v as bool? ?? false),
  );
  return val;
}, fieldKeyMap: const {'isNewUser': 'is_new_user'});

Map<String, dynamic> _$SocialLoginResponseModelToJson(
  _SocialLoginResponseModel instance,
) => <String, dynamic>{
  'userModel': instance.userModel.toJson(),
  'authTokensModel': instance.authTokensModel.toJson(),
  'is_new_user': instance.isNewUser,
};
