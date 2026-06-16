import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/firebase/firebase_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/sentry_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Centralized error handler for the application.
///
/// Handles all types of errors, converts them to failures,
/// and provides logging and reporting capabilities.
class ErrorHandler {
  static late final AppConfig _appConfig;
  static bool _isInitialized = false;
  const ErrorHandler._();

  static SentryService? get _sentryService {
    try {
      return getIt.isRegistered<SentryService>()
          ? getIt<SentryService>()
          : null;
    } catch (_) {
      return null;
    }
  }

  static FirebaseService? get _firebaseService {
    try {
      return getIt.isRegistered<FirebaseService>()
          ? getIt<FirebaseService>()
          : null;
    } catch (_) {
      return null;
    }
  }

  static Future<void> initialize() async {
    if (_isInitialized) return;

    _appConfig = getIt<AppConfig>();

    // Set up Flutter error handling
    FlutterError.onError = _handleFlutterError;

    // Set up platform error handling
    PlatformDispatcher.instance.onError = _handlePlatformError;

    // Set up zone error handling for async errors
    runZonedGuarded(() {
      // This zone will handle all uncaught async errors
    }, _handleAsyncZoneError);

    logger.i('Error handling initialized for ${_appConfig.flavor}');
    _isInitialized = true;
  }

  /// Handle Flutter framework erros
  static void _handleFlutterError(FlutterErrorDetails details) {
    // Always present the error in the UI (red screen in debug)
    FlutterError.presentError(details);
    // Log to console in development
    if (_appConfig.enableLogging) {
      logger.e(
        'Flutter error: ${details.exceptionAsString()}',
        error: details.exception,
        stackTrace: details.stack,
      );
    }

    // Report to crash reporting services
    _reportError(
      details.exception,
      details.stack,
      reason: 'flutter_error',
      fatal: true,
      context: details.context?.toString(),
    );
  }

  /// Handle platform
  static bool _handlePlatformError(Object error, StackTrace stack) {
    // Log to console in development
    if (_appConfig.enableLogging) {
      logger.e('Platform error: $error', error: error, stackTrace: stack);
    }

    // Report to crash reporting services
    _reportError(error, stack, reason: 'platform_error', fatal: true);

    return true;
  }

  /// Handle zone errors for async operations
  static void _handleAsyncZoneError(Object error, StackTrace stack) {
    // Log to console in development
    if (_appConfig.enableLogging) {
      logger.e('Async zone error: $error', error: error, stackTrace: stack);
    }

    // Report to crash reporting services
    _reportError(error, stack, reason: 'async_zone_error', fatal: true);
  }

