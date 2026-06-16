import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_request_model.freezed.dart';
part 'social_login_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class SocialLoginRequestModel with _$SocialLoginRequestModel {
  const factory SocialLoginRequestModel({
    required String provider, // google, facebook, apple
    required String token,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _SocialLoginRequestModel;

  factory SocialLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestModelFromJson(json);
}

