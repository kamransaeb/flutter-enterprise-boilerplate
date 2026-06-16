import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_verification_email_request_model.freezed.dart';
part 'resend_verification_email_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class ResendVerificationEmailRequestModel with _$ResendVerificationEmailRequestModel {
  const factory ResendVerificationEmailRequestModel({
    required String email,
  }) = _ResendVerificationEmailRequestModel;

  factory ResendVerificationEmailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResendVerificationEmailRequestModelFromJson(json);
}