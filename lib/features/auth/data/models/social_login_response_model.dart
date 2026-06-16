import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_response_model.freezed.dart';
part 'social_login_response_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class SocialLoginResponseModel with _$SocialLoginResponseModel {
  const factory SocialLoginResponseModel({
    required UserModel userModel,
    required AuthTokensModel authTokensModel,
    @JsonKey(name: 'is_new_user') @Default(false) bool isNewUser,
  }) = _SocialLoginResponseModel;

  factory SocialLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginResponseModelFromJson(json);
}