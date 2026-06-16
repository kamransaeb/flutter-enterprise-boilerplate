import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_request_model.freezed.dart';
part 'forget_password_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class ForgotPasswordRequestModel with _$ForgotPasswordRequestModel {
  const factory ForgotPasswordRequestModel({
    required String email,
  }) = _ForgotPasswordRequestModel;

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestModelFromJson(json);
}