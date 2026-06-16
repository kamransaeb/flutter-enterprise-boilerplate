import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_enterprise_boilerplate/app/app_initializer.dart';
import 'package:flutter_enterprise_boilerplate/bootstrap/performance_monitor.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../app/app.dart';
import '../app/app_config.dart';

class Bootstrap {
  Bootstrap._();

  static Future<void> initialize({
    required Flavor flavor,
    required String envPath,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize environment variables
    await dotenv.load(fileName: envPath);

    // Create app configuration from environment variables
    final appConfig = AppConfig.fromEnv(flavor);

    // Configure dependency injection FIRST
    // This ensures all services are available before app starts
    await configureInjection(appConfig);

    // Initialize logger before other services
    LoggerService.initialize();

    // AppInitializer - ACTUALLY START services after DI is configured
    await AppInitializer.initialize();

    // Initialize global error handling
    await ErrorHandler.initialize();

    // Initialize performance monitoring
    await PerformanceMonitor.initialize();

    // Lock device orientation to portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Run the app with performance monitoring wrapper
    runApp(PerformanceMonitor.wrapApp(const App()));
  }

  /// Convenience method for development with hot reload support
  @visibleForTesting
  static Future<void> initializeForTesting({
    Flavor flavor = Flavor.dev,
    String envPath = '.env.dev',
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: envPath);
    final appConfig = AppConfig.fromEnv(flavor);
    // initialize logger
    LoggerService.initialize(
       appConfig,
    );
    await configureInjection(appConfig);
    // Skip certain initializations for testing
    runApp(const App());
  }
}
