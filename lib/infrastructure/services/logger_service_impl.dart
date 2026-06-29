import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart' as log;

@Singleton(as: LoggerService)
class LoggerServiceImpl implements LoggerService {
  LoggerServiceImpl(AppConfig appConfig)
      : _logger = log.Logger(
          filter: FlavorLogFilter(
            enableLogging: appConfig.enableLogging,
            minLevel: _levelForFlavor(appConfig.flavor),
          ),
          level: log.Level.trace,
          printer: log.PrettyPrinter(),
        );

  final log.Logger _logger;

  @override
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.t(message, time: time, error: error, stackTrace: stackTrace);

  @override
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.d(message, time: time, error: error, stackTrace: stackTrace);

  @override
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.i(message, time: time, error: error, stackTrace: stackTrace);

  @override
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.w(message, time: time, error: error, stackTrace: stackTrace);

  @override
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logger.e(message, time: time, error: error, stackTrace: stackTrace);
}

class FlavorLogFilter extends log.LogFilter {
  FlavorLogFilter({
    required this.enableLogging,
    required this.minLevel,
  });

  final bool enableLogging;
  final log.Level minLevel;

  @override
  bool shouldLog(log.LogEvent event) {
    if (!enableLogging) return false;
    return event.level.index >= minLevel.index;
  }
}

// trace < debug < info < warning < error < fatal < off
log.Level _levelForFlavor(Flavor flavor) {
  return switch (flavor) {
    Flavor.dev => log.Level.trace,
    Flavor.staging => log.Level.info,
    Flavor.prod => log.Level.warning,
  };
}
