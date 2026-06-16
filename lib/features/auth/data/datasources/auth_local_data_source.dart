import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/exceptions/cache_exceptions.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  // User
  Future<Either<Failure, void>> cacheUser(UserModel userModel);
  Future<Either<Failure, UserModel?>> getCachedUser();
  Future<Either<Failure, void>> clearCachedUser();

  // Tokens
  Future<Either<Failure, void>> cacheTokens(AuthTokensModel authTokensModel);
  Future<Either<Failure, AuthTokensModel?>> getCachedTokens();
  Future<Either<Failure, void>> clearCachedTokens();

  // Session data
  Future<Either<Failure, void>> setSessionActive(bool isActive);
  Future<Either<Failure, bool>> isSessionActive();
  Future<Either<Failure, void>> clearAllSessionData();

  // Remember me
  Future<Either<Failure, void>> setRememberMe(bool remember);
  Future<Either<Failure, bool>> isRememberMe();
  Future<Either<Failure, void>> clearRememberMe();

  // Biometric
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled);
  Future<Either<Failure, bool>> isBiometricEnabled();
  Future<Either<Failure, void>> clearBiometricEnabled();

  // Last login email
  Future<Either<Failure, void>> setLastLoginEmail(String email);
  Future<Either<Failure, String>> getLastLoginEmail();
  Future<Either<Failure, void>> clearLastLoginEmail();

  // Last login date
  Future<Either<Failure, void>> setLastLoginDate(DateTime date);
  Future<Either<Failure, DateTime?>> getLastLoginDate();
  Future<Either<Failure, void>> clearLastLoginDate();

  // Security
  Future<Either<Failure, void>> incrementFailedLoginAttempts();
  Future<Either<Failure, int>> getFailedLoginAttempts();
  Future<Either<Failure, void>> resetFailedLoginAttempts();

  // Lockout until
  Future<Either<Failure, void>> setLockoutUntil(DateTime date);
  Future<Either<Failure, void>> clearLockoutUntil();
  Future<Either<Failure, DateTime?>> getLockoutUntil();

  // Last login device
  Future<Either<Failure, void>> setLastLoginDevice(String device);

  // Device information
  Future<Either<Failure, void>> setDeviceId(String deviceId);
  Future<Either<Failure, String?>> getDeviceId();
  Future<Either<Failure, void>> clearDeviceId();

  // Get the user stream
  Stream<User?> get userStream;
}
