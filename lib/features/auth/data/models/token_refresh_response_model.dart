import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_refresh_response_model.freezed.dart';
part 'token_refresh_response_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class TokenRefreshResponseModel with _$TokenRefreshResponseModel {
  const factory TokenRefreshResponseModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    @JsonKey(name: 'issued_at') required DateTime issuedAt,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _TokenRefreshResponseModel;

  factory TokenRefreshResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseModelFromJson(json);
}