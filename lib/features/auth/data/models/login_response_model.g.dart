// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LoginResponseModel', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['userModel', 'authTokensModel']);
      final val = _LoginResponseModel(
        userModel: $checkedConvert(
          'userModel',
          (v) => UserModel.fromJson(v as Map<String, dynamic>),
        ),
        authTokensModel: $checkedConvert(
          'authTokensModel',
          (v) => AuthTokensModel.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$LoginResponseModelToJson(_LoginResponseModel instance) =>
    <String, dynamic>{
      'userModel': instance.userModel.toJson(),
      'authTokensModel': instance.authTokensModel.toJson(),
    };
