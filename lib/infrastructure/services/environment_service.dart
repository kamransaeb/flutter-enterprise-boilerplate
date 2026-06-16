import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../app/app_config.dart';
import 'package:injectable/injectable.dart';

/// *** AppConfig: static facts from env + flavor loaded at startup.
/// *** EnvironmentService: runtime decisions derived from those facts.
/// *** This separation allows for better organization and maintainability.
/// *** Service that provides environment-specific behavior and business logic
/// *** This encapsulates all config-dependent logic used throughout the app
/// *** EnvironmentService is an Injectable singleton that depends on AppConfig
@singleton
class EnvironmentService {
  final AppConfig _appConfig;

  // Runtime feature flags that can be updated from remote config
  final Map<String, bool> _runtimeFeatureFlags = {};

  // Runtime configuration overrides
  final Map<String, dynamic> _runtimeConfig = {};

  EnvironmentService(this._appConfig);

  //============================================================================
  // Basic Environment Getters (Delegating to AppConfig)
  //============================================================================

  Flavor get flavor => _appConfig.flavor;
  String get flavorName => _appConfig.flavor.name;
  bool get isDevelopment => _appConfig.isDev;
  bool get isStaging => _appConfig.isStaging;
  bool get isProduction => _appConfig.isProd;

  String get appName => _appConfig.appName;
  String get appVersion => _appConfig.appVersion;
  String get apiBaseUrl => _appConfig.apiBaseUrl;
  int get appBuildNumber => _appConfig.appBuildNumber;
  // int get apiTimeout => _appConfig.apiTimeout;
  //Duration get apiTimeout => Duration(milliseconds: _appConfig.apiTimeout);
  int get apiConnectTimeout => _appConfig.apiConnectTimeout;
  int get apiReceiveTimeout => _appConfig.apiReceiveTimeout;
  int get apiSendTimeout => _appConfig.apiSendTimeout;

  bool get enableLogging => _appConfig.enableLogging;
  bool get enableAnalytics => _appConfig.enableAnalytics;
  bool get enableCrashlytics => _appConfig.enableCrashlytics;
  
  String get sentryDsn => _appConfig.sentryDsn;

  //============================================================================
  // Enhanced Environment Decisions (Business Logic)
  //============================================================================
  
  /// Should we use Firebase services?
  bool get shouldUseFirebase {
     // Firebase is only used in staging and production
    return !isDevelopment;
  }

  /// Should we use Remote Config?
  bool get shouldUseRemoteConfig {
    // Remote config is useful in all environments, but behaves differently
    return true;
  }

  /// Should we use Crashlytics?
  bool get shouldUseCrashlytics {
    // Only report crashes in staging/production, but still initialize in dev
    return enableCrashlytics && !isDevelopment;
  }

   /// Should we use Analytics?
  bool get shouldUseAnalytics {
    // Only track analytics in production
    return enableAnalytics && isProduction;
  }

  /// Should we use Sentry?
  bool get shouldUseSentry {
    return sentryDsn.isNotEmpty && !isDevelopment;
  }

  /// Should we use verbose logging?
  bool get shouldLogVerbose {
    return enableLogging && !isProduction;
  }

    /// Should we clear cache on startup?
  bool get shouldClearCacheOnStartup {
    return isDevelopment; // Clear cache in dev for fresh state
  }

  /// Should we show debug menus?
  bool get shouldShowDebugMenu {
    return !isProduction;
  }

  /// Should we mock API responses?
  bool get shouldMockApi {
    return isDevelopment; // Mock APIs in development
  }

  /// Should we use test payment gateways?
  bool get shouldUseTestPayment {
    return !isProduction; // Use test payments in dev/staging
  }

  /// Should we use Push Messaging?
  bool get shouldUseMessaging {
     return !isDevelopment;
  }

  //============================================================================
  // Configuration Values
  //============================================================================
  FirebaseOptions? get firebaseOptions => _appConfig.firebaseOptions;

 //============================================================================
  // API Helpers (URL Construction, Headers)
  //============================================================================

  /// Get full API URL for an endpoint (with environment-specific prefixes)
  String getApiUrl(String endpoint) {
    final cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    
    // In development, we might use a test prefix
    if (isDevelopment) {
      return '$apiBaseUrl/test$cleanEndpoint';
    }
    
    // In staging, we might use a staging prefix
    if (isStaging) {
      return '$apiBaseUrl/staging$cleanEndpoint';
    }
    
    return '$apiBaseUrl$cleanEndpoint';
  }

  /// Get environment-specific headers for API requests
  Map<String, String> get defaultHeaders {
    final headers = <String, String>{
      'X-App-Version': appVersion,
      'X-Environment': flavorName,
      'X-Platform': defaultTargetPlatform.toString(),
      'X-App-Name': appName,
    };
    
    // Add development-specific headers
    if (isDevelopment) {
      headers['X-Dev-Mode'] = 'true';
      headers['X-Dev-Token'] = 'dev-token-123';
    }

    // Add staging-specific headers
    if (isStaging) {
      headers['X-Staging-Mode'] = 'true';
    }

    return headers;
  }

