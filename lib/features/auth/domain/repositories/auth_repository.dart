import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';

import '../../../../core/errors/failures.dart';

/// Abstract repository interface following clean architecture
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  
  /// Register new user
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  /// Logout user
  Future<Either<Failure, void>> logout();
  /// Forgot password
  Future<Either<Failure, void>> forgotPassword(String email);
  /// Reset password
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });
  
  /// Refresh token
  Future<Either<Failure, String>> refreshToken();
  
  /// Get current user
  Future<Either<Failure, User?>> getCurrentUser();
  
  /// Get user stream
  Stream<User?> get userStream;

   /// Check if user is authenticated
  Future<bool> isAuthenticated();
  
  // Social login (optional)
  Future<Either<Failure, User>> loginWithGoogle();
  Future<Either<Failure, User>> loginWithApple();
  Future<Either<Failure, User>> loginInWithFacebook();

  /// Send email verification
  Future<Either<Failure, void>> verifyEmail(String email, String token);

  /// Resend verification email
  Future<Either<Failure, void>> resendVerificationEmail(String email);
}


