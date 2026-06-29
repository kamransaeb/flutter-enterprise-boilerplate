import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/forget_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/resend_verification_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/reset_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/verify_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/response_converter.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final ApiResponse<LoginResponseModel> apiResponse =
          await _authRemoteDataSource.login(
            loginRequestModel: LoginRequestModel(
              email: email,
              password: password,
            ),
          );

      if (apiResponse.isSuccess && apiResponse.hasData) {
        final AuthTokensModel authTokensModel =
            apiResponse.data!.authTokensModel;
        final UserModel userModel = apiResponse.data!.userModel;
        final cachedTokens = await _authLocalDataSource.cacheTokens(
          authTokensModel,
        );
        return cachedTokens.fold(Left.new, (_) async {
          final cachedUser = await _authLocalDataSource.cacheUser(userModel);
          return cachedUser.fold(Left.new, (_) => Right(userModel.toEntity()));
        });
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final ApiResponse<RegisterResponseModel> apiResponse =
          await _authRemoteDataSource.register(
            registerRequestModel: RegisterRequestModel(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName,
            ),
          );

      if (apiResponse.isSuccess && apiResponse.hasData) {
        final UserModel userModel = apiResponse.data!.userModel;
        final cachedUser = await _authLocalDataSource.cacheUser(userModel);
        return cachedUser.fold(Left.new, (_) => Right(userModel.toEntity()));
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final apiResponse = await _authRemoteDataSource.logout();
      if (apiResponse.isSuccess && apiResponse.hasData) {
        final cachedUser = await _authLocalDataSource.clearCachedUser();
        return cachedUser.fold(Left.new, (_) async {
          final cachedTokens = await _authLocalDataSource.clearCachedTokens();
          return cachedTokens.fold(Left.new, (_) => const Right(null));
        });
      }
      return Left(
        ServerFailure(
          message: apiResponse.errorMessage,
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final cachedUser = await _authLocalDataSource.getCachedUser();
      return cachedUser.fold(
        Left.new,
        // replaced with tear-off syntax
        // (failure) => Left(failure),
        (userModel) => Right(userModel?.toEntity()),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Stream<User?> get userStream => _authLocalDataSource.userStream;

  @override
  Future<bool> isAuthenticated() async {
    final result = await _authLocalDataSource.isSessionActive();
    return result.fold((_) => false, (isActive) => isActive);
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      final apiResponse = await _authRemoteDataSource.forgotPassword(
        forgotPasswordRequestModel: ForgotPasswordRequestModel(email: email),
      );
      if (apiResponse.isSuccess) {
        return const Right(null);
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final apiResponse = await _authRemoteDataSource.resetPassword(
        resetPasswordRequestModel: ResetPasswordRequestModel(
          token: token,
          password: newPassword,
          confirmPassword: newPassword,
        ),
      );
      if (apiResponse.isSuccess) {
        return const Right(null);
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, String>> refreshToken() async {
    try {
      final cachedTokens = await _authLocalDataSource.getCachedTokens();
      return await cachedTokens.fold((failure) async => Left(failure), (
        tokens,
      ) async {
        if (tokens == null) {
          return const Left(
            UnauthorizedAccessFailure(message: 'No refresh token available'),
          );
        }
        final apiResponse = await _authRemoteDataSource.refreshToken(
          refreshTokenRequestModel: TokenRefreshRequestModel(
            refreshToken: tokens.refreshToken,
          ),
        );
        if (apiResponse.isSuccess && apiResponse.hasData) {
          final refreshed = AuthTokensModel(
            accessToken: apiResponse.data!.accessToken,
            refreshToken: apiResponse.data!.refreshToken,
            issuedAt: apiResponse.data!.issuedAt,
            expiresAt: apiResponse.data!.expiresAt,
            tokenType: tokens.tokenType,
          );
          final cached = await _authLocalDataSource.cacheTokens(refreshed);
          return cached.fold(
            (failure) => Left(failure),
            (_) => Right(refreshed.accessToken),
          );
        }
        return Left(
          ServerFailure(
            code: apiResponse.error?.code,
            message: apiResponse.error?.message ?? 'An unknown error occurred',
            statusCode: apiResponse.statusCode,
          ),
        );
      });
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() async {
    return const Left(
      OperationNotAllowedFailure(
        operation: 'loginWithGoogle',
        reason: 'Not implemented yet',
      ),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithApple() async {
    return const Left(
      OperationNotAllowedFailure(
        operation: 'loginWithApple',
        reason: 'Not implemented yet',
      ),
    );
  }

  @override
  Future<Either<Failure, User>> loginInWithFacebook() async {
    // _logger.i('AuthRepository: Facebook sign in attempt');
    // final userModel = await remoteDataSource.signInWithFacebook();
    // await localDataSource.cacheUser(userModel);
    // _logger.i('AuthRepository: Facebook sign in successful');
    return const Left(
      OperationNotAllowedFailure(
        operation: 'loginInWithFacebook',
        reason: 'Not implemented yet',
      ),
    );
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String email, String token) async {
    try {
        final apiResponse = await _authRemoteDataSource.verifyEmail(
          verifyEmailRequestModel: VerifyEmailRequestModel(
            token: token,
            email: email,
          ),
        );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        return const Right(null);
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
      
       
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> resendVerificationEmail(String email) async {
    return const Left(
      OperationNotAllowedFailure(
        operation: 'resendVerificationEmail',
        reason: 'Not implemented yet',
      ),
    );
  }
}