  //============================================================================
  // Feature Flag System (with Remote Config Integration)
  //============================================================================

  /// Check if a feature is enabled (combines static + runtime flags)
  bool isFeatureEnabled(String featureName) {
    // First check runtime overrides
    if (_runtimeFeatureFlags.containsKey(featureName)) {
      return _runtimeFeatureFlags[featureName]!;
    }

     // Then check environment-based defaults
    switch (featureName) {
      // Features enabled only in development
      case 'debug_menu':
      case 'network_logger':
      case 'performance_monitor':
      case 'slow_animations':
        return isDevelopment;

      // Features enabled in dev and staging
      case 'experimental_ui':
      case 'new_checkout_flow':
      case 'beta_features':
      case 'analytics_debug':
        return !isProduction;

     // Features enabled in all environments
      case 'dark_mode':
      case 'push_notifications':
      case 'in_app_purchases':
      case 'social_sharing':
        return true;

      // Features enabled only in production
      case 'production_only_analytics':
      case 'production_experiment':
        return isProduction;

      // Default to false for unknown features
      default:
        return false;
    }
  }

  /// Override a feature flag at runtime (from remote config or user settings)
  void setFeatureFlag(String featureName, bool enabled) {
    _runtimeFeatureFlags[featureName] = enabled;
  }

   /// Reset all runtime feature flags
  void resetFeatureFlags() {
    _runtimeFeatureFlags.clear();
  }

  /// Update feature flags from remote config
  void updateFeatureFlagsFromRemoteConfig(Map<String, bool> remoteFlags) {
    _runtimeFeatureFlags.addAll(remoteFlags);
  }
 
  //============================================================================
  // Runtime Configuration (Values that can change at runtime)
  //============================================================================

  /// Get a runtime configuration value
  T? getConfig<T>(String key, {T? defaultValue}) {
    if (_runtimeConfig.containsKey(key)) {
      return _runtimeConfig[key] as T;
    }
    return defaultValue;
  }

  /// Set a runtime configuration value
  void setConfig(String key, dynamic value) {
    _runtimeConfig[key] = value;
  }

  /// Update multiple runtime config values at once
  void updateConfig(Map<String, dynamic> config) {
    _runtimeConfig.addAll(config);
  }

  //============================================================================
  // Cache and Storage Helpers
  //============================================================================

  /// Get cache duration based on environment and data type
  Duration getCacheDuration(String dataType, {Duration? custom}) {
    // Development: very short cache
    if (isDevelopment) {
      return custom ?? const Duration(seconds: 30);
    }
    
    // Staging: medium cache
    if (isStaging) {
      return custom ?? const Duration(minutes: 5);
    }
    
    // Production: different strategies per data type
    switch (dataType) {
      case 'products':
        return const Duration(hours: 1);
      case 'user_profile':
        return const Duration(minutes: 5);
      case 'settings':
        return const Duration(hours: 24);
      case 'notifications':
        return const Duration(minutes: 2);
      default:
        return custom ?? const Duration(minutes: 30);
    }
  }

  /// Get cache key prefix for environment (to avoid collisions)
  String getCacheKeyPrefix(String key) {
    return '${flavorName}_$key';
  }

  //============================================================================
  // Notification Helpers
  //============================================================================

  /// Get notification channel ID based on environment
  String getNotificationChannelId(String baseChannelId) {
    if (isDevelopment) return '${baseChannelId}_dev';
    if (isStaging) return '${baseChannelId}_staging';
    return baseChannelId;
  }

  /// Get notification topic based on environment
  String getNotificationTopic(String baseTopic) {
    if (isDevelopment) return '/topics/${baseTopic}_dev';
    if (isStaging) return '/topics/${baseTopic}_staging';
    return '/topics/$baseTopic';
  }

  // // Error reporting helper
  // bool get shouldReportErrors => _appConfig.enableCrashlytics;


  // //============================================================================
  // // Logging Helpers
  // //============================================================================

  // /// Log a message (only in appropriate environments)
  // void log(String message, {String? tag, Object? error, StackTrace? stack}) {
  //   if (!shouldLogVerbose) return;
    
  //   final prefix = tag != null ? '[$tag]' : '';
  //   final timestamp = DateTime.now().toIso8601String();
    
  //   if (error != null) {
  //     debugPrint('📝 $timestamp $prefix $message');
  //     debugPrint('   Error: $error');
  //     if (stack != null && isDevelopment) {
  //       debugPrint('   Stack: $stack');
  //     }
  //   } else {
  //     debugPrint('📝 $timestamp $prefix $message');
  //   }
  // }