  /// Report to all configured crash reporting services
  static void _reportError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
    String? context,
  }) {
    if (!_isInitialized) return;
    try {
      // Report to Crashlytics if enabled
      if (_appConfig.enableCrashlytics) {
        _firebaseService?.recordError(
          error,
          stack ?? StackTrace.current,
          reason: reason,
          fatal: fatal,
          information: context != null ? {'context': context} : null,
        );
      }

      // Report to Sentry if enabled
      if (_appConfig.sentryDsn != null &&
          _appConfig.sentryDsn!.isNotEmpty &&
          _sentryService != null) {
        _sentryService!.captureException(
          error,
          stackTrace: stack,
          extra: {
            'reason': reason,
            'fatal': fatal,
            'context': context,
            'environment': _appConfig.flavor.name,
          },
          hint: Hint.withMap({'reason': reason}),
        );
      }
    } catch (e) {
      // Faile silently - we don't want to crash the app
      if (_appConfig.enableLogging) {
        logger.e('Failed to report error', error: e);
      }
    }
  }

  /// Manually capture an error
  static void captureError(
    Object error, {
    StackTrace? stack,
    String? reason,
    Map<String, dynamic>? extra,
  }) {
    if (!_isInitialized) return;

    final stackTrace = stack ?? StackTrace.current;

    // Log to console
    if (_appConfig.enableLogging) {
      logger.e('Manually captured error', error: error, stackTrace: stackTrace);
    }

    // Report to crash reporting services
    _reportError(error, stackTrace);
  }

  /// Set user identifier for crash reporting and Sentry
  static void setUserIdentifier(
    String userId, {
    String? email,
    String? username,
  }) {
    if (!_isInitialized) return;
    try {
      if (_appConfig.enableCrashlytics) {
        _firebaseService?.setUserIdentifier(userId);
      }
      if (_appConfig.sentryDsn != null &&
          _appConfig.sentryDsn!.isNotEmpty &&
          _sentryService != null) {
        _sentryService!.setUser(id: userId, email: email, username: username);
      }
    } catch (e) {
      if (_appConfig.enableLogging) {
        logger.e('Failed to set user identifier', error: e);
      }
    }
  }

  /// Clear user identifier (on logout)
  static void clearUserIdentifier() {
    if (!_isInitialized) return;
    try {
      if (_appConfig.enableCrashlytics) {
        _firebaseService?.crashlytics.setUserIdentifier('');
      }
      if (_appConfig.isSentryEnabled) {
        _sentryService?.clearUser();
      }
    } catch (e) {
      if (_appConfig.enableLogging) {
        logger.e('Failed to clear user identifier', error: e);
      }
    }
  }

  /// Set custom key for crash reporting
  static void setCustomKey(String key, String value) {
    if (!_isInitialized) return;
    try {
      if (_appConfig.enableCrashlytics) {
        _firebaseService?.crashlytics.setCustomKey(key, value);
      }
      if (_appConfig.isSentryEnabled) {
        _sentryService?.setExtra(key, value);
      }
    } catch (e) {
      if (_appConfig.enableLogging) {
        logger.e('Failed to set custom key', error: e);
      }
    }
  }

  /// Log a non-fatal error
  static void logNonFatalError(
    Object error, {
    StackTrace? stack,
    String? reason,
    Map<String, dynamic>? extra,
  }) {
    if (!_isInitialized) return;
    captureError(error, stack: stack, reason: reason ?? 'non_fatal_error');
  }

  /// Convert any error to a Failure
  static Failure handleError(Object error, {StackTrace? stackTrace}) {
    // Log error for debugging
    _logError(error, stackTrace);

    // Report to error tracking service
    _reportError(error, stackTrace, reason: 'error_handling');
    //_reportToSentry(error, stackTrace);

    // Handle different error types
    if (error is AppException) {
      return _handleAppException(error);
    } else if (error is DioException) {
      return _handleDioException(error);
    } else if (error is FormatException) {
      return ValidationFailure(
        message: 'Invalid data format received',
        code: 'FORMAT_ERROR',
        details: {'error': error.toString()},
      );
    } else if (error is Exception) {
      return ServerFailure(
        message: error.toString(),
        code: 'EXCEPTION',
        retryable: false,
      );
    } else {
      return UnknownFailure(
        details: {'error': error?.toString() ?? 'Unknown error'},
      );
    }
  }

  static Failure _handleAppException(AppException exception) {
    switch (exception.runtimeType) {
      // ============================================================
      // Network exceptions
      // ============================================================
      case NoInternetConnectionException:
        final ex = exception as NoInternetConnectionException;
        return NoInternetConnectionFailure(
          message: exception.message,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case ConnectionTimeoutException:
        final ex = exception as ConnectionTimeoutException;
        return ConnectionTimeoutFailure(
          message: exception.message,
          timeoutDuration: ex.timeoutDuration,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case DnsResolutionException:
        final ex = exception as DnsResolutionException;
        return DnsResolutionFailure(
          message: exception.message,
          hostname: ex.message.split(':').last.trim(),
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case SslException:
        final ex = exception as SslException;
        return SslFailure(
          message: exception.message,
          certificateSubject: ex.certificateSubject,
          certificateIssuer: ex.certificateIssuer,
          certificateExpiryDate: ex.certificateExpiryDate,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case NetworkUnreachableException:
        final ex = exception as NetworkUnreachableException;
        return NetworkUnreachableFailure(
          message: exception.message,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case SocketException:
        final ex = exception as SocketException;
        return SocketFailure(
          message: exception.message,
          port: ex.port,
          address: ex.address,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );
      case WebSocketException:
        final ex = exception as WebSocketException;
        return WebSocketFailure(
          message: exception.message,
          closeCode: ex.closeCode,
          closeReason: ex.closeReason,
          endpoint: ex.endpoint,
          details: exception.details,
        );
      case RequestCancelledException:
        final ex = exception as RequestCancelledException;
        return RequestCancelledFailure(
          message: exception.message,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );

      case HttpStatusException:
        final ex = exception as HttpStatusException;
        return HttpStatusFailure(
          message: exception.message,
          statusCode: ex.statusCode,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case ResponseParsingException:
        final ex = exception as ResponseParsingException;
        return ResponseParsingFailure(
          message: exception.message,
          rawResponse: ex.rawResponse,
          expectedType: ex.expectedType,
          endpoint: ex.endpoint,
          method: ex.method,
          details: exception.details,
        );

      // ============================================================
      // API exceptions
      // ============================================================
      case BadRequestException:
        final ex = exception as BadRequestException;
        return BadRequestFailure(
          message: exception.message,
          validationErrors: ex.validationErrors,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case UnauthorizedRequestException():
        final ex = exception as UnauthorizedRequestException;
        return UnauthorizedRequestFailure(
          message: exception.message,
          validationErrors: ex.validationErrors,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case ForbiddenException:
        final ex = exception as ForbiddenException;
        return ForbiddenFailure(
          message: exception.message,
          requiredPermission: ex.requiredPermission,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case ResourceNotFoundException:
        final ex = exception as ResourceNotFoundException;
        return ResourceNotFoundFailure(
          message: exception.message,
          resourceType: ex.resourceType,
          resourceId: ex.resourceId,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case ConflictException:
        final ex = exception as ConflictException;
        return ConflictFailure(
          message: exception.message,
          conflictingField: ex.conflictingField,
          conflictingValue: ex.conflictingValue,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case UnprocessableEntityException:
        final ex = exception as UnprocessableEntityException;
        return UnprocessableEntityFailure(
          message: exception.message,
          validationErrors: ex.validationErrors,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case TooManyRequestsException:
        final ex = exception as TooManyRequestsException;
        return TooManyRequestsFailure(
          message: exception.message,
          limit: ex.limit,
          remaining: ex.remaining,
          reset: ex.reset,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case InternalServerErrorException:
        final ex = exception as InternalServerErrorException;
        return InternalServerErrorFailure(
          message: exception.message,
          errorId: ex.errorId,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      case ServiceUnavailableException:
        final ex = exception as ServiceUnavailableException;
        return ServiceUnavailableFailure(
          message: exception.message,
          retryAfterSeconds: ex.retryAfterSeconds,
          endpoint: ex.endpoint,
          method: ex.method,
          responseData: ex.responseData,
          details: exception.details,
        );

      // ============================================================
      // Serialization exceptions
      // ============================================================
      case JsonSerializationException:
        final ex = exception as JsonSerializationException;
        return JsonSerializationFailure(
          message: exception.message,
          jsonPath: ex.jsonPath,
          expectedType: ex.expectedType,
          actualType: ex.actualType,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );
      case JsonDeserializationException:
        final ex = exception as JsonDeserializationException;
        return JsonDeserializationFailure(
          message: exception.message,
          jsonPath: ex.jsonPath,
          expectedType: ex.expectedType,
          actualType: ex.actualType,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );
      case ModelConversionException:
        final ex = exception as ModelConversionException;
        return ModelConversionFailure(
          message: exception.message,
          sourceType: ex.sourceType,
          targetType: ex.targetType,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );
      case HiveSerializationException:
        final ex = exception as HiveSerializationException;
        return HiveSerializationFailure(
          message: exception.message,
          typeId: ex.typeId,
          boxName: ex.boxName,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );
      case EncodingException:
        final ex = exception as EncodingException;
        return EncodingFailure(
          message: exception.message,
          encoding: ex.encoding,
          input: ex.input,
          details: exception.details,
        );
      case DateSerializationException:
        final ex = exception as DateSerializationException;
        return DateSerializationFailure(
          message: exception.message,
          dateFormat: ex.dateFormat,
          dateString: ex.dateString,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );
      case EnumSerializationException:
        final ex = exception as EnumSerializationException;
        return EnumSerializationFailure(
          message: exception.message,
          enumValue: ex.enumValue,
          enumType: ex.enumType,
          type: ex.type,
          data: ex.data,
          details: exception.details,
        );

      // ============================================================
      // Device exceptions
      // ============================================================
      case HardwareNotAvailableException:
        final ex = exception as HardwareNotAvailableException;
        return HardwareNotAvailableFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          details: exception.details,
        );
      case SensorException:
        final ex = exception as SensorException;
        return SensorFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          sensorDelay: ex.sensorDelay,
          details: exception.details,
        );
      case BiometricException:
        final ex = exception as BiometricException;
        return BiometricFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          biometricType: ex.biometricType,
          lockout: ex.lockout,
          details: exception.details,
        );
      case CameraException:
        final ex = exception as CameraException;
        return CameraFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          cameraId: ex.cameraId,
          details: exception.details,
        );
      case MicrophoneException:
        final ex = exception as MicrophoneException;
        return MicrophoneFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          details: exception.details,
        );
      case LocationException:
        final ex = exception as LocationException;
        return LocationFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          accuracy: ex.accuracy,
          timeout: ex.timeout,
          details: exception.details,
        );
      case BluetoothException:
        final ex = exception as BluetoothException;
        return BluetoothFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          deviceAddress: ex.deviceAddress,
          deviceName: ex.deviceName,
          details: exception.details,
        );
      case BatteryException:
        final ex = exception as BatteryException;
        return BatteryFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          batteryLevel: ex.batteryLevel,
          isCharging: ex.isCharging,
          details: exception.details,
        );
      case StorageDeviceException:
        final ex = exception as StorageDeviceException;
        return StorageDeviceFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          requiredSpace: ex.requiredSpace,
          availableSpace: ex.availableSpace,
          details: exception.details,
        );
      case DisplayException:
        final ex = exception as DisplayException;
        return DisplayFailure(
          message: exception.message,
          deviceFeature: ex.deviceFeature,
          deviceModel: ex.deviceModel,
          screenSize: ex.screenSize,
          orientation: ex.orientation,
          details: exception.details,
        );

      // ============================================================
      // Validation exceptions
      // ============================================================
      case ValidationException:
        final ex = exception as ValidationException;
        return ValidationFailure(
          message: exception.message,
          field: ex.field,
          rule: ex.rule,
          value: ex.value,
          details: exception.details,
        );
      case FormValidationException:
        final ex = exception as FormValidationException;
        return FormValidationFailure(
          message: exception.message,
          errors: ex.errors,
          details: exception.details,
        );

      case DataValidationException:
        final ex = exception as DataValidationException;
        return DataValidationFailure(
          message: exception.message,
          field: ex.field,
          rule: ex.rule,
          value: ex.value,
          details: exception.details,
        );
      case BusinessRuleException:
        final ex = exception as BusinessRuleException;
        return BusinessRuleFailure(
          message: exception.message,
          ruleName: ex.ruleName,
          details: exception.details,
        );
      case DateValidationException:
        final ex = exception as DateValidationException;
        return DateValidationFailure(
          message: exception.message,
          dateFormat: ex.dateFormat,
          date: ex.date,
          details: exception.details,
        );
      case RangeValidationException:
        final ex = exception as RangeValidationException;
        return RangeValidationFailure(
          message: exception.message,
          minValue: ex.minValue,
          maxValue: ex.maxValue,
          actualValue: ex.actualValue,
          details: exception.details,
        );

      // ============================================================
      // Permission exceptions
      // ============================================================
      case PermissionException:
        final ex = exception as PermissionException;
        return PermissionFailure(
          message: exception.message,
          permission: ex.permission,
          permanentlyDenied: ex.permanentlyDenied,
          shouldShowRationale: ex.shouldShowRationale,
          details: exception.details,
        );

      // ============================================================
      // Cache exceptions
      // ============================================================
      case CacheException:
        final ex = exception as CacheException;
        return CacheFailure(
          message: exception.message,
          key: ex.key,
          operation: ex.operation,
          details: exception.details,
        );

      // ============================================================
      // Auth exceptions
      // ============================================================
      case UnauthorizedAccessException:
        final ex = exception as UnauthorizedAccessException;

        return UnauthorizedAccessFailure(
          realm: ex.realm,
          details: exception.details,
          message: exception.message,
        );
      case InvalidCredentialsException:
        return InvalidCredentialsFailure(
          message: exception.message,
          details: exception.details,
        );
      case EmailNotVerifiedException:
        final ex = exception as EmailNotVerifiedException;
        return EmailNotVerifiedFailure(
          message: exception.message,
          resendEmail: ex.resendEmail,
          details: exception.details,
        );
      case AccountLockedException:
        final ex = exception as AccountLockedException;
        return AccountLockedFailure(
          remainingTime: ex.remainingTime,
          message: exception.message,
          details: exception.details,
        );
      case AccountDisabledException:
        return AccountDisabledFailure(message: exception.message);
      case TwoFactorRequiredException:
        final ex = exception as TwoFactorRequiredException;
        return TwoFactorRequiredFailure(
          twoFactorToken: ex.twoFactorToken,
          message: exception.message,
        );

      // ============================================================
      // File exceptions
      // ============================================================
      case FileNotFoundException:
        final ex = exception as FileNotFoundException;
        return FileNotFoundFailure(
          message: exception.message,
          path: ex.path,
          fileName: ex.fileName,
          details: exception.details,
        );
      case FileTooLargeException:
        final ex = exception as FileTooLargeException;
        return FileTooLargeFailure(
          fileSize: ex.fileSize,
          maxSize: ex.maxSize,
          message: exception.message,
          path: ex.path,
          fileName: ex.fileName,
          details: exception.details,
        );

      // ============================================================
      // Payment exceptions
      // ============================================================
      case PaymentDeclinedException:
        final ex = exception as PaymentDeclinedException;
        return PaymentDeclinedFailure(
          message: exception.message,
          declineReason: ex.declineReason,
          transactionId: ex.transactionId,
          paymentMethod: ex.paymentMethod,
          details: exception.details,
        );
      case InsufficientFundsException:
        final ex = exception as InsufficientFundsException;
        return InsufficientFundsFailure(
          message: exception.message,
          requiredAmount: ex.requiredAmount,
          availableAmount: ex.availableAmount,
          transactionId: ex.transactionId,
          paymentMethod: ex.paymentMethod,
          details: exception.details,
        );
      case PaymentProcessingException:
        final ex = exception as PaymentProcessingException;
        return PaymentProcessingFailure(
          message: exception.message,
          processingError: ex.processingError,
          transactionId: ex.transactionId,
          paymentMethod: ex.paymentMethod,
          details: exception.details,
        );
      case PaymentTimeoutException:
        final ex = exception as PaymentTimeoutException;
        return PaymentTimeoutFailure(
          message: exception.message,
          transactionId: ex.transactionId,
          paymentMethod: ex.paymentMethod,
          details: exception.details,
        );
      case RefundException:
        final ex = exception as RefundException;
        return RefundFailure(
          message: exception.message,
          transactionId: ex.transactionId,
          paymentMethod: ex.paymentMethod,
          details: exception.details,
        );

      default:
        return ServerFailure(
          message: exception.message,
          retryable: true,
          details: exception.details,
        );
    }
  }

  static Failure _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConnectionTimeoutFailure(
          message: 'Connection timeout. Please try again.',
          timeoutDuration: const Duration(seconds: 30),
          endpoint: error.requestOptions.path,
          method: error.requestOptions.method,
        );

      case DioExceptionType.connectionError:
        return NoInternetConnectionFailure(
          message: 'No internet connection',
          endpoint: error.requestOptions.path,
          method: error.requestOptions.method,
        );

      case DioExceptionType.badResponse:
        return _handleStatusCode(
          error.response?.statusCode,
          error.response?.data,
          error.requestOptions.path,
          error.requestOptions.method,
        );

      case DioExceptionType.cancel:
        return RequestCancelledFailure(
          message: 'Request was cancelled',
          endpoint: error.requestOptions.path,
          method: error.requestOptions.method,
        );

      case DioExceptionType.badCertificate:
        return SslFailure(
          message: 'Security certificate error',
          endpoint: error.requestOptions.path,
          method: error.requestOptions.method,
        );

      case DioExceptionType.unknown:
        if (error.error is FormatException) {
          return ResponseParsingFailure(
            message: 'Invalid response format',
            rawResponse: error.response?.data,
            endpoint: error.requestOptions.path,
            method: error.requestOptions.method,
          );
        }
        if (error.error is SocketException) {
          return NoInternetConnectionFailure(
            message: 'Network error',
            endpoint: error.requestOptions.path,
            method: error.requestOptions.method,
          );
        }
        return ServerFailure(
          message: error.message ?? 'An unknown error occurred',
          retryable: true,
          endpoint: error.requestOptions.path,
        );
    }
  }

  static Failure _handleStatusCode(
    int? statusCode,
    dynamic data,
    String endpoint,
    String method,
  ) {
    final message = _extractErrorMessage(data);
    final validationErrors = _extractValidationErrors(data);

    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: message ?? 'Invalid request',
          code: 'BAD_REQUEST',
          details: validationErrors,
        );
      case 401:
        return UnauthorizedRequestFailure(
          message: message ?? 'Unauthorized request',
          validationErrors: validationErrors,
          details: validationErrors,
        );
      case 403:
        return PermissionFailure(
          message: message ?? 'Access forbidden',
          permission: 'resource_access',
          details: validationErrors,
        );
      case 404:
        return NotFoundFailure(
          resourceType: 'Resource',
          message: message ?? 'Resource not found',
          details: validationErrors,
        );
      case 409:
        return AlreadyExistsFailure(
          resourceType: 'Resource',
          message: message ?? 'Conflict with current state',
          details: validationErrors,
        );
      case 422:
        return FormValidationFailure(
          message: message ?? 'Validation failed',
          errors: validationErrors ?? {},
          details: validationErrors,
        );
      case 429:
        return RateLimitExceededFailure(
          message: message ?? 'Too many requests',
          retryAfterSeconds: _extractRetryAfter(data) ?? 60,
          endpoint: endpoint,
          method: method,
          details: validationErrors,
        );
      case 500:
      case 502:
      case 503:
        return ServerFailure(
          message: message ?? 'Server error',
          code: 'SERVER_ERROR',
          retryable: true,
          statusCode: statusCode,
          endpoint: endpoint,
          details: validationErrors,
        );
      default:
        return ServerFailure(
          message: message ?? 'An error occurred',
          statusCode: statusCode,
          retryable: true,
          endpoint: endpoint,
          details: validationErrors,
        );
    }
  }

  static String? _extractErrorMessage(dynamic data) {
    if (data is Map) {
      final raw =
          data['message'] ??
          data['error'] ??
          data['error_message'] ??
          data['detail'] ??
          data['msg'];
      return raw?.toString();
    }
    return null;
  }

  static Map<String, List<String>>? _extractValidationErrors(dynamic data) {
    if (data is Map) {
      // Handle different error formats
      if (data['errors'] is Map) {
        final errors = <String, List<String>>{};
        (data['errors'] as Map).forEach((key, value) {
          if (value is List) {
            errors[key.toString()] = value.map((e) => e.toString()).toList();
          } else if (value is String) {
            errors[key.toString()] = [value.toString()];
          }
        });
        return errors;
      }

      // Handle Laravel-style errors
      if (data['errors'] is List) {
        final errors = <String, List<String>>{};
        (data['errors'] as List).forEach((error) {
          if (error is Map) {
            final field = error['field'] ?? error['param'];
            final message = error['message'];
            if (field != null && message != null) {
              errors.putIfAbsent(field.toString(), () => []);
              errors[field.toString()]!.add(message.toString());
            }
          }
        });
        return errors;
      }
    }
    return null;
  }

  static int? _extractRetryAfter(dynamic data) {
    if (data is Map && data['retry_after'] is int) {
      return data['retry_after'] as int?;
    }
    return null;
  }

  static void _logError(Object error, StackTrace? stackTrace) {
    // Use your logging solution
    if (_appConfig.enableLogging) {
      logger.e('Error', error: error, stackTrace: stackTrace);
    }
  }

  // Global error handling for Flutter
  static void handleFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);

    final failure = handleError(details.exception, stackTrace: details.stack);

    Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
      hint: Hint.withMap({
        'library': details.library,
        'context': details.context,
        'failure_type': failure.runtimeType.toString(),
        'failure_code': failure.code,
      }),
    );
  }

  // Platform error handling
  static bool handlePlatformError(Object error, StackTrace stack) {
    handleError(error, stackTrace: stack);
    return true;
  }
}




