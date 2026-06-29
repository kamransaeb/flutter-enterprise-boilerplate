import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/app/app_bloc_observer.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/app_router.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/connectivity_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/deep_link_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/firebase/firebase_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/notification_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/sentry_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

/// What must run after the injectablegraph exists (configureInjection)
/// Responsible for ACTUALLY initializing services at runtime
/// This performs the real work after DI has registered the classes
/// Role: Imperative startup: async work, ordering, logging, feature flags from 
/// disk, Firebase init, storage checks, Sentry init, bloc observer,
/// first-launch loginc, etc.
@singleton
class AppInitializer {
  static LoggerService get _logger => getIt<LoggerService>();
  static late final AppConfig _appConfig;
  static late final EnvironmentService _env;
  static late final LocalStorage _localStorage;
  //static late final LoggerService _logger;
  
  static Future<void> initialize() async {
    final stopwatch = Stopwatch()..start();

    try {
      // Get config from DI (already registered by @module)
      _appConfig = getIt<AppConfig>();
      _env = getIt<EnvironmentService>();
      _localStorage = getIt<LocalStorage>(instanceName: 'shared_prefs');
      // _logger = getIt<LoggerService>();

      _logger.i('🚀 Starting app initialization for ${_appConfig.flavor}');
      // Print configuration in development
      if (_env.shouldLogVerbose) {
        _env.printConfig();
      }

      // Initialize services in order of dependency
      await _initializePackageInfo();
      await _initializeDeviceInfo();
      await _initializeConnectivity();
      await _initializeFirebaseServices();
      // TODO: Implement deep linking
      // await _initializeDeepLinkingService(); 
      await _initializeNotificationService();
      await _initializeSentryService();
      await _initializeNotificationChannels();
      await _initializeBlocObserver();
      await _initializeStorage();
      await _warmUpCaches();

       // Check for first launch
      final isFirstLaunch = await _checkFirstLaunch();
      if (isFirstLaunch) {
        _logger.i('First launch detected');
        await _handleFirstLaunch();
      }

      final elapsed = stopwatch.elapsedMilliseconds;

      _logger.i('✅ App initialization completed in ${elapsed}ms');

      // Track initialization event
      if (_env.shouldUseAnalytics) {
        unawaited(_trackInitializationEvent(elapsed));
      }
    } catch (e, stack) {
      _logger.e('❌ App initialization failed', error: e, stackTrace: stack);

      // Report to crash reporting services if available
      if (_env.shouldUseCrashlytics) {
        await FirebaseCrashlytics.instance.recordError(e, stack);
      }
      if (_env.shouldUseSentry) {
        await getIt<SentryService>().captureException(
          e,
          stackTrace: stack,
        );
      }

      // In production, we might want to show a friendly error screen
      // In development, we want to see the error
      if (_env.isProduction) {
        // Optionally show a graceful error UI
      } else {
        rethrow;
      }
    } finally {
      stopwatch.stop();
    }
  }

  static Future<bool> _checkFirstLaunch() async {
    const key = 'has_launched_before';
    final hasLaunchedBefore = await _localStorage.read<bool>(key) ?? false;
    
    if (!hasLaunchedBefore) {
      await _localStorage.write(key, true);
      return true;
    }
    
    return false;
  }

  static Future<void> _handleFirstLaunch() async { 
    // Log first launch event
          final firebaseService = getIt<FirebaseService>();

    if (firebaseService.isInitialized) {
      await firebaseService.logEvent(name: 'first_launch', parameters: {
        'app_version': _appConfig.appVersion,
        'platform': 'mobile',
      });
    }
  }

  /// Track initialization event
  static Future<void> _trackInitializationEvent(int elapsedMs) async {
    try {
      final analytics = getIt<FirebaseAnalytics>();
      await analytics.logEvent(
        name: 'app_initialization_complete',
        parameters: {
          'duration_ms': elapsedMs,
          'flavor': _env.flavorName,
          'version': _appConfig.appVersion,
        },
      );
    } catch (e) {
      // Silently fail - analytics should not crash
    }
  }

