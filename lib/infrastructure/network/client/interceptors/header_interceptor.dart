import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Interceptor for adding default headers to all requests
@lazySingleton
class HeaderInterceptor extends Interceptor {
  final AppConfig _appConfig;
  final DeviceInfoPlugin _deviceInfoPlugin;
  PackageInfo? _packageInfo;
  String? _deviceId;
  String? _deviceModel;
  String? _osVersion;

  HeaderInterceptor(this._appConfig, this._deviceInfoPlugin) {
    _initPackageInfo();
    _initDeviceInfo();
  }

  Future<void> _initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _packageInfo = packageInfo;
  }

  Future<void> _initDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        _deviceId = androidInfo.id;
        _deviceModel = androidInfo.model;
        _osVersion = androidInfo.version.release;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        _deviceId = iosInfo.utsname.machine;
        _deviceModel = iosInfo.model;
        _osVersion = iosInfo.systemVersion;
      } else if (kIsWeb) {
        _deviceId = 'web_${DateTime.now().millisecondsSinceEpoch}';
        _deviceModel = 'Web';
        _osVersion = 'Web';
      }
    } catch (e) {
      logger.e('Failed to initialize device info: $e');
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add default headers
    options.headers['Content-Type'] =
        options.headers['Content-Type'] ?? 'application/json';
    options.headers['Accept'] = 'application/json';

    // Add app version headers
    if (_packageInfo != null) {
      options.headers['App-Version'] = _packageInfo!.version;
      options.headers['Build-Number'] = _packageInfo!.buildNumber;
      options.headers['App-Name'] = _packageInfo!.appName;
    }

// Add platform headers
if (Platform.isAndroid) {
  options.headers['Platform'] = 'android';
} else if (Platform.isIOS) {
  options.headers['Platform'] = 'ios';
} else if (kIsWeb) {
  options.headers['Platform'] = 'web';
} else {
  options.headers['Platform'] = 'mobile';
}

// Add device info headers
if (_deviceId != null) {
  options.headers['Device-Id'] = _deviceId!;
}
if (_deviceModel != null) {
  options.headers['Device-Model'] = _deviceModel!;
}
if (_osVersion != null) {
  options.headers['OS-Version'] = _osVersion!;
}
   // Add language headers if not already set
   if (options.headers['Accept-Language'] == null) {
    options.headers['Accept-Language'] = _appConfig.defaultLocale.languageCode;
   }

   // Add environment headers for debugging
    if (_appConfig.isDev) {
      options.headers['X-Environment'] = _appConfig.flavor.name;
    }

    // Add timestamp for request tracking
    options.headers['X-Timestamp'] = DateTime.now().toIso8601String();

    // Add correlation Id for request tracing
    if (options.headers['X-Correlation-Id'] == null) {
      options.headers['X-Correlation-Id'] = _generateCorrelationId();;
    }

    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  String _generateCorrelationId({int length = 32}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[DateTime.now().millisecond % chars.length]).join();
  }
}
