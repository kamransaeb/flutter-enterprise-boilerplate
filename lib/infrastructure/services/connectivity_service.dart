import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

enum InternetQuality { connected, disconnected, slowConnection }

@singleton
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final BehaviorSubject<ConnectivityResult> _connectivityStream =
      BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.none);

  bool _isInitialized = false;

  static const int _slowConnectionThreshold = 3000; // milliseconds

  ConnectivityResult get currentStatus => _connectivityStream.value;

  Stream<ConnectivityResult> get onConnectivityChanged =>
      // distinct() filters out duplicate consecutive events.
      _connectivityStream.stream.distinct();

  /// Initialize connectivity monitoring
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      logger.i('[Connectivity] Initializing connectivity service...');

      // Get initial connectivity status (API returns List<ConnectivityResult>)
      final result = await _connectivity.checkConnectivity();
      _connectivityStream.add(_toSingleResult(result));

      // Listen for connectivity changes
      _connectivity.onConnectivityChanged.listen((
        List<ConnectivityResult> result,
      ) {
        final single = _toSingleResult(result);
        _connectivityStream.add(single);
        logger.d('[Connectivity] Connectivity changed: $single');
      });

      _isInitialized = true;
      logger.i('[Connectivity] Connectivity service initialized');
    } catch (e, stack) {
      logger.e(
        '[Connectivity] Failed to initialize connectivity service',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }



  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.any((r) => r != ConnectivityResult.none);
    } catch (e) {
      logger.e('[Connectivity] Failed to check connectivity', error: e);
      return false;
    }
  }

  Future<InternetQuality> get checkInternetQuality async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (_toSingleResult(result) == ConnectivityResult.none) {
        return InternetQuality.disconnected;
      }

      // For mobile/web, we can try to make a simple HTTP request
      // to verify actual internet access
      final stopwatch = Stopwatch()..start();

      // Ping a reliable endpoint
      final request = await HttpClient().getUrl(
        Uri.parse('https://www.google.com'),
      );
      await request.close();
      stopwatch.stop();
      final duration = stopwatch.elapsed;

      if (duration.inMilliseconds < _slowConnectionThreshold) {
        return InternetQuality.connected;
      } else {
        return InternetQuality.slowConnection;
      }
    } catch (e) {
      logger.e('[Connectivity] Failed to check internet access', error: e);
      return InternetQuality.disconnected;
    }
  }

  Future<ConnectivityResult> getCurrentStatus() async {
    final result = await _connectivity.checkConnectivity();
    return _toSingleResult(result);
  }

  bool get isWifi => currentStatus == ConnectivityResult.wifi;
  bool get isMobile => currentStatus == ConnectivityResult.mobile;
  bool get isEthernet => currentStatus == ConnectivityResult.ethernet;
  bool get isBluetooth => currentStatus == ConnectivityResult.bluetooth;
  bool get isVpn => currentStatus == ConnectivityResult.vpn;
  bool get isOther => currentStatus == ConnectivityResult.other;
  bool get isSatellite => currentStatus == ConnectivityResult.satellite;
  bool get isNone => currentStatus == ConnectivityResult.none;

  String get connectionType {
    switch (currentStatus) {
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.satellite:
        return 'Satellite';
      case ConnectivityResult.none:
        return 'No Connection';
    }
  }

  Future<void> dispose() async {
    await _connectivityStream.close();
  }

  /// Reduces [List<ConnectivityResult>] to a single value (first non-none, or none).
  static ConnectivityResult _toSingleResult(List<ConnectivityResult> results) {
    return results.firstWhere(
      (r) => r != ConnectivityResult.none,
      orElse: () => ConnectivityResult.none,
    );
  }
}
