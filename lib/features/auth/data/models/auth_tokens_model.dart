import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/auth_tokens.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_model.freezed.dart';
part 'auth_tokens_model.g.dart';

// With freezed 3 the public class must be abstract.
@freezed
abstract class AuthTokensModel with _$AuthTokensModel {
  const AuthTokensModel._();
  const factory AuthTokensModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'issued_at') required DateTime issuedAt,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    @JsonKey(name: 'token_type') required String tokenType,
  }) = _AuthTokensModel;

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

}

extension AuthTokensModelExtension on AuthTokensModel {
  AuthTokens toEntity() {
    return AuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
      issuedAt: issuedAt,
      tokenType: tokenType,
    );
  }
}