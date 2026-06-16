import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'failures.dart';

/// Maps failures to user-friendly messages and UI components.
///
/// This class provides a centralized way to convert technical failures
/// into user-facing messages and appropriate UI widgets.
class ErrorMapper {
  const ErrorMapper._();

  // ============================================================================
  // User Messages
  // ============================================================================

  /// Convert failure to user-friendly message
  static String toUserMessage(
    Failure failure, {
    BuildContext? context,
    AppLocalizations? l10n,
  }) {
    // Use provided l10n or get from context
    final localizations = l10n ?? (context != null ? AppLocalizations.of(context) : null);

    // Map failure types to user messages
    switch (failure.runtimeType) {
      // Network failures
      case NetworkFailure:
        return _mapNetworkFailure(failure as NetworkFailure, localizations);
      
      case NoInternetConnectionFailure:
        return localizations?.noInternetError ?? 
            'No internet connection. Please check your network.';
      
      case ConnectionTimeoutFailure:
        return localizations?.connectionTimeoutError ?? 
            'Connection timeout. Please try again.';
      
      case DnsResolutionFailure:
        return localizations?.dnsResolutionError ?? 
            'Unable to resolve server address.';
      
      case SslFailure:
        return localizations?.sslError ?? 
            'Secure connection failed. Please check your internet connection.';
      
      case HttpStatusFailure:
        return _mapHttpStatusFailure(failure as HttpStatusFailure, localizations);
      
      case RequestCancelledFailure:
        return localizations?.requestCancelledError ?? 
            'Request was cancelled.';
      
      case ResponseParsingFailure:
        return localizations?.responseParsingError ?? 
            'Unable to process server response.';
      
      case RateLimitExceededFailure:
        return localizations?.rateLimitError ?? 
            'Too many requests. Please try again later.';
      
      case WebSocketFailure:
        return localizations?.webSocketError ?? 
            'Connection lost. Please reconnect.';

      // Serialization failures
      case JsonSerializationFailure:
        return _mapJsonSerializationFailure(failure as JsonSerializationFailure, localizations);
      
      case ModelConversionFailure:
        return localizations?.dataConversionError ?? 
            'Unable to process data. Please try again.';
      
      case HiveSerializationFailure:
        return localizations?.storageReadError ?? 
            'Unable to read saved data.';
      
      case EncodingFailure:
        return localizations?.encodingError ?? 
            'Unable to process data encoding.';
      
      case DateSerializationFailure:
        return localizations?.dateFormatError ?? 
            'Invalid date format.';
      
      case EnumSerializationFailure:
        return localizations?.invalidValueError ?? 
            'Invalid value received.';

      // Device failures
      case HardwareNotAvailableFailure:
        return _mapHardwareFailure(failure as HardwareNotAvailableFailure, localizations);
      
      case SensorFailure:
        return _mapSensorFailure(failure as SensorFailure, localizations);
      
      case BiometricFailure:
        return _mapBiometricFailure(failure as BiometricFailure, localizations);
      
      case CameraFailure:
        return _mapCameraFailure(failure as CameraFailure, localizations);
      
      case MicrophoneFailure:
        return _mapMicrophoneFailure(failure as MicrophoneFailure, localizations);
      
      case LocationFailure:
        return _mapLocationFailure(failure as LocationFailure, localizations);
      
      case BluetoothFailure:
        return _mapBluetoothFailure(failure as BluetoothFailure, localizations);
      
      case BatteryFailure:
        return _mapBatteryFailure(failure as BatteryFailure, localizations);
      
      case StorageDeviceFailure:
        return _mapStorageFailure(failure as StorageDeviceFailure, localizations);
      
      case DisplayFailure:
        return _mapDisplayFailure(failure as DisplayFailure, localizations);

      // Server failures
      case ServerFailure:
        return _mapServerFailure(failure as ServerFailure, localizations);

      // Authentication failures
      case UnauthorizedAccessFailure:
        return localizations?.unauthorizedError ??
            'Your session has expired. Please login again.';

      case InvalidCredentialsFailure:
        return localizations?.invalidCredentialsError ??
            'Invalid email or password.';

      case EmailNotVerifiedFailure:
        return localizations?.emailNotVerifiedError ??
            'Please verify your email address before logging in.';

      case AccountLockedFailure:
        final lockedFailure = failure as AccountLockedFailure;
        return localizations?.accountLockedError(
              lockedFailure.remainingTime.inMinutes,
            ) ??
            'Account temporarily locked. Try again in ${lockedFailure.remainingTime.inMinutes} minutes.';

      case AccountDisabledFailure:
        return localizations?.accountDisabledError ??
            'Your account has been disabled. Please contact support.';

      // Validation failures
      case ValidationFailure:
        return _mapValidationFailure(failure as ValidationFailure, localizations);

      case FormValidationFailure:
        return localizations?.formValidationError ?? 'Please fix the errors in the form.';

      // Permission failures
      case PermissionFailure:
        return _mapPermissionFailure(failure as PermissionFailure, localizations);

      // File failures
      case FileNotFoundFailure:
        return localizations?.fileNotFoundError ?? 'File not found.';

      case FileTooLargeFailure:
        final fileFailure = failure as FileTooLargeFailure;
        return localizations?.fileTooLargeError(
              _formatSize(fileFailure.fileSize),
              _formatSize(fileFailure.maxSize),
            ) ??
            'File size (${_formatSize(fileFailure.fileSize)}) exceeds limit (${_formatSize(fileFailure.maxSize)}).';

      // Payment failures
      case PaymentDeclinedFailure:
        final paymentFailure = failure as PaymentDeclinedFailure;
        return paymentFailure.declineReason != null
            ? 'Payment declined: ${paymentFailure.declineReason}'
            : localizations?.paymentDeclinedError ?? 'Payment was declined.';

      case InsufficientFundsFailure:
        return localizations?.insufficientFundsError ?? 'Insufficient funds for this transaction.';

      // Business failures
      case NotFoundFailure:
        return localizations?.resourceNotFoundError ?? 'Requested resource was not found.';

      case AlreadyExistsFailure:
        return localizations?.resourceAlreadyExistsError ?? 'Resource already exists.';

      case OperationNotAllowedFailure:
        return localizations?.operationNotAllowedError ?? 'This operation is not allowed.';

      // Third-party service failures
      case FirebaseFailure:
        return localizations?.serviceUnavailableError ??
            'Service temporarily unavailable. Please try again later.';

      // Unknown failure
      default:
        return localizations?.unknownError ?? 'An unexpected error occurred. Please try again.';
    }
  }

