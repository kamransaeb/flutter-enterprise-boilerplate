import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_model.freezed.dart';
part 'register_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    required String email,
    required String password,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'fcm_token') String? fcmToken,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
}