import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

@singleton
class SentryService {
  static bool _isInitialized = false;
  final EnvironmentService _env;

  SentryService(this._env);
  
  /// Initialize Sentry
  Future<void> initialize({
    required String dsn,
    required String environment,
    required String version,
  }) async {
    if (_isInitialized) return;

    try {
      await SentryFlutter.init(
        (options) {
          options
            ..dsn = dsn
            ..environment = environment
            ..release = version
            ..enableAutoPerformanceTracing = true
            ..enableAutoSessionTracking = true
            ..attachScreenshot = true
            ..attachViewHierarchy = true
            ..maxBreadcrumbs = 100
            ..tracesSampleRate = environment == 'prod' ? 0.2 : 1.0
            ..profilesSampleRate = environment == 'prod' ? 0.1 : 1.0
            ..sendDefaultPii = environment != 'prod';
            // ..addIntegration(LoadImageListIntegration());
        },
        appRunner: () {
          // App will be run separately
        },
      );
      
      _isInitialized = true;
    } catch (e, stack) {
      logger.e('[Sentry] Failed to initialize Sentry', error: e, stackTrace: stack);
    }
  }

  /// Capture an exception
  Future<void> captureException(
    dynamic exception, {
    dynamic hint,
    StackTrace? stackTrace,
    Map<String, dynamic>? extra,
  }) async {
    if (!_env.shouldUseSentry || !_isInitialized) return;

    try {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        hint: hint != null ? Hint.withMap({'hint': hint}) : null,
        withScope: (scope) {
          if (extra != null) {
            extra.forEach((key, value) {
              scope.setExtra(key, value);
            });
          }
        },
      );
    } catch (e) {
      logger.e('[Sentry] Failed to capture exception', error: e);
    }
  }

  /// Capture a message
  Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
    Map<String, dynamic>? extra,
  }) async {
    if (!_env.shouldUseSentry || !_isInitialized) return;

    try {
      await Sentry.captureMessage(
        message,
        level: level,
        withScope: (scope) {
          if (extra != null) {
            extra.forEach((key, value) {
              scope.setExtra(key, value);
            });
          }
        },
      );
    } catch (e) {
      logger.e('[Sentry] Failed to capture message', error: e);
    }
  }

  /// Set user information
  void setUser({
    required String id,
    String? email,
    String? username,
    Map<String, dynamic>? extra,
  }) {
    if (!_env.shouldUseSentry || !_isInitialized) return;

    try {
      Sentry.configureScope((scope) {
        scope.setUser(SentryUser(
          id: id,
          email: email,
          username: username,
          extras: extra,
        ));
      });
    } catch (e) {
      logger.e('[Sentry] Failed to set user', error: e);
    }
  }

  /// Clear user information
  void clearUser() {
    if (!_env.shouldUseSentry || !_isInitialized) return;
    try {
      Sentry.configureScope((scope) {
        scope.setUser(null);
      });
    } catch (e) {
      logger.e('[Sentry] Failed to clear user', error: e);
    }
  }

  /// Add a breadcrumb
  void addBreadcrumb({
    required String message,
    String? category,
    Map<String, dynamic>? data,
    SentryLevel level = SentryLevel.info,
  }) {
    if (!_env.shouldUseSentry || !_isInitialized) return;
    try {
      Sentry.addBreadcrumb(Breadcrumb(
        message: message,
        category: category,
        data: data,
        level: level,
      ));
    } catch (e) {
      logger.e('[Sentry] Failed to add breadcrumb', error: e);
    }
  }

  /// Set tag
  void setTag(String key, String value) {
    if (!_env.shouldUseSentry || !_isInitialized) return;
    try {
      Sentry.configureScope((scope) {
        scope.setTag(key, value);
      });
    } catch (e) {
      logger.e('[Sentry] Failed to set tag', error: e);
    }
  }

  /// Set extra data
  void setExtra(String key, dynamic value) {
    if (!_env.shouldUseSentry || !_isInitialized) return;
    try {
      Sentry.configureScope((scope) {
        scope.setExtra(key, value);
      });
    } catch (e) {
      logger.e('[Sentry] Failed to set extra', error: e);
    }
  }

  /// Start a transaction for performance monitoring
  ISentrySpan? startTransaction({
    required String name,
    required String operation,
    String? description,
    Map<String, dynamic>? extra,
  }) {
    if (!_env.shouldUseSentry || !_isInitialized) return null;

    try {
      final transaction = Sentry.startTransaction(
        name,
        operation,
        description: description,
      );

      if (extra != null) {
        extra.forEach((key, value) {
          transaction.setData(key, value);
        });
      }

      return transaction;
    } catch (e) {
      logger.e('[Sentry] Failed to start transaction', error: e);
      return null;
    }
  }
}
