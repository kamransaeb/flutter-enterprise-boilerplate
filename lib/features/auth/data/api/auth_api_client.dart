import 'package:flutter_enterprise_boilerplate/features/auth/data/api/auth_endpoints.dart';
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
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@singleton
@RestApi()
abstract class AuthApiClient {

  @factoryMethod
  factory AuthApiClient(DioClient dioClient) {
    return _AuthApiClient(dioClient.dio);
  }


  // // ============================================================================
  // // Auth Endpoints
  // // ============================================================================
  // TYPE 1: Simple, predictable responses - Use strong types
  @POST(AuthEndpoints.login)
  @Extra({'requireAuth': false})
  Future<HttpResponse<LoginResponseModel>> login({
    @Body() required LoginRequestModel loginRequestModel,
  });

  @POST(AuthEndpoints.register)
  @Extra({'requireAuth': false})
  Future<HttpResponse<RegisterResponseModel>> register({
    @Body() required RegisterRequestModel registerRequestModel,
  });

  @POST(AuthEndpoints.logout)
  Future<HttpResponse<void>> logout(
    // @Header('Authorization') required String authorization,
  );

  @POST(AuthEndpoints.refreshToken)
  Future<HttpResponse<TokenRefreshResponseModel>> refreshToken({
    @Body() required TokenRefreshRequestModel refreshTokenRequestModel,
  });

  @POST(AuthEndpoints.forgotPassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> forgotPassword({
    @Body() required ForgotPasswordRequestModel forgotPasswordRequestModel,
  });

  @POST(AuthEndpoints.resetPassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> resetPassword({
    @Body() required ResetPasswordRequestModel resetPasswordRequestModel,
  });

  @POST(AuthEndpoints.verifyEmail)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> verifyEmail({
    @Body() required VerifyEmailRequestModel verifyEmailRequestModel,
  });

  @POST(AuthEndpoints.resendVerificationEmail)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> resendVerificationEmail({
    @Body()
    required ResendVerificationEmailRequestModel resendVerificationEmailRequestModel,
  });

  @POST(AuthEndpoints.changePassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> changePassword({
    @Body() required ChangePasswordRequestModel changePasswordRequestModel,
  });

  @POST(AuthEndpoints.socialLogin)
  @Extra({'requireAuth': false})
  Future<HttpResponse<SocialLoginResponseModel>> socialLogin({
    @Body() required SocialLoginRequestModel socialLoginRequestModel,
  });

}