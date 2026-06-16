import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_request_model.freezed.dart';
part 'token_refresh_request_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class TokenRefreshRequestModel with _$TokenRefreshRequestModel {
  const factory TokenRefreshRequestModel({
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _TokenRefreshRequestModel;

  factory TokenRefreshRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestModelFromJson(json);
}