  /// Initialize package information
  static Future<void> _initializePackageInfo() async {
    _logger.i('📦 Initializing package info...');
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      getIt.registerSingleton<PackageInfo>(packageInfo);
      _logger.i('  ✓ App: ${packageInfo.appName} v${packageInfo.version}');
    } catch (e, stack) {
      _logger.e('  ✗ Package info failed', error: e, stackTrace: stack);
    }
  }
  
  /// Initialize device information
  static Future<void> _initializeDeviceInfo() async {
    _logger.i('📱 Initializing device info...');
    try {
      final deviceInfo = DeviceInfoPlugin();
      getIt.registerSingleton<DeviceInfoPlugin>(deviceInfo);

      if (kIsWeb) {
        final webInfo = await deviceInfo.webBrowserInfo;
        _logger.i('  ✓ Browser: ${webInfo.browserName}');
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        _logger.i(
          '  ✓ Device: ${androidInfo.model} (Android ${androidInfo.version.release})',
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        _logger.i(
          '  ✓ Device: ${iosInfo.utsname.machine} (iOS ${iosInfo.systemVersion})',
        );
      }
    } catch (e, stack) {
      _logger.e('  ✗ Device info failed', error: e, stackTrace: stack);
    }
  }

  /// Initialize bloc observer
  static Future<void> _initializeBlocObserver() async {
    _logger.i('🔥 Initializing bloc observer...');
    try {
      Bloc.observer = getIt<AppBlocObserver>();
      _logger.i('  ✓ Bloc observer initialized');
    } catch (e, stack) {
      _logger.e('  ✗ Bloc observer initialization failed', error: e, stackTrace: stack);
    }
  }

  /// Initialize connectivity monitoring
  static Future<void> _initializeConnectivity() async {
    try {
      final connectivityService = getIt<ConnectivityService>();
      await connectivityService.initialize();
    } catch (e, stack) {
      _logger.e('  ✗ Connectivity failed', error: e, stackTrace: stack);
    }
  }

  /// Initialize storage is working
  static Future<void> _initializeStorage() async {
    _logger.i('💾 Validating storage...');
    try {
      // Get all storage implementations
      final sharedPrefs = getIt<LocalStorage>(
        instanceName: 'shared_prefs',
      );
      final secureStorage = getIt<LocalStorage>(
        instanceName: 'secure_storage',
      );
      final hiveStorage = getIt<LocalStorage>(
        instanceName: 'hive_storage',
      );

      // Ensure they're initialized
      await Future.wait([
        sharedPrefs.initialize(),
        secureStorage.initialize(),
        hiveStorage.initialize(),
      ]);

      // Test writes
      await sharedPrefs.write('_init_test', true);
      await secureStorage.write('_init_test', 'secure_test');
      await hiveStorage.write('_init_test', true);

      _logger.i('  ✓ All storage systems operational');
    } catch (e, stack) {
      _logger.e('  ✗ Storage validation failed', error: e, stackTrace: stack);
      if (_env.isProduction) {
        // In production, storage failure might be critical
        throw Exception('Storage initialization failed: $e');
      }
    }
  }

  /// Delegate all Firebase init to FirebaseService (single owner).
  static Future<void> _initializeFirebaseServices() async {
    if (!_env.shouldUseFirebase) {
      _logger.i('🔥 Firebase skipped (not enabled for ${_env.flavorName})');
      return;
    }
    await getIt<FirebaseService>().initialize();
  }

  // /// Initialize Sentry
  // static Future<void> _initializeSentry() async {
  //   if (!_env.shouldUseSentry) return;

  //   LoggerService.log.i('📡 Initializing Sentry...');

  //   try {
  //     final sentryService = GetIt.instance<SentryService>();
  //     await sentryService.initialize(
  //       dsn: _appConfig.sentryDsn!,
  //       environment: _env.flavorName,
  //       version: _appConfig.appVersion,
  //     );

  //     // Set user if available (will be updated later when user logs in)
  //     // sentryService.setUser(id: 'anonymous');

  //     // Set tags
  //     sentryService.setTag('platform', defaultTargetPlatform.name);
  //     sentryService.setTag('flavor', _env.flavorName);

  //     LoggerService.log.i('  ✓ Sentry ready');
  //   } catch (e, stack) {
  //     Logger.error('  ✗ Sentry initialization failed', e, stack);
  //   }
  // }

  /// Initialize Sentry
  static Future<void> _initializeSentryService() async {
    if (!_env.shouldUseSentry) return;

    _logger.i('📡 Initializing Sentry...');

    try {
      await getIt<SentryService>().initialize(
        dsn: _appConfig.sentryDsn!,
        environment: _env.flavor.name,
        version: _appConfig.appVersion,
      );

      _logger.i('  ✓ Sentry ready');
    } catch (e, stack) {
      _logger.e('  ✗ Sentry initialization failed', error: e, stackTrace: stack);
    }
  }

  // /// Initialize Deep Linking
  // static Future<void> _initializeDeepLinkService() async {
  //   LoggerService.log.i('🔗 Initializing Deep Link Service...');

  //   try {
  //     final deepLinkService = GetIt.instance<DeepLinkService>();
  //     await deepLinkService.initialize();
  //     LoggerService.log.i('  ✓ Deep linking ready');
  //   } catch (e, stack) {
  //     Logger.error('  ✗ Deep linking failed', e, stack);
  //   }
  // }

  /// Initialize Notification Service (local notifications)
  static Future<void> _initializeNotificationService() async {
    _logger.i('🔔 Initializing Notification Service...');
    try {
      final notificationService = getIt<NotificationService>();
      await notificationService.initialize();

      // Listen to notification taps
      notificationService.onNotificationTap.listen((data) {
        _logger.i('  📨 Notification tapped: $data');
        // Handle navigation based on notification data
        _handleNotificationNavigation(data);
      });

      _logger.i('  ✓ Notification service ready');
    } catch (e, stack) {
      _logger.e('  ✗ Notification service failed', error: e, stackTrace: stack);
    }
  }

  /// Handle notification navigation
  static void _handleNotificationNavigation(Map<String, dynamic> data) {
    try {
      // Get navigation service and navigate based on data
      final route = data['route'];
      if (route != null) {
        // Navigate to route
        _logger.i('  Navigating to: $route');
        // navigationService.push(route);
      }
    } catch (e) {
      _logger.e('Failed to handle notification navigation', error: e);
    }
  }

  /// Initialize notification channels (Android)
  static Future<void> _initializeNotificationChannels() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    _logger.i('🔔 Initializing Notification Channels...');

    try {
      // This is handled by NotificationService.initialize()
      // Just verify it's working
      _logger.i('  ✓ Notification channels ready');
    } catch (e, stack) {
      _logger.e('  ✗ Notification channels failed', error: e, stackTrace: stack);
    }
  }

  /// Warm up caches
  static Future<void> _warmUpCaches() async {
    _logger.i('🔥 Warming up caches...');

    try {
      final cacheBox = await getIt<Future<Box>>(
        instanceName: 'cache_box',
      );
      // Pre-load common data
      // await GetIt.instance<ProductsRepository>().getCachedProducts();
      // await GetIt.instance<SettingsRepository>().getSettings();
      _logger.i('  ✓ Cache warmed up');
    } catch (e, stack) {
      _logger.e('  ✗ Cache warm-up failed', error: e, stackTrace: stack);
    }
  }
  
  /// Dispose
  // static Future<void> dispose() async {
  //   _logger.i('Disposing app initializer');
  //   await getIt<SentryService>().close();
  //   await getIt<FirebaseService>().close();
  // }
}

/// Extension for platform checks
extension on TargetPlatform {
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;
}
