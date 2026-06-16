import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// App logger (package:logger). Call [AppLogger.initialize] from bootstrap.
/// Singleton: only one instance is created; re-initialization is a no-op.
@singleton
class LoggerService {
  static Logger? _instance;
  static bool _initialized = false;
  static late final AppConfig _appConfig;

  /// The shared logger instance. Throws if [initialize] has not been called.
  static Logger get logger {
    if (!_initialized || _instance == null) {
      throw StateError(
        'AppLogger not initialized. Call AppLogger.initialize(appConfig) from bootstrap.',
      );
    }
    return _instance!;
  }

  /// Initialize the logger once. Subsequent calls are ignored (singleton guard).
  static void initialize([AppConfig? appConfig]) {
    if (_initialized) return;

    _appConfig = appConfig ?? GetIt.instance<AppConfig>();

    _instance = Logger(
      filter: FlavorLogFilter(
        enableLogging: _appConfig.enableLogging,
        minLevel: _levelForFlavor(_appConfig.flavor),
      ),
      level: Level.trace,
      printer: PrettyPrinter(),
    );
    _initialized = true;
  }

  /// Whether the logger has been initialized (e.g. for tests).
  static bool get isInitialized => _initialized;
}

class FlavorLogFilter extends LogFilter {
  FlavorLogFilter({
    required this.enableLogging,
    required this.minLevel,
  });

  final bool enableLogging;
  final Level minLevel;

  @override
  bool shouldLog(LogEvent event) {
    if (!enableLogging) return false;
    return event.level.index >= minLevel.index;
  }
}

// Each environment sets a minimum level, and anything below it is ignored.
// trace < debug < info < warning < error < fatal < off
Level _levelForFlavor(Flavor flavor) {
  return switch (flavor) {
    Flavor.dev => Level.trace,
    Flavor.staging => Level.info,
    Flavor.prod => Level.warning,
  };
}

/// Top-level getter so call sites can use [logger] instead of [LoggerService.logger].
Logger get logger => LoggerService.logger;