  // ============================================================================
  // Network Message Mappers
  // ============================================================================

  static String _mapNetworkFailure(NetworkFailure failure, AppLocalizations? l10n) {
    if (failure.timeout) {
      return l10n?.connectionTimeoutError ?? 'Connection timeout. Please try again.';
    }
    return l10n?.networkError ?? 'No internet connection. Please check your network.';
  }

  static String _mapHttpStatusFailure(HttpStatusFailure failure, AppLocalizations? l10n) {
    if (failure.isRateLimited) {
      return l10n?.rateLimitError ?? 'Too many requests. Please try again later.';
    }
    if (failure.isAuthenticationError) {
      return l10n?.unauthorizedError ?? 'Please login again.';
    }
    if (failure.isPermissionError) {
      return l10n?.permissionDeniedError ?? 'You don\'t have permission for this action.';
    }
    if (failure.isNotFound) {
      return l10n?.resourceNotFoundError ?? 'Resource not found.';
    }
    if (failure.isServerError) {
      return l10n?.serverError ?? 'Server error. Please try again later.';
    }
    return failure.message;
  }

  // ============================================================================
  // Serialization Message Mappers
  // ============================================================================

  static String _mapJsonSerializationFailure(JsonSerializationFailure failure, AppLocalizations? l10n) {
    if (failure.jsonPath != null) {
      return l10n?.invalidDataAtPathError(failure.jsonPath!) ??
          'Invalid data at ${failure.jsonPath}. Please contact support.';
    }
    return l10n?.invalidDataError ?? 'Unable to process data. Please try again.';
  }

  // ============================================================================
  // Device Message Mappers
  // ============================================================================

  static String _mapHardwareFailure(HardwareNotAvailableFailure failure, AppLocalizations? l10n) {
    final hardware = failure.deviceFeature ?? 'hardware';
    return l10n?.hardwareNotAvailableError(hardware) ??
        '$hardware is not available on this device.';
  }

  static String _mapSensorFailure(SensorFailure failure, AppLocalizations? l10n) {
    if (failure.code == 'SENSOR_NOT_AVAILABLE') {
      return l10n?.sensorNotAvailableError(failure.deviceFeature ?? 'Sensor') ??
          '${failure.deviceFeature ?? 'Sensor'} not available on this device.';
    }
    if (failure.code == 'SENSOR_PERMISSION_DENIED') {
      return l10n?.sensorPermissionError(failure.deviceFeature ?? 'Sensor') ??
          'Permission required for ${failure.deviceFeature ?? 'sensor'}.';
    }
    return failure.message;
  }

  static String _mapBiometricFailure(BiometricFailure failure, AppLocalizations? l10n) {
    switch (failure.code) {
      case 'BIOMETRIC_NOT_AVAILABLE':
        return l10n?.biometricNotAvailableError ??
            'Biometric authentication is not available on this device.';
      case 'BIOMETRIC_NOT_ENROLLED':
        return l10n?.biometricNotEnrolledError ??
            'No biometrics enrolled. Please set up fingerprint or face ID in settings.';
      case 'BIOMETRIC_LOCKED_OUT':
        return l10n?.biometricLockedOutError ??
            'Too many failed attempts. Biometric authentication is locked.';
      case 'BIOMETRIC_AUTH_FAILED':
        return l10n?.biometricAuthFailedError ??
            'Authentication failed. Please try again.';
      default:
        return failure.message;
    }
  }

  static String _mapCameraFailure(CameraFailure failure, AppLocalizations? l10n) {
    switch (failure.code) {
      case 'CAMERA_NOT_AVAILABLE':
        return l10n?.cameraNotAvailableError ??
            'Camera is not available on this device.';
      case 'CAMERA_IN_USE':
        return l10n?.cameraInUseError ??
            'Camera is already in use by another app.';
      case 'CAMERA_PERMISSION_DENIED':
        return l10n?.cameraPermissionError ??
            'Camera permission is required to take photos.';
      default:
        return failure.message;
    }
  }

  static String _mapMicrophoneFailure(MicrophoneFailure failure, AppLocalizations? l10n) {
    switch (failure.code) {
      case 'MICROPHONE_NOT_AVAILABLE':
        return l10n?.microphoneNotAvailableError ??
            'Microphone is not available on this device.';
      case 'MICROPHONE_PERMISSION_DENIED':
        return l10n?.microphonePermissionError ??
            'Microphone permission is required for recording.';
      case 'MICROPHONE_RECORDING_FAILED':
        return l10n?.recordingFailedError ??
            'Failed to start recording. Please try again.';
      default:
        return failure.message;
    }
  }

  static String _mapLocationFailure(LocationFailure failure, AppLocalizations? l10n) {
    switch (failure.code) {
      case 'LOCATION_SERVICES_DISABLED':
        return l10n?.locationServicesDisabledError ??
            'Location services are disabled. Please enable them in settings.';
      case 'LOCATION_PERMISSION_DENIED':
        return l10n?.locationPermissionError ??
            'Location permission is required for this feature.';
      case 'LOCATION_PERMISSION_PERMANENTLY_DENIED':
        return l10n?.locationPermissionPermanentlyDeniedError ??
            'Location permission permanently denied. Please enable it in settings.';
      case 'LOCATION_TIMEOUT':
        return l10n?.locationTimeoutError ??
            'Location request timed out. Please try again.';
      case 'LOCATION_UNAVAILABLE':
        return l10n?.locationUnavailableError ??
            'Unable to determine your location. Please try again.';
      default:
        return failure.message;
    }
  }

  static String _mapBluetoothFailure(BluetoothFailure failure, AppLocalizations? l10n) {
    switch (failure.code) {
      case 'BLUETOOTH_NOT_AVAILABLE':
        return l10n?.bluetoothNotAvailableError ??
            'Bluetooth is not available on this device.';
      case 'BLUETOOTH_DISABLED':
        return l10n?.bluetoothDisabledError ??
            'Bluetooth is disabled. Please enable it in settings.';
      case 'BLUETOOTH_PERMISSION_DENIED':
        return l10n?.bluetoothPermissionError ??
            'Bluetooth permission is required.';
      case 'BLUETOOTH_CONNECTION_FAILED':
        return l10n?.bluetoothConnectionError(failure.deviceName ?? 'Device') ??
            'Failed to connect to ${failure.deviceName ?? 'device'}.';
      default:
        return failure.message;
    }
  }

  static String _mapBatteryFailure(BatteryFailure failure, AppLocalizations? l10n) {
    if (failure.batteryLevel != null) {
      if (failure.batteryLevel! <= 15) {
        return l10n?.criticalBatteryError(failure.batteryLevel!) ??
            'Critical battery level: ${failure.batteryLevel}%. Please charge your device.';
      }
      if (failure.batteryLevel! <= 20) {
        return l10n?.lowBatteryError(failure.batteryLevel!) ??
            'Low battery: ${failure.batteryLevel}%. Please charge soon.';
      }
    }
    return failure.message;
  }

  static String _mapStorageFailure(StorageDeviceFailure failure, AppLocalizations? l10n) {
    if (failure.requiredSpace != null && failure.availableSpace != null) {
      return l10n?.insufficientStorageError(
            _formatSize(failure.requiredSpace!),
            _formatSize(failure.availableSpace!),
          ) ??
          'Insufficient storage. Need ${_formatSize(failure.requiredSpace!)}, '
          'available ${_formatSize(failure.availableSpace!)}.';
    }
    return l10n?.storageError ?? 'Storage error. Please free up space and try again.';
  }

  static String _mapDisplayFailure(DisplayFailure failure, AppLocalizations? l10n) {
    return l10n?.unsupportedDisplayError ?? 'Your device screen is not supported.';
  }

  static String _mapServerFailure(ServerFailure failure, AppLocalizations? l10n) {
    if (failure.isRateLimited) {
      return l10n?.rateLimitError ?? 'Too many requests. Please try again later.';
    }
    if (failure.isTimeout) {
      return l10n?.timeoutError ?? 'Request timed out. Please try again.';
    }
    if (failure.isClientError) {
      return l10n?.clientError ?? 'Invalid request. Please check your input.';
    }
    if (failure.isServerError) {
      return l10n?.serverError ?? 'Server error. Please try again later.';
    }
    return failure.message;
  }

  static String _mapValidationFailure(ValidationFailure failure, AppLocalizations? l10n) {
    if (failure.field != null && failure.rule != null) {
      return l10n?.fieldValidationError(failure.field!, failure.message) ?? failure.message;
    }
    return failure.message;
  }

  static String _mapPermissionFailure(PermissionFailure failure, AppLocalizations? l10n) {
    if (failure.permanentlyDenied) {
      return l10n?.permissionPermanentlyDenied(failure.permission) ??
          'Permission permanently denied. Please enable it in settings.';
    }
    return l10n?.permissionRequired(failure.permission) ??
          'Permission required: ${failure.permission}';
  }

  static String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // ============================================================================
  // SnackBar
  // ============================================================================

  /// Convert failure to a SnackBar
  static SnackBar toSnackBar(
    Failure failure, {
    BuildContext? context,
    AppLocalizations? l10n,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    VoidCallback? onDismiss,
  }) {
    final message = toUserMessage(failure, context: context, l10n: l10n);

    return SnackBar(
      content: Text(message),
      backgroundColor: _getSnackBarColor(failure),
      duration: duration,
      behavior: behavior,
      action: _getSnackBarAction(failure, context, onDismiss),
      onVisible: () {
        _trackErrorShown(failure, 'snackbar');
      },
    );
  }

