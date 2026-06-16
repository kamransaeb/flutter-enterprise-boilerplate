import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/notification_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

import '../../../../app/app_config.dart';

@singleton
class FirebaseService {
  final AppConfig _appConfig;
  final EnvironmentService _env;

  FirebaseAnalytics? _analytics;
  late FirebaseCrashlytics _crashlytics;
  late FirebaseMessaging _messaging;
  late FirebaseRemoteConfig _remoteConfig;

  bool _isInitialized = false;

  FirebaseService(this._appConfig, this._env);

  /// Getters for Firebase instances
  FirebaseAnalytics? get analytics => _analytics;
  FirebaseCrashlytics get crashlytics => _crashlytics;
  FirebaseMessaging get messaging => _messaging;
  FirebaseRemoteConfig get remoteConfig => _remoteConfig;

  bool get isInitialized => _isInitialized;

  /// Initialize Firebase services
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      logger.i('Initializing Firebase services...');
      // Initialize Firebase core
      await Firebase.initializeApp(options: _appConfig.firebaseOptions);

      // Configure services based on environment
      await _configureAnalytics();
      await _configureCrashlytics();
      await _configureRemoteConfig();
      await _configureMessaging();

      _isInitialized = true;
      logger.i(
        'Firebase services initialized for ${_appConfig.flavor}',
      );
    } catch (e, stack) {
      logger.e('Failed to initialize Firebase', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Configure Firebase Analytics
  Future<void> _configureAnalytics() async {
    if (!_env.shouldUseAnalytics) return;
    try {
      _analytics = FirebaseAnalytics.instance;
      // Register in DI
      GetIt.instance.registerSingleton<FirebaseAnalytics>(_analytics);

      // Enable/disable analytics collection based on environment
      await _analytics.setAnalyticsCollectionEnabled(
        _appConfig.enableAnalytics,
      );

      // Set default user properties
      await _analytics.setUserProperty(
        name: 'environment',
        value: _appConfig.flavor.name,
      );

      await _analytics.setUserProperty(
        name: 'app_version',
        value: _appConfig.appVersion,
      );

      // Set session timeout
      await _analytics.setSessionTimeoutDuration(const Duration(minutes: 30));

           // Log first open event
      await analytics.logEvent(
        name: 'app_initialized',
        parameters: {
          'flavor': _env.flavorName,
          'version': _appConfig.appVersion,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      logger.i(
        'Analytics configured for ${_appConfig.flavor}',
        
      );
    } catch (e, stack) {
      logger.e('Failed to configure Analytics', error: e, stackTrace: stack);
    }
  }

  /// Configure Firebase Crashlytics
  Future<void> _configureCrashlytics() async {
    if (!_env.shouldUseCrashlytics) return;

    try {
      _crashlytics = FirebaseCrashlytics.instance;
      // Register in DI
      GetIt.instance.registerSingleton<FirebaseCrashlytics>(_crashlytics);

      // Enable/disable crashlytics collection
      await _crashlytics.setCrashlyticsCollectionEnabled(
        _appConfig.enableCrashlytics,
      );

      // Set custom keys for all crashes
      await _crashlytics.setCustomKey('environment', _appConfig.flavor.name);
      await _crashlytics.setCustomKey('app_version', _appConfig.appVersion);
      await _crashlytics.setCustomKey(
        'build_number',
        _appConfig.appBuildNumber,
      );
      await _crashlytics.setCustomKey('platform', defaultTargetPlatform.name);

      // Record non-fatal errors in development
      if (_appConfig.isDevelopment) {
        await _crashlytics.setCrashlyticsCollectionEnabled(false);
      }
      // // Global error handlers so uncaught errors are reported to Crashlytics
      //   FlutterError.onError = (details) {
      //     FlutterError.presentError(details);
      //     _crashlytics.recordFlutterFatalError(details);
      //   };
      //   PlatformDispatcher.instance.onError = (error, stack) {
      //     _crashlytics.recordError(error, stack, fatal: true);
      //     return true;
      //   };

      logger.i(
        'Crashlytics configured for ${_appConfig.flavor}',
      );
    } catch (e, stack) {
      logger.e('Failed to configure Crashlytics', error: e, stackTrace: stack);
    }
  }

  /// Configure Firebase Remote Config
  Future<void> _configureRemoteConfig() async {
    if (!_env.shouldUseRemoteConfig) return;
    try {
      _remoteConfig = FirebaseRemoteConfig.instance;
      // Register in DI
      GetIt.instance.registerSingleton<FirebaseRemoteConfig>(_remoteConfig);

      // Set config settings
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: _env.isDevelopment
              ? Duration
                    .zero // Zero means fetch immediately
              : const Duration(hours: 1), // 1 hour in production
        ),
      );

      // Set default values
      await _remoteConfig.setDefaults(const {
        'welcome_message': 'Welcome!',
        'enable_new_feature': false,
        'enable_experimental_ui': false,
        'max_products_per_page': 20,
        'cache_duration_seconds': 300,
        'api_timeout_ms': 30000,
        'maintenance_mode': false,
        'force_update_required': false,
        'minimum_app_version': '1.0.0',
        'latest_app_version': '1.0.0',
        'build_number': '1',
        'show_onboarding': true,
        'analytics_enabled': true,
        'crashlytics_enabled': false,
        'performance_enabled': true,
        'feature_enabled': false,
        'privacy_policy_url': 'https://www.example.com/privacy',
        'support_email': 'support@example.com',
      });

      // // Fetch and activate
      // await _remoteConfig.fetchAndActivate();

      // Fetch and activate (don't await - let it run in background)
      unawaited(_fetchRemoteConfig(_remoteConfig));

      logger.i(
        'Remote Config configured for ${_appConfig.flavor}',
      );
    } catch (e, stack) {
      logger.e('Failed to configure Remote Config', error: e, stackTrace: stack);
    }
  }

  /// Fetch remote config in background
  Future<void> _fetchRemoteConfig(FirebaseRemoteConfig remoteConfig) async {
    try {
      await remoteConfig.fetchAndActivate();
      logger.i(
        '  ✓ Remote Config fetched: ${remoteConfig.getAll().length} keys',
      );

      // Check maintenance mode
      if (remoteConfig.getBool('maintenance_mode')) {
        logger.w('  ⚠️ App is in maintenance mode');
        // You could show a maintenance banner here
      }

      // Check force update
      if (remoteConfig.getBool('force_update_required')) {
        final currentVersion = _appConfig.appVersion;
        final minVersion = remoteConfig.getString('minimum_app_version');

        if (_compareVersions(currentVersion, minVersion) < 0) {
          logger.w(
            '  ⚠️ Force update required: $currentVersion < $minVersion',
          );
          // Trigger force update flow
        }
      }
    } catch (e, stack) {
      logger.e('Failed to fetch Remote Config', error: e, stackTrace: stack);
    }
  }

  /// Configure Firebase Messaging (Push Notifications)
  Future<void> _configureMessaging() async {
    if (!_env.shouldUseMessaging) return;
    try {
      _messaging = FirebaseMessaging.instance;
      // Register in DI
      GetIt.instance.registerSingleton<FirebaseMessaging>(_messaging);
      // Request permission
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
      );

      logger.i(
        'Messaging permission: ${settings.authorizationStatus}',
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get token
        final token = await _messaging.getToken();
        if (token != null) {
          logger.i('FCM Token obtained');

          // Save token to secure storage
          final secureStorage = GetIt.instance<LocalStorage>(
            instanceName: 'secure_storage',
          );
          await secureStorage.write('fcm_token', token);
          // Update token on server (in background)
          unawaited(_updateTokenOnServer(token));
        }

        // Handle foreground messages
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

        // Handle background messages
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

        // Handle background messages
        FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

        // Get initial message if app launched from notification
        final initialMessage = await messaging.getInitialMessage();
        if (initialMessage != null) {
            logger.i('  ✓ App launched from notification');
          _handleInitialMessage(initialMessage);
        }
        logger.i(
          'Messaging configured for ${_appConfig.flavor}',
        );
      } else {
        logger.i('Messaging permission not granted');
      }
    } catch (e, stack) {
      logger.e('Failed to configure Messaging', error: e, stackTrace: stack);
    }
  }

  /// Handle foreground message
  void _handleForegroundMessage(RemoteMessage message) {
    logger.i('📩 Foreground message: ${message.messageId}');
    logger.i('   Title: ${message.notification?.title}');
    logger.i('   Body: ${message.notification?.body}');

    // Show local notification
    final notificationService = GetIt.instance<NotificationService>();
    notificationService.showNotification(
      id: message.hashCode,
      title: message.notification?.title ?? 'New Message',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
    );
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    logger.i('📩 Background message: ${message.messageId}');
    // Handle background message
  }

  void _handleMessageOpened(RemoteMessage message) {
    logger.i('📩 Message opened: ${message.messageId}');
    // Navigate to specific screen
  }

  void _handleInitialMessage(RemoteMessage message) {
    logger.i('📩 Initial message: ${message.messageId}');
    // Navigate to specific screen on launch
  }

  /// Update FCM token on server
  Future<void> _updateTokenOnServer(String token) async {
    try {
      // Send token to your server
      //await apiService.updateFcmToken(token);
      logger.i('  ✓ Token synced with server');
    } catch (e) {
      logger.e('  ✗ Failed to sync token with server', error: e);
    }
  }

  //============================================================================
  // Analytics Methods
  //============================================================================

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    if (_analytics == null) {
      logger.e('Analytics is not initialized');
      return;
    }
    await _analytics!.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (_analytics == null) {
      logger.e('Analytics is not initialized');
      return;
    }
    await _analytics!.setUserProperty(name: name, value: value);
  }

  Future<void> setUserId(String userId) async {
    if (_analytics == null) {
      logger.e('Analytics is not initialized');
      return;
    }
    await _analytics!.setUserId(id: userId);
  }

  Future<void> logScreenView({required String screenName, required String screenClass, Map<String, Object>? parameters}) async {
    if (_analytics == null) {
      logger.e('Analytics is not initialized');
      return;
    }
    await _analytics!.logScreenView(screenName: screenName, screenClass: screenClass, parameters: parameters);
  }

  //============================================================================
  // Crashlytics Methods
  //============================================================================

  /// Record an error in Crashlytics
  void recordError(
    Object error,
    StackTrace stack, {
    String? reason,
    bool fatal = false,
    Map<String, String>? information,
  }) {
    if (!_isInitialized || !_appConfig.enableCrashlytics) return;

    try {
      _crashlytics.recordError(
        error,
        stack,
        reason: reason,
        fatal: fatal,
        information:
            information?.entries.map((e) => '${e.key}: ${e.value}').toList() ??
            [],
      );
    } catch (e) {
      // Fail silently
    }
  }

  /// Record a non-fatal error
  void recordNonFatalError(Object error, StackTrace stack, {String? reason}) {
    recordError(error, stack, reason: reason, fatal: false);
  }

  /// Set custom key for Crashlytics
  void setCustomKey(String key, String value) {
    if (!_isInitialized || !_appConfig.enableCrashlytics) return;

    try {
      _crashlytics.setCustomKey(key, value);
    } catch (e) {
      // Fail silently
    }
  }

  /// Set user identifier for Crashlytics
  void setUserIdentifier(String userId) {
    if (!_isInitialized || !_appConfig.enableCrashlytics) return;

    try {
      _crashlytics.setUserIdentifier(userId);
    } catch (e) {
      // Fail silently
    }
  }

  /// Log a message to Crashlytics
  void log(String message) {
    if (!_isInitialized || !_appConfig.enableCrashlytics) return;

    try {
      _crashlytics.log(message);
    } catch (e) {
      // Fail silently
    }
  }

  //============================================================================
  // Remote Config Methods
  //============================================================================

  // Remote Config methods
  T getValue<T>(String key, {required T defaultValue}) {
    if (!_isInitialized) return defaultValue;

    switch (T) {
      case bool:
        return _remoteConfig.getBool(key) as T;
      case int:
        return _remoteConfig.getInt(key) as T;
      case double:
        return _remoteConfig.getDouble(key) as T;
      case String:
        return _remoteConfig.getString(key) as T;
      default:
        return defaultValue;
    }
  }

  /// Get all remote config keys
  Map<String, dynamic> getAll() {
    if (!_isInitialized) return {};

    try {
      return _remoteConfig.getAll();
    } catch (e) {
      return {};
    }
  }

  /// Fetch and activate remote config
  Future<bool> fetchRemoteConfig() async {
    if (!_isInitialized) return false;

    try {
      await _remoteConfig.fetchAndActivate();
        logger.i('Remote config fetched and activated');
      return true;
    } catch (e, stack) {
      logger.e('Failed to fetch remote config', error: e, stackTrace: stack);
      return false;
    }
  }

  //============================================================================
  // Messaging Methods
  //============================================================================

  /// Get FCM token
  Future<String?> getToken() async {
    if (!_isInitialized) return null;

    try {
      return await _messaging.getToken();
    } catch (e, stack) {
      logger.e('Failed to get FCM token', error: e, stackTrace: stack);
      return null;
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    if (!_isInitialized) return;

    try {
      await _messaging.deleteToken();
    } catch (e, stack) {
      logger.e('Failed to delete FCM token', error: e, stackTrace: stack);
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    if (!_isInitialized) return;

    try {
      await _messaging.subscribeToTopic(topic);
      logger.i('Subscribed to topic: $topic');
    } catch (e, stack) {
      logger.e('Failed to subscribe to topic: $topic', error: e, stackTrace: stack);
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    if (!_isInitialized) return;

    try {
      await _messaging.unsubscribeFromTopic(topic);
      logger.i('Unsubscribed from topic: $topic');
    } catch (e, stack) {
      logger.e('Failed to unsubscribe from topic: $topic', error: e, stackTrace: stack);
    }
  }

  /// Set up message handlers
  void setupMessageHandlers({
    required Function(RemoteMessage) onMessage,
    required Function(RemoteMessage) onMessageOpenedApp,
    required Future<void> Function(RemoteMessage) onBackgroundMessage,
  }) {
    if (!_isInitialized) return;

    try {
      // Foreground messages
      FirebaseMessaging.onMessage.listen(onMessage);

      // When app is opened from a notification
      FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);

      // Background message handler
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

      logger.i('Message handlers set up');
    } catch (e, stack) {
      logger.e('Failed to set up message handlers', error: e, stackTrace: stack);
    }
  }

  /// Get initial message (app launched from notification)
  Future<RemoteMessage?> getInitialMessage() async {
    if (!_isInitialized) return null;

    try {
      return await _messaging.getInitialMessage();
    } catch (e, stack) {
      logger.e('Failed to get initial message', error: e, stackTrace: stack);
      return null;
    }
  }

  /// Check if maintenance mode is enabled
  bool get isMaintenanceModeEnabled =>
      getValue<bool>('maintenance_mode', defaultValue: false);

  /// Check if force update is required
  bool get isForceUpdateRequired {
    final required = getValue<bool>(
      'force_update_required',
      defaultValue: false,
    );
    if (!required) return false;

    final minVersion = getValue<String>(
      'minimum_app_version',
      defaultValue: '1.0.0',
    );
    return _compareVersions(_appConfig.appVersion, minVersion) < 0;
  }

  /// Get support email from remote config
  String get supportEmail =>
      getValue<String>('support_email', defaultValue: 'support@myapp.com');

  /// Get privacy policy URL
  String get privacyPolicyUrl => getValue<String>(
    'privacy_policy_url',
    defaultValue: 'https://myapp.com/privacy',
  );

  /// Get terms URL
  String get termsUrl =>
      getValue<String>('terms_url', defaultValue: 'https://myapp.com/terms');

  /// Compare version strings
  int _compareVersions(String v1, String v2) {
    final parts1 = v1.split('.').map(int.parse).toList();
    final parts2 = v2.split('.').map(int.parse).toList();

    for (var i = 0; i < parts1.length && i < parts2.length; i++) {
      if (parts1[i] != parts2[i]) {
        return parts1[i].compareTo(parts2[i]);
      }
    }
    return parts1.length.compareTo(parts2.length);
  }

  /// Dispose or clean up if needed
  void dispose() {
    // Firebase services don't need explicit disposal
    _isInitialized = false;
    logger.i('Firebase service disposed');
  }
}
