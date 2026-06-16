import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response_model.freezed.dart';
part 'register_response_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class RegisterResponseModel with _$RegisterResponseModel {
  const factory RegisterResponseModel({
    required UserModel userModel,
    required AuthTokensModel authTokensModel,
  }) = _RegisterResponseModel;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);
}