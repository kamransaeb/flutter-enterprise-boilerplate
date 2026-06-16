import 'package:flutter_enterprise_boilerplate/features/auth/data/models/change_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/forget_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/resend_verification_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/reset_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/verify_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<LoginResponseModel>> login({
    required LoginRequestModel loginRequestModel,
  });

  Future<ApiResponse<RegisterResponseModel>> register({
    required RegisterRequestModel registerRequestModel,
  });

  Future<ApiResponse<void>> logout();

  Future<ApiResponse<void>> forgotPassword({
    required ForgotPasswordRequestModel forgotPasswordRequestModel,
  });

  Future<ApiResponse<void>> resetPassword({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  });

  Future<ApiResponse<void>> verifyEmail({
    required VerifyEmailRequestModel verifyEmailRequestModel,
  });

  Future<ApiResponse<void>> resendVerificationEmail({
    required ResendVerificationEmailRequestModel resendVerificationEmailRequestModel,
  });

  Future<ApiResponse<void>> changePassword({
    required String token,
    required ChangePasswordRequestModel changePasswordRequestModel,
  });

  Future<ApiResponse<SocialLoginResponseModel>> socialLogin({
    required SocialLoginRequestModel socialLoginRequestModel,
  });

  Future<ApiResponse<TokenRefreshResponseModel>> refreshToken({
    required TokenRefreshRequestModel refreshTokenRequestModel,
  });
}
