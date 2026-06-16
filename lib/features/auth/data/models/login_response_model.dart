import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required UserModel userModel,
    required AuthTokensModel authTokensModel,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

}
