import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
  static String toUserMessage(Failure failure) {
    // Map failure types to user messages
    switch (failure.runtimeType) {
      // Network failures
      case NetworkFailure:
        return _mapNetworkFailure(failure as NetworkFailure);

      case NoInternetConnectionFailure:
        return 'no_internet_error'.tr();

      case ConnectionTimeoutFailure:
        return 'connection_timeout_error'.tr();

      case DnsResolutionFailure:
        return 'dns_resolution_error'.tr();
      
      case SslFailure:
        return 'ssl_error'.tr();
    
      case HttpStatusFailure:
        return _mapHttpStatusFailure(failure as HttpStatusFailure);

      case RequestCancelledFailure:
        return 'request_cancelled_error'.tr();

      case ResponseParsingFailure:
        return 'response_parsing_error'.tr();

      case RateLimitExceededFailure:
        return 'rate_limit_error'.tr();      

      case WebSocketFailure:
        return 'web_socket_error'.tr();        

      // Serialization failures
      case JsonSerializationFailure:
        return _mapJsonSerializationFailure(
          failure as JsonSerializationFailure,
        );

      case ModelConversionFailure:
        return 'data_conversion_error'.tr();

      case HiveSerializationFailure:
        return 'storage_read_error'.tr();

      case EncodingFailure:
        return 'encoding_error'.tr();        

      case DateSerializationFailure:
        return 'date_format_error'.tr();        

      case EnumSerializationFailure:
        return 'invalid_value_error'.tr();        

      // Device failures
      case HardwareNotAvailableFailure:
        return _mapHardwareFailure(failure as HardwareNotAvailableFailure);

      case SensorFailure:
        return _mapSensorFailure(failure as SensorFailure);

      case BiometricFailure:
        return _mapBiometricFailure(failure as BiometricFailure);

      case CameraFailure:
        return _mapCameraFailure(failure as CameraFailure);

      case MicrophoneFailure:
        return _mapMicrophoneFailure(failure as MicrophoneFailure);

      case LocationFailure:
        return _mapLocationFailure(failure as LocationFailure);

      case BluetoothFailure:
        return _mapBluetoothFailure(failure as BluetoothFailure);

      case BatteryFailure:
        return _mapBatteryFailure(failure as BatteryFailure);

      case StorageDeviceFailure:
        return _mapStorageFailure(failure as StorageDeviceFailure);

      case DisplayFailure:
        return _mapDisplayFailure(failure as DisplayFailure);

      // Server failures
      case ServerFailure:
        return _mapServerFailure(failure as ServerFailure);

      // Authentication failures
      case UnauthorizedAccessFailure:
        return 'unauthorized_error'.tr();

      case InvalidCredentialsFailure:
        return 'invalid_credentials_error'.tr();


      case EmailNotVerifiedFailure:
        return 'email_not_verified_error'.tr();


      case AccountLockedFailure:
        final lockedFailure = failure as AccountLockedFailure;
        return 'account_locked_error'.tr(
          args: [lockedFailure.remainingTime.inMinutes.toString()],
        );

      case AccountDisabledFailure:
        return 'account_disabled_error'.tr();

      // Validation failures
      case ValidationFailure:
        return _mapValidationFailure(failure as ValidationFailure);

      case FormValidationFailure:
        return 'form_validation_error'.tr();

      // Permission failures
      case PermissionFailure:
        return _mapPermissionFailure(failure as PermissionFailure);

      // File failures
      case FileNotFoundFailure:
        return 'file_not_found_error'.tr();

      case FileTooLargeFailure:
        final fileFailure = failure as FileTooLargeFailure;
        return 'file_too_large_error'.tr(
          namedArgs: {
            'file_size': _formatSize(fileFailure.fileSize),
            'max_size': _formatSize(fileFailure.maxSize),
          },
        );

      // Payment failures
      case PaymentDeclinedFailure:
        final paymentFailure = failure as PaymentDeclinedFailure;
        return paymentFailure.declineReason != null
            ? 'Payment declined: ${paymentFailure.declineReason}'
            : 'payment_declined_error'.tr();

      case InsufficientFundsFailure:
        return 'insufficient_funds_error'.tr();

      // Business failures
      case NotFoundFailure:
        return 'resource_not_found_error'.tr();

      case AlreadyExistsFailure:
        return 'resource_already_exists_error'.tr();

      case OperationNotAllowedFailure:
        return 'operation_not_allowed_error'.tr();

      // Third-party service failures
      case FirebaseFailure:
        return 'service_unavailable_error'.tr();

      // Unknown failure
      default:
        return 'unknown_error'.tr();
    }
  }

  // ============================================================================
  // Network Message Mappers
  // ============================================================================

  static String _mapNetworkFailure(NetworkFailure failure) {
    if (failure.timeout) {
      return 'connection_timeout_error'.tr();
    }
    return 'network_error'.tr();
  }

  static String _mapHttpStatusFailure(HttpStatusFailure failure) {
    if (failure.isRateLimited) {
      return 'rate_limit_error'.tr();
    }
    if (failure.isAuthenticationError) {
      return 'unauthorized_error'.tr();
    }
    if (failure.isPermissionError) {
      return 'permission_denied_error'.tr();
    }
    if (failure.isNotFound) {
      return 'resource_not_found_error'.tr();
    }
    if (failure.isServerError) {
      return 'server_error'.tr();
    }
    return failure.message;
  }

  // ============================================================================
  // Serialization Message Mappers
  // ============================================================================

  static String _mapJsonSerializationFailure(JsonSerializationFailure failure) {
    if (failure.jsonPath != null) {
      return 'invalid_data_at_path_error'.tr(args: [failure.jsonPath!]);
    }
    return 'invalid_data_error'.tr();
  }

  // ============================================================================
  // Device Message Mappers
  // ============================================================================

  static String _mapHardwareFailure(HardwareNotAvailableFailure failure) {
    final hardware = failure.deviceFeature ?? 'hardware';
    return 'hardware_not_available_error'.tr(args: [hardware]);
  }

  static String _mapSensorFailure(SensorFailure failure) {
    if (failure.code == 'SENSOR_NOT_AVAILABLE') {
      return 'sensor_not_available_error'.tr(
        args: [failure.deviceFeature ?? 'Sensor'],
      );
    }
    if (failure.code == 'SENSOR_PERMISSION_DENIED') {
      return 'sensor_permission_error'.tr(
        args: [failure.deviceFeature ?? 'Sensor'],
      );
    }
    return failure.message;
  }

  static String _mapBiometricFailure(BiometricFailure failure) {
    switch (failure.code) {
      case 'BIOMETRIC_NOT_AVAILABLE':
        return 'biometric_not_available_error'.tr();
      case 'BIOMETRIC_NOT_ENROLLED':
        return 'biometric_not_enrolled_error'.tr();
      case 'BIOMETRIC_LOCKED_OUT':
        return 'biometric_locked_out_error'.tr();
      case 'BIOMETRIC_AUTH_FAILED':
        return 'biometric_auth_failed_error'.tr();
      default:
        return failure.message;
    }
  }

  static String _mapCameraFailure(CameraFailure failure) {
    switch (failure.code) {
      case 'CAMERA_NOT_AVAILABLE':
        return 'camera_not_available_error'.tr();
      case 'CAMERA_IN_USE':
        return 'camera_in_use_error'.tr();
      case 'CAMERA_PERMISSION_DENIED':
        return 'camera_permission_error'.tr();
      default:
        return failure.message;
    }
  }

  static String _mapMicrophoneFailure(MicrophoneFailure failure) {
    switch (failure.code) {
      case 'MICROPHONE_NOT_AVAILABLE':
        return 'microphone_not_available_error'.tr();
      case 'MICROPHONE_PERMISSION_DENIED':
        return 'microphone_permission_error'.tr();
      case 'MICROPHONE_RECORDING_FAILED':
        return 'recording_failed_error'.tr();
      default:
        return failure.message;
    }
  }

  static String _mapLocationFailure(LocationFailure failure) {
    switch (failure.code) {
      case 'LOCATION_SERVICES_DISABLED':
        return 'location_services_disabled_error'.tr();  
      case 'LOCATION_PERMISSION_DENIED':
        return 'location_permission_error'.tr();
      case 'LOCATION_PERMISSION_PERMANENTLY_DENIED':
        return 'location_permission_permanently_denied_error'.tr();
      case 'LOCATION_TIMEOUT':
        return 'location_timeout_error'.tr();
      case 'LOCATION_UNAVAILABLE':
        return 'location_unavailable_error'.tr();
      default:
        return failure.message;
    }
  }

  static String _mapBluetoothFailure(BluetoothFailure failure) {
    switch (failure.code) {
      case 'BLUETOOTH_NOT_AVAILABLE':
        return 'bluetooth_not_available_error'.tr();
      case 'BLUETOOTH_DISABLED':
        return 'bluetooth_disabled_error'.tr();
      case 'BLUETOOTH_PERMISSION_DENIED':
        return 'bluetooth_permission_error'.tr();
      case 'BLUETOOTH_CONNECTION_FAILED':
        return 'bluetooth_connection_error'.tr(
          args: [failure.deviceName ?? 'Device'],
        );
      default:
        return failure.message;
    }
  }

  static String _mapBatteryFailure(BatteryFailure failure) {
    if (failure.batteryLevel != null) {
      if (failure.batteryLevel! <= 15) {
        return 'critical_battery_error'.tr(args: [failure.batteryLevel!.toString()]);
      }
      if (failure.batteryLevel! <= 20) {
        return 'low_battery_error'.tr(args: [failure.batteryLevel!.toString()]);
      }
    }
    return failure.message;
  }

  static String _mapStorageFailure(StorageDeviceFailure failure) {
    if (failure.requiredSpace != null && failure.availableSpace != null) {
      return 'insufficient_storage_error'.tr(
        args: [
          _formatSize(failure.requiredSpace!),
          _formatSize(failure.availableSpace!),
        ],
      );
    }
    return 'storage_error'.tr();
  }

  static String _mapDisplayFailure(DisplayFailure failure) {
    return 'unsupported_display_error'.tr();
  }

  static String _mapServerFailure(ServerFailure failure) {
    if (failure.isRateLimited) {
      return 'rate_limit_error'.tr();
    }
    if (failure.isTimeout) {
      return 'timeout_error'.tr();
    }
    if (failure.isClientError) {
      return 'client_error'.tr();
    }
    if (failure.isServerError) {
      return 'server_error'.tr();
    }
    return failure.message;
  }

  static String _mapValidationFailure(ValidationFailure failure) {
    if (failure.field != null && failure.rule != null) {
      return 'field_validation_error'.tr(args: [failure.field!, failure.message]);
    }
    return failure.message;
  }

  static String _mapPermissionFailure(PermissionFailure failure) {
    if (failure.permanentlyDenied) {
      return 'permission_permanently_denied'.tr(args: [failure.permission]);
    }
    return 'permission_required'.tr(args: [failure.permission]);
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
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    VoidCallback? onDismiss,
  }) {
    final message = toUserMessage(failure);

    return SnackBar(
      content: Text(message),
      backgroundColor: _getSnackBarColor(failure),
      duration: duration,
      behavior: behavior,
      action: _getSnackBarAction(failure, onDismiss),
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
    final message = toUserMessage(failure);
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
                title ?? _getDialogTitle(failure),
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
                  style: Theme.of(
                    dialogContext,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
            if (_shouldShowActionTip(failure))
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _getActionTip(failure),
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
            child: Text('cancel'.tr()),
          ),
          if (isRetryable)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _trackErrorAction(failure, 'retry');
                onRetry?.call();
              },
              child: Text('retry'.tr()),
            ),
          if (_shouldShowSettingsAction(failure))
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _trackErrorAction(failure, 'open_settings');
                _openAppSettings(failure);
              },
              child: Text('open_settings'.tr()),
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

  static String _getDialogTitle(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return 'battery_alert_title'.tr();
      case StorageDeviceFailure:
        return 'storage_alert_title'.tr();
      case BiometricFailure:
        return 'biometric_title'.tr();
      case PermissionFailure:
        return 'permission_required_title'.tr();
      default:
        return 'error_title'.tr();
    }
  }

  static Widget _getActionTip(Failure failure) {
    final tip = _getActionTipText(failure);
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

  static String _getActionTipText(Failure failure) {
    switch (failure.runtimeType) {
      case BatteryFailure:
        return 'battery_tip'.tr();
      case StorageDeviceFailure:
        return 'storage_tip'.tr();
      case LocationFailure:
        return 'location_tip'.tr();
      case CameraFailure:
        return 'camera_tip'.tr();
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

  static Future<void> _openAppSettings(Failure failure) async {
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
              ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
            ],
            if (_shouldShowSettingsButton(failure))
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () => _openAppSettings(failure),
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