  static Color _getSnackBarColor(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
      case NoInternetConnectionFailure:
      case ConnectionTimeoutFailure:
        return Colors.orange;
      
      case UnauthorizedAccessFailure:
      case InvalidCredentialsFailure:
      case AccountLockedFailure:
        return Colors.red;
      
      case ValidationFailure:
      case FormValidationFailure:
      case JsonSerializationFailure:
      case DateSerializationFailure:
        return Colors.amber;
      
      case PermissionFailure:
      case CameraFailure:
      case MicrophoneFailure:
      case LocationFailure:
      case BluetoothFailure:
        return Colors.blue;
      
      case BatteryFailure:
        return Colors.yellow.shade800;
      
      case StorageDeviceFailure:
        return Colors.purple;
      
      default:
        return Colors.red;
    }
  }

  static SnackBarAction? _getSnackBarAction(
    Failure failure,
    BuildContext? context,
    VoidCallback? onDismiss,
  ) {
    if (_isRetryable(failure)) {
      return SnackBarAction(
        label: 'Retry',
        onPressed: () {
          _trackErrorAction(failure, 'retry');
          onDismiss?.call();
        },
      );
    }
    return null;
  }

  // ============================================================================
  // Dialogs
  // ============================================================================

  /// Show error dialog for failure
  static Future<void> showErrorDialog({
    required BuildContext context,
    required Failure failure,
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
    String? title,
    bool barrierDismissible = false,
  }) async {
    final l10n = AppLocalizations.of(context);
    final message = toUserMessage(failure, l10n: l10n);
    final isRetryable = _isRetryable(failure);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(_getDialogIcon(failure), color: _getDialogIconColor(failure)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title ?? _getDialogTitle(failure, l10n),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (_shouldShowDetails(failure))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _getErrorDetails(failure),
                  style: Theme.of(dialogContext).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            if (_shouldShowActionTip(failure))
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _getActionTip(failure, l10n),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _trackErrorAction(failure, 'dismiss');
              onDismiss?.call();
            },
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          if (isRetryable)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _trackErrorAction(failure, 'retry');
                onRetry?.call();
              },
              child: Text(l10n?.retry ?? 'Retry'),
            ),
          if (_shouldShowSettingsAction(failure))
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _trackErrorAction(failure, 'open_settings');
                _openAppSettings(context, failure);
              },
              child: Text(l10n?.openSettings ?? 'Open Settings'),
            ),
        ],
      ),
    );
  }

  static IconData _getDialogIcon(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
      case NoInternetConnectionFailure:
        return Icons.wifi_off;
      case ConnectionTimeoutFailure:
        return Icons.timer_off;
      case UnauthorizedRequestFailure:
        return Icons.lock;
      case ValidationFailure:
      case FormValidationFailure:
        return Icons.error_outline;
      case PermissionFailure:
      case CameraFailure:
      case MicrophoneFailure:
      case LocationFailure:
        return Icons.security;
      case BatteryFailure:
        return Icons.battery_alert;
      case StorageDeviceFailure:
        return Icons.storage;
      case BiometricFailure:
        return Icons.fingerprint;
      default:
        return Icons.error_outline;
    }
  }

  static Color _getDialogIconColor(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return Colors.orange;
      case StorageDeviceFailure:
        return Colors.purple;
      default:
        return Colors.red;
    }
  }

  static String _getDialogTitle(Failure failure, AppLocalizations? l10n) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return l10n?.batteryAlertTitle ?? 'Battery Alert';
      case StorageDeviceFailure:
        return l10n?.storageAlertTitle ?? 'Storage Alert';
      case BiometricFailure:
        return l10n?.biometricTitle ?? 'Biometric Authentication';
      case PermissionFailure:
        return l10n?.permissionRequiredTitle ?? 'Permission Required';
      default:
        return l10n?.errorTitle ?? 'Error';
    }
  }

  static Widget _getActionTip(Failure failure, AppLocalizations? l10n) {
    final tip = _getActionTipText(failure, l10n);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, size: 16, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
            ),
          ),
        ],
      ),
    );
  }

  static String _getActionTipText(Failure failure, AppLocalizations? l10n) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return l10n?.batteryTip ?? 'Please connect your device to a charger.';
      case StorageDeviceFailure:
        return l10n?.storageTip ?? 'Free up space by deleting unused files or apps.';
      case LocationFailure:
        return l10n?.locationTip ?? 'Enable location services in device settings.';
      case CameraFailure:
        return l10n?.cameraTip ?? 'Grant camera permission in app settings.';
      default:
        return '';
    }
  }

  static bool _shouldShowDetails(Failure failure) {
    return failure.code != null && failure.code != 'UNKNOWN_ERROR';
  }

  static bool _shouldShowActionTip(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
      case StorageDeviceFailure:
      case LocationFailure:
      case CameraFailure:
      case MicrophoneFailure:
        return true;
      default:
        return false;
    }
  }

  static bool _shouldShowSettingsAction(Failure failure) {
    switch (failure.runtimeType) {
      case LocationFailure:
      case CameraFailure:
      case MicrophoneFailure:
      case PermissionFailure:
        return true;
      default:
        return false;
    }
  }

  static Future<void> _openAppSettings(BuildContext context, Failure failure) async {
    // Implement app settings opening logic
    // await openAppSettings();
  }

  static String _getErrorDetails(Failure failure) {
    if (failure.code != null) {
      return 'Error code: ${failure.code}';
    }
    return '';
  }

  // ============================================================================
  // Error Widgets
  // ============================================================================

  /// Build error widget for UI
  static Widget buildErrorWidget({
    required Failure failure,
    VoidCallback? onRetry,
    String? message,
    bool showRetry = true,
  }) {
    final errorMessage = message ?? toUserMessage(failure);
    final isRetryable = showRetry && _isRetryable(failure);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(failure),
              size: 64,
              color: _getErrorIconColor(failure),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            if (_shouldShowSubMessage(failure))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _getSubMessage(failure),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            if (isRetryable) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
            if (_shouldShowSettingsButton(failure))
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () => _openAppSettings(null, failure),
                  child: const Text('Open Settings'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static IconData _getErrorIcon(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
      case NoInternetConnectionFailure:
        return Icons.wifi_off;
      case ConnectionTimeoutFailure:
        return Icons.timer_off;
      case UnauthorizedRequestFailure:
        return Icons.lock;
      case ValidationFailure:
      case FormValidationFailure:
        return Icons.error_outline;
      case PermissionFailure:
        return Icons.security;
      case NotFoundFailure:
        return Icons.search_off;
      case BatteryFailure:
        return Icons.battery_alert;
      case StorageDeviceFailure:
        return Icons.storage;
      case BiometricFailure:
        return Icons.fingerprint;
      default:
        return Icons.error_outline;
    }
  }

  static Color _getErrorIconColor(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return Colors.orange;
      case StorageDeviceFailure:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static bool _shouldShowSubMessage(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
      case StorageDeviceFailure:
        return true;
      default:
        return false;
    }
  }

  static String _getSubMessage(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return 'Please charge your device to continue using this feature.';
      case StorageDeviceFailure:
        return 'Free up space and try again.';
      default:
        return '';
    }
  }

  static bool _shouldShowSettingsButton(Failure failure) {
    switch (failure.runtimeType) {
      case LocationFailure:
      case CameraFailure:
      case MicrophoneFailure:
      case PermissionFailure:
        return true;
      default:
        return false;
    }
  }

  // ============================================================================
  // Helpers
  // ============================================================================

  /// Check if failure is retryable
  static bool _isRetryable(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return (failure as NetworkFailure).retryable;
      case ServerFailure:
        return (failure as ServerFailure).retryable;
      case ConnectionTimeoutFailure:
      case NoInternetConnectionFailure:
        return true;
      default:
        return false;
    }
  }

  /// Get error code for analytics
  static String? getErrorCode(Failure failure) {
    return failure.code;
  }

  /// Get error category for analytics
  static String getErrorCategory(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
      case NoInternetConnectionFailure:
      case ConnectionTimeoutFailure:
      case DnsResolutionFailure:
      case SslFailure:
      case HttpStatusFailure:
      case WebSocketFailure:
        return 'network';
      
      case JsonSerializationFailure:
      case ModelConversionFailure:
      case HiveSerializationFailure:
      case EncodingFailure:
      case DateSerializationFailure:
      case EnumSerializationFailure:
        return 'serialization';
      
      case HardwareNotAvailableFailure:
      case SensorFailure:
      case BiometricFailure:
      case CameraFailure:
      case MicrophoneFailure:
      case LocationFailure:
      case BluetoothFailure:
      case BatteryFailure:
      case StorageDeviceFailure:
      case DisplayFailure:
        return 'device';
      
      case ServerFailure:
        return 'server';
      
      case UnauthorizedAccessFailure:
      case InvalidCredentialsFailure:
      case EmailNotVerifiedFailure:
      case AccountLockedFailure:
        return 'authentication';
      
      case ValidationFailure:
      case FormValidationFailure:
        return 'validation';
      
      case PermissionFailure:
        return 'permission';
      
      case FileFailure:
      case FileNotFoundFailure:
      case FileTooLargeFailure:
        return 'file';
      
      case PaymentFailure:
      case PaymentDeclinedFailure:
      case InsufficientFundsFailure:
        return 'payment';
      
      case BusinessFailure:
      case NotFoundFailure:
      case AlreadyExistsFailure:
        return 'business';
      
      default:
        return 'unknown';
    }
  }

  // ============================================================================
  // Analytics Tracking
  // ============================================================================

  static void _trackErrorShown(Failure failure, String uiElement) {
    // Track error in analytics
    // Example: FirebaseAnalytics.instance.logEvent(
    //   name: 'error_shown',
    //   parameters: {
    //     'error_code': failure.code,
    //     'error_type': failure.runtimeType.toString(),
    //     'error_category': getErrorCategory(failure),
    //     'ui_element': uiElement,
    //   },
    // );
  }

  static void _trackErrorAction(Failure failure, String action) {
    // Track error action in analytics
    // Example: FirebaseAnalytics.instance.logEvent(
    //   name: 'error_action',
    //   parameters: {
    //     'error_code': failure.code,
    //     'action': action,
    //   },
    // );
  }
}


// Example usage