  // /// Log an error (always in dev, conditionally in prod)
  // void logError(String message, [Object? error, StackTrace? stack]) {
  //   // Always log errors in development
  //   if (isDevelopment) {
  //     debugPrint('❌ $message');
  //     if (error != null) debugPrint('   Error: $error');
  //     if (stack != null) debugPrint('   Stack: $stack');
  //   } 
  //   // In production, errors go to crash reporting instead of console
  //   else if (shouldUseCrashlytics) {
  //     // GetIt.instance<FirebaseService>().crashlytics.recordError(
  //     //   error ?? message,
  //     //   stack,
  //     //   reason: message,
  //     // );
  //     // Report to crash reporting services


  //   }
  // }

  // /// Log a warning
  // void logWarning(String message, {Object? error}) {
  //   if (!enableLogging) return;
  //   debugPrint('⚠️ $message');
  //   if (error != null && isDevelopment) {
  //     debugPrint('   Error: $error');
  //   }
  // }


  //  //============================================================================
  // // Analytics Helpers
  // //============================================================================

  // /// Log an analytics event (only if analytics is enabled)
  // Future<void> trackEvent(String eventName, {Map<String, Object?>? parameters}) async {
  //   if (!shouldUseAnalytics) return;
    
  //   try {
  //     await FirebaseAnalytics.instance.logEvent(
  //       name: eventName,
  //       parameters: parameters,
  //     );
  //   } catch (e, stack) {
  //     logError('Failed to track event: $eventName', e, stack);
  //   }
  // }
  // /// Set user properties in analytics
  // Future<void> setUserProperty(String name, String value) async {
  //   if (!shouldUseAnalytics) return;
    
  //   try {
  //     await FirebaseAnalytics.instance.setUserProperty(
  //       name: name,
  //       value: value,
  //     );
  //   } catch (e, stack) {
  //     logError('Failed to set user property: $name', e, stack);
  //   }
  // }


  //  //============================================================================
  // // Crash Reporting Helpers
  // //============================================================================

  // /// Set custom crash reporting keys
  // void setCrashReportingKey(String key, String value) {
  //   if (!shouldUseCrashlytics) return;
    
  //   try {
  //     FirebaseCrashlytics.instance.setCustomKey(key, value);
  //   } catch (e, stack) {
  //     logError('Failed to set crash reporting key: $key', e, stack);
  //   }
  // }

  // /// Set user identifier in crash reports
  // void setUserId(String? userId) {
  //   if (!shouldUseCrashlytics) return;
    
  //   try {
  //     if (userId != null) {
  //       FirebaseCrashlytics.instance.setUserIdentifier(userId);
  //     }
  //   } catch (e, stack) {
  //     logError('Failed to set user ID', e, stack);
  //   }
  // }

  //============================================================================
  // Remote Config Helpers (for feature flags from server)
  //============================================================================

  /// Get a feature flag value from remote config with local fallback
  bool getRemoteFeatureFlag(String key, {bool defaultValue = false}) {
    // This would integrate with Firebase Remote Config
    // For now, just return local feature flag
    return isFeatureEnabled(key);
  }


//============================================================================
  // Debug & Diagnostics
  //============================================================================

  /// Print all configuration (for debugging)
  void printConfig() {
    if (!shouldLogVerbose) return;
    
    debugPrint('══════════════════════════════════════════');
    debugPrint('🔧 ENVIRONMENT CONFIGURATION');
    debugPrint('══════════════════════════════════════════');
    debugPrint('Flavor: $flavorName');
    debugPrint('App Name: $appName');
    debugPrint('Version: $appVersion');
    debugPrint('App Build Number: $appBuildNumber');
    debugPrint('API Base URL: $apiBaseUrl');
    debugPrint('API Connect Timeout: $apiConnectTimeout');
    debugPrint('API Receive Timeout: $apiReceiveTimeout');
    debugPrint('API Send Timeout: $apiSendTimeout');
    debugPrint('Logging Enabled: $enableLogging');
    debugPrint('Analytics Enabled: $enableAnalytics');
    debugPrint('Crashlytics Enabled: $enableCrashlytics');
    debugPrint('Sentry DSN: ${sentryDsn ?? 'Not configured'}');
    debugPrint('══════════════════════════════════════════');
    
    // Log feature flags
    debugPrint('\n📱 FEATURE FLAGS:');
    _logFeatureFlag('debug_menu');
    _logFeatureFlag('experimental_ui');
    _logFeatureFlag('new_checkout_flow');
    _logFeatureFlag('dark_mode');
    _logFeatureFlag('beta_features');
    debugPrint('══════════════════════════════════════════');
  }

  void _logFeatureFlag(String flag) {
    debugPrint('  $flag: ${isFeatureEnabled(flag)}');
  }
}
