import 'package:flutter_enterprise_boilerplate/features/auth/data/datasources/auth_remote_data_source.dart';
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
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/api_client.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/response_converter.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

//*** Difference between Response and HttpResponse is
// Response (from Dio) is the raw HTTP result: status code, headers,
// request options, and raw/deserialized body in response.data.
// HttpResponse<T> (from Retrofit) is a wrapper around Dio Response plus a
// strongly typed parsed body T.
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final LoggerService _logger;
  final ApiClient _apiClient;
  AuthRemoteDataSourceImpl(this._apiClient, this._logger);

  @override
  Future<ApiResponse<LoginResponseModel>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final HttpResponse<LoginResponseModel> httpResponse = await _apiClient
          .login(loginRequestModel: loginRequestModel);

      // Simple conversion (if API returns data directly)
      final apiResponse = ResponseConverter.toApiResponse<LoginResponseModel>(
        httpResponse.response,
        (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
      );

      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to login',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<void>> changePassword({
    required String token,
    required ChangePasswordRequestModel changePasswordRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.changePassword(
        token: token,
        changePasswordRequestModel: changePasswordRequestModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to changePassword',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<void>> forgotPassword({
    required ForgotPasswordRequestModel forgotPasswordRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.forgotPassword(
        forgotPasswordRequestModel: forgotPasswordRequestModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to forgotPassword',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<void>> logout() async {
    try {
      final httpResponse = await _apiClient.logout(authorization: '');
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to logout',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<TokenRefreshResponseModel>> refreshToken({
    required TokenRefreshRequestModel refreshTokenRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.refreshToken(
        refreshTokenRequestModel: refreshTokenRequestModel,
      );
      final apiResponse =
          ResponseConverter.toApiResponse<TokenRefreshResponseModel>(
            httpResponse.response,
            (json) => TokenRefreshResponseModel.fromJson(
              json as Map<String, dynamic>,
            ),
          );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to refreshToken',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<RegisterResponseModel>> register({
    required RegisterRequestModel registerRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.register(
        registerRequestModel: registerRequestModel,
      );
      final apiResponse =
          ResponseConverter.toApiResponse<RegisterResponseModel>(
            httpResponse.response,
            (json) =>
                RegisterResponseModel.fromJson(json as Map<String, dynamic>),
          );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to register',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }


  @override
  Future<ApiResponse<void>> resetPassword({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.resetPassword(
        resetPasswordRequestModel: resetPasswordRequestModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to resetPassword',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<SocialLoginResponseModel>> socialLogin({
    required SocialLoginRequestModel socialLoginRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.socialLogin(
        socialLoginRequestModel: socialLoginRequestModel,
      );
      final apiResponse =
          ResponseConverter.toApiResponse<SocialLoginResponseModel>(
            httpResponse.response,
            (json) =>
                SocialLoginResponseModel.fromJson(json as Map<String, dynamic>),
          );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to socialLogin',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<void>> verifyEmail({
    required VerifyEmailRequestModel verifyEmailRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.verifyEmail(
        verifyEmailRequestModel: verifyEmailRequestModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to verifyEmail',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

    @override
  Future<ApiResponse<void>> resendVerificationEmail({
    required ResendVerificationEmailRequestModel resendVerificationEmailRequestModel,
  }) async {
    try {
      final httpResponse = await _apiClient.resendVerificationEmail(
        resendVerificationEmailRequestModel: resendVerificationEmailRequestModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        (_) {},
      );
      if (apiResponse.isSuccess) return apiResponse;
      final errorResponse = ResponseConverter.toErrorResponse(
        httpResponse.response,
      );
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: errorResponse,
      );
    } catch (e, stackTrace) {
      _logger.e(
        '[AuthRemoteDataSourceImpl] UnknownException: Failed to resendVerification',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }
}
