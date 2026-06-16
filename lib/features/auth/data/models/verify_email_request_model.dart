import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_request_model.freezed.dart';
part 'verify_email_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class VerifyEmailRequestModel with _$VerifyEmailRequestModel {
  const factory VerifyEmailRequestModel({
    required String token,
    required String email,
  }) = _VerifyEmailRequestModel;

  factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestModelFromJson(json);
}