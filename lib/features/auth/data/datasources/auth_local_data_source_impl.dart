
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/exceptions/cache_exceptions.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/auth_tokens_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/auth_tokens.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage _secureStorage;
  final LocalStorage _sharedPrefsStorage;
  final LocalStorage _hiveStorage;
  // static const String _userBoxKey = 'auth_user';
  // static const String _tokensBoxKey = 'auth_tokens';

  final Encrypter _encrypter;
  final IV _iv;

  AuthLocalDataSourceImpl({
    @Named('secure_storage') required LocalStorage secureStorage,
    @Named('shared_prefs') required LocalStorage sharedPrefsStorage,
    @Named('hive_storage') required LocalStorage hiveStorage,
  }) : _secureStorage = secureStorage,
       _sharedPrefsStorage = sharedPrefsStorage,
       _hiveStorage = hiveStorage,
       _encrypter = Encrypter(
         AES(Key.fromUtf8(StorageConstants.encryptionKey)),
       ),
       _iv = IV.fromUtf8(StorageConstants.encryptionIv) {
    _initialize();
  }

  // late final Box<UserModel> _userBox;
  // late final Box<Map<String, dynamic>> _tokensBox;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject<User?>();

  Future<void> _initialize() async {
    // Listen for user changes
    (_hiveStorage as HiveStorage).watchBox(boxName: 'user').listen((event) {
      final user = event.value as UserModel?;
      _userSubject.add(user?.toEntity());
    });
  }

  // User Management
  @override
  Future<Either<Failure, void>> cacheUser(UserModel userModel) async {
    try {
      final userJson = jsonEncode(userModel.toJson());
      final encryptedUser = _encrypter.encrypt(userJson, iv: _iv);
         await _secureStorage.write(
         StorageConstants.userKey,
         encryptedUser.base64,
      );
      // await _hiveStorage.write(
      //   StorageConstants.userKey,
      //   userModel,
      //   boxName: StorageConstants.userBox,
      // );

      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save user: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCachedUser() async {
    try {
       final encryptedUser = await _secureStorage.read<String?>(
        StorageConstants.userKey,
      );
      
      if (encryptedUser == null) return const Right(null);

      final decryptedUser = _encrypter.decrypt64(encryptedUser, iv: _iv);
      final userJson = jsonDecode(decryptedUser) as Map<String, dynamic>;
      return Right(UserModel.fromJson(userJson));
      
      // final userModel = await _hiveStorage.read<UserModel?>(
      //   StorageConstants.userKey,
      //   boxName: StorageConstants.userBox,
      // );
      //return Right(userModel);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get user: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedUser() async {
    try {
      await _secureStorage.delete(StorageConstants.userKey);
      // await _hiveStorage.delete(
      //   StorageConstants.userKey,
      //   boxName: StorageConstants.userBox,
      // );
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear user: $e'),
        ),
      );
    }
  }

  // Tokens Management
  @override
  Future<Either<Failure, void>> cacheTokens(AuthTokensModel authTokensModel) async {
    try {
      await Future.wait([
        _secureStorage.write(StorageConstants.accessToken, authTokensModel.accessToken),
        _secureStorage.write(
          StorageConstants.refreshToken,
          authTokensModel.refreshToken,
        ),
        _secureStorage.write(StorageConstants.tokenType, authTokensModel.tokenType),
        _secureStorage.write(
          StorageConstants.tokenIssuedAt,
          authTokensModel.issuedAt.toIso8601String(),
        ),
        _secureStorage.write(
        StorageConstants.tokenExpiresAt,
        authTokensModel.expiresAt.toIso8601String(),
      ),
      ]);
      logger.i('[AuthLocalDataSourceImpl] Tokens cached successfully');
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save tokens: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthTokensModel?>> getCachedTokens() async {
    try {
      final accessToken = await _secureStorage.read<String>(
        StorageConstants.accessToken,
      );
      final refreshToken = await _secureStorage.read<String>(
        StorageConstants.refreshToken,
      );
      final issuedAtStr = await _secureStorage.read<String>(
        StorageConstants.tokenIssuedAt,
      );
      final expiresAtStr = await _secureStorage.read<String>(
        StorageConstants.tokenExpiresAt,
      );
      final tokenType = await _secureStorage.read<String>(
        StorageConstants.tokenType,
      );

      if (accessToken == null || refreshToken == null) {
        return const Right(null);
      }

      final tokenIssuedAt = issuedAtStr != null
          ? DateTime.parse(issuedAtStr)
          : DateTime.now();

      final tokenExpiresAt = expiresAtStr != null
          ? DateTime.parse(expiresAtStr)
          : DateTime.now();


      return Right(
        AuthTokensModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
          tokenType: tokenType ?? 'Unknown',
          issuedAt: tokenIssuedAt,
          expiresAt: tokenExpiresAt,
        ),
      );
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get tokens: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(StorageConstants.accessToken),
        _secureStorage.delete(StorageConstants.refreshToken),
        _secureStorage.delete(StorageConstants.tokenExpiresAt),
        _secureStorage.delete(StorageConstants.tokenIssuedAt),
        _secureStorage.delete(StorageConstants.tokenType),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear tokens: $e'),
        ),
      );
    }
  }

  @override
  Stream<User?> get userStream => _userSubject.stream;

  /// Session data
  @override
  Future<Either<Failure, void>> setSessionActive(bool isActive) async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.sessionActive, isActive);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save session data: $e'),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> isSessionActive() async {
    try {
      final isActive =
          await _sharedPrefsStorage.read<bool?>(
            StorageConstants.sessionActive,
          ) ??
          false;
      return Right(isActive);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get session data: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearAllSessionData() async {
    try {
      await Future.wait([
        clearCachedUser(),
        clearCachedTokens(),
        _sharedPrefsStorage.delete(StorageConstants.sessionActive),
        _sharedPrefsStorage.delete(StorageConstants.lastLoginEmail),
        _sharedPrefsStorage.delete(StorageConstants.lastLoginDate),
        _sharedPrefsStorage.delete(StorageConstants.biometricEnabled),
        _sharedPrefsStorage.delete(StorageConstants.rememberMe),
        _sharedPrefsStorage.delete(StorageConstants.failedLoginAttempts),
        _sharedPrefsStorage.delete(StorageConstants.lockoutUntil),
        _sharedPrefsStorage.delete(StorageConstants.sessionToken),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear session data: $e'),
        ),
      );
    }
  }

  // Remember me
  @override
  Future<Either<Failure, void>> setRememberMe(bool remember) async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.rememberMe, remember);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save remember me: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isRememberMe() async {
    try {
      final remember = await _sharedPrefsStorage.read<bool?>(StorageConstants.rememberMe) ?? false;
      return Right(remember);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get remember me: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearRememberMe() async {
    try {
      await _sharedPrefsStorage.delete(StorageConstants.rememberMe);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear remember me: $e'),
        ),
      );
    }
  }

  // Biometric settings
  @override
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled) async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.biometricEnabled, enabled);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save biometric enabled: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isBiometricEnabled() async {
    try {
      final enabled = await _sharedPrefsStorage.read<bool?>(StorageConstants.biometricEnabled) ?? false;
      return Right(enabled);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get biometric enabled: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearBiometricEnabled() async {
    try {
      await _sharedPrefsStorage.delete(StorageConstants.biometricEnabled);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear biometric enabled: $e'),
        ),
      );
    }
  }

  // Last login info
  @override
  Future<Either<Failure, void>> setLastLoginEmail(String email) async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.lastLoginEmail, email);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save last login email: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getLastLoginEmail() async {
    try {
      final email = await _sharedPrefsStorage.read<String?>(
        StorageConstants.lastLoginEmail,
      );
      return Right(email ?? '');
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get last login email: $e'),
        ),
      );
    }
  }
  @override
  Future<Either<Failure, void>> clearLastLoginEmail() async {
    try {
      await _sharedPrefsStorage.delete(StorageConstants.lastLoginEmail);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear last login email: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setLastLoginDate(DateTime dateTime) async {
    try {
      await _sharedPrefsStorage.write(
        StorageConstants.lastLoginDate,
        dateTime.toIso8601String(),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save last login date: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastLoginDate() async {
    try {
      final timestamp = await _sharedPrefsStorage.read<String?>(
        StorageConstants.lastLoginDate,
      );
      return Right(timestamp != null ? DateTime.parse(timestamp) : null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get last login date: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearLastLoginDate() async {
    try {
      await _sharedPrefsStorage.delete(StorageConstants.lastLoginDate);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear last login date: $e'),
        ),
      );
    }
  }

  // Failed login attempts
  @override
  Future<Either<Failure, void>> incrementFailedLoginAttempts() async {
    try {
      final currentAttempts =
          await _sharedPrefsStorage.read<int?>(
            StorageConstants.failedLoginAttempts,
          ) ??
          0;
      await _sharedPrefsStorage.write(
        StorageConstants.failedLoginAttempts,
        currentAttempts + 1,
      );
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(
            message: 'Failed to increment failed login attempts: $e',
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getFailedLoginAttempts() async {
    try {
      final attempts =
          await _sharedPrefsStorage.read<int?>(
            StorageConstants.failedLoginAttempts,
          ) ??
          0;
      return Right(attempts);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get failed login attempts: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resetFailedLoginAttempts() async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.failedLoginAttempts, 0);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to reset failed login attempts: $e'),
        ),
      );
    }
  }

  // Lockout until
  @override
  Future<Either<Failure, void>> setLockoutUntil(DateTime lockoutUntil) async {
    try {
      await _sharedPrefsStorage.write(
        StorageConstants.lockoutUntil,
        lockoutUntil.toIso8601String(),
      );
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save lockout until: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLockoutUntil() async {
    try {
      final lockoutUntil = await _sharedPrefsStorage.read<String?>(
        StorageConstants.lockoutUntil,
      );
      return Right(lockoutUntil != null ? DateTime.parse(lockoutUntil) : null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get lockout until: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearLockoutUntil() async {
    try {
      await _sharedPrefsStorage.delete(StorageConstants.lockoutUntil);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear lockout until: $e'),
        ),
      );
    }
  }

  // Last login device
  @override
  Future<Either<Failure, void>> setLastLoginDevice(String device) async {
    try {
      await _sharedPrefsStorage.write(StorageConstants.lastLoginDevice, device);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save last login device: $e'),
        ),
      );
    }
  }

  // Device information
  @override
  Future<Either<Failure, void>> setDeviceId(String deviceId) async {
    try {
      final encryptedDeviceId = _encrypter.encrypt(deviceId, iv: _iv);
      await _secureStorage.write(
        StorageConstants.deviceId,
        encryptedDeviceId.base64,
      );
      await _sharedPrefsStorage.write(StorageConstants.deviceId, deviceId);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to save device id: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> getDeviceId() async {
    try {
      final encryptedDeviceId = await _secureStorage.read<String?>(
        StorageConstants.deviceId,
      );
      if (encryptedDeviceId == null) {
        return const Right(null);
      }
      final deviceId = _encrypter.decrypt(
        Encrypted.fromBase64(encryptedDeviceId),
        iv: _iv,
      );
      return Right(deviceId);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to get device id: $e'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearDeviceId() async {
    try {
      await _secureStorage.delete(StorageConstants.deviceId);
      await _sharedPrefsStorage.delete(StorageConstants.deviceId);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handleError(
          CacheException(message: 'Failed to clear device id: $e'),
        ),
      );
    }
  }




  void dispose() {
    _userSubject.close();
  }
}