// Example UI layer usage

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AuthBloc(
//         loginUseCase: getIt<LoginUseCase>(),
//       ),
//       child: const LoginView(),
//     );
//   }
// }

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state.status == AuthStatus.failure && state.failure != null) {
//             _handleFailure(context, state.failure!);
//           }
          
//           if (state.status == AuthStatus.authenticated) {
//             // Navigate to home
//             Navigator.pushReplacementNamed(context, '/home');
//           }
//         },
//         child: const LoginForm(),
//       ),
//     );
//   }
  
//   void _handleFailure(BuildContext context, Failure failure) {
//     // Example 1: Show SnackBar
//     ErrorMapper.toSnackBar(
//       failure,
//       onRetry: () {
//         // Retry logic
//         context.read<AuthBloc>().add(AuthLoginRequested(
//           email: _getEmail(context),
//           password: _getPassword(context),
//         ));
//       },
//     );
    
//     // Example 2: Show Dialog for critical errors
//     if (failure is UnauthorizedFailure) {
//       ErrorMapper.showErrorDialog(
//         context: context,
//         failure: failure,
//         onRetry: () {
//           // Navigate to login
//           Navigator.pushReplacementNamed(context, '/login');
//         },
//         title: 'Session Expired',
//       );
//     }
    
//     // Example 3: Handle specific validation failures
//     if (failure is ValidationFailure && failure.field == 'email') {
//       _showFieldError(context, failure.message);
//     }
//   }
  
//   void _showFieldError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.orange,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
  
//   String _getEmail(BuildContext context) {
//     // Get email from form
//     return '';
//   }
  
//   String _getPassword(BuildContext context) {
//     // Get password from form
//     return '';
//   }
// }


// Example API Client usage

// class DioClient {
//   DioClient(this._dio);
  
//   final Dio _dio;
  
//   Future<T> get<T>(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error, stackTrace) {
//       // Convert to AppException using ErrorHandler
//       final failure = ErrorHandler.handleError(error, stackTrace: stackTrace);
      
//       // Throw appropriate exception based on failure type
//       if (failure is NoInternetConnectionFailure) {
//         throw NoInternetConnectionException(
//           message: failure.message,
//           endpoint: path,
//           method: 'GET',
//         );
//       } else if (failure is UnauthorizedFailure) {
//         throw UnauthorizedException(
//           message: failure.message,
//           endpoint: path,
//           method: 'GET',
//         );
//       } else if (failure is BadRequestFailure) {
//         throw BadRequestException(
//           message: failure.message,
//           validationErrors: failure.validationErrors,
//           endpoint: path,
//           method: 'GET',
//         );
//       } else {
//         throw ApiException(
//           message: failure.message,
//           statusCode: (failure as ApiFailure?)?.statusCode ?? 500,
//           endpoint: path,
//           method: 'GET',
//         );
//       }
//     }
//   }
  
//   Future<T> post<T>(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     try {
//       final response = await _dio.post(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );
//       return response.data as T;
//     } catch (error, stackTrace) {
//       final failure = ErrorHandler.handleError(error, stackTrace: stackTrace);
      
//       if (failure is UnprocessableEntityFailure) {
//         throw UnprocessableEntityException(
//           message: failure.message,
//           validationErrors: failure.validationErrors,
//           endpoint: path,
//           method: 'POST',
//           responseData: failure.responseData,
//         );
//       } else if (failure is TooManyRequestsFailure) {
//         throw TooManyRequestsException(
//           message: failure.message,
//           endpoint: path,
//           method: 'POST',
//         );
//       } else {
//         throw ApiException(
//           message: failure.message,
//           statusCode: (failure as ApiFailure?)?.statusCode ?? 500,
//           endpoint: path,
//           method: 'POST',
//         );
//       }
//     }
//   }
// }