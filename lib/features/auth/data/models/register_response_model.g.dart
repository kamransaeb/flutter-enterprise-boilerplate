// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterResponseModel _$RegisterResponseModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RegisterResponseModel', json, ($checkedConvert) {
  $checkKeys(json, allowedKeys: const ['userModel', 'authTokensModel']);
  final val = _RegisterResponseModel(
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

Map<String, dynamic> _$RegisterResponseModelToJson(
  _RegisterResponseModel instance,
) => <String, dynamic>{
  'userModel': instance.userModel.toJson(),
  'authTokensModel': instance.authTokensModel.toJson(),
};
