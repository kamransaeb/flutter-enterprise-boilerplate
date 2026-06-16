import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class PerformanceMonitor {
  static late AppConfig _appConfig;

  static Future<void> initialize() async {
    _appConfig = getIt<AppConfig>();
  }

  static Widget wrapApp(Widget app) {
    if (_appConfig.enableCrashlytics) {
      return SentryWidget(
        child: app,
      );
    }
    return app;
  }

 
  static ISentrySpan? startTransaction(
  String name, {
  String? operation,
}) {
  if (_appConfig.enableCrashlytics) {
    return Sentry.startTransaction(
      name,
      operation ?? 'custom',
    );
  }
  return null;
}

  static Future<T> monitor<T>(
    String name,
    Future<T> Function() callback, {
    String? operation,
  }) async {
    final transaction = startTransaction(name, operation: operation);
    try {
      final result = await callback();
      transaction?.finish(status: const SpanStatus.ok());
      return result;
    } catch (e) {
      transaction?.finish(status: const SpanStatus.internalError());
      rethrow;
    }
  }

  static void markTime(String name) {
    if (_appConfig.enableLogging) {
      debugPrint('Performance: $name at ${DateTime.now()}');
    }
  }
}