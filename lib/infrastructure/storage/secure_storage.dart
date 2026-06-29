// lib/infrastructure/storage/secure_storage.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage implements LocalStorage {
  final LoggerService _logger;
  final FlutterSecureStorage _storage;
  final bool _enableLogging;
  bool _isInitialized = false;

  SecureStorage({
    required FlutterSecureStorage storage,
    required bool enableLogging,
    required LoggerService logger,
  })  : _storage = storage,
        _enableLogging = enableLogging,
        _logger = logger;

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    try {
      // Test write to ensure storage is accessible
      await _storage.write(key: '_test', value: 'test');
      await _storage.delete(key: '_test');
      _isInitialized = true;
      _logger.i('[SecureStorage] SecureStorage initialized');
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to initialize SecureStorage', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> write(String key, dynamic value, {String? boxName}) async {
    try {
      String stringValue;
      
      if (value is String) {
        stringValue = value;
      } else {
        // For non-string values, store as JSON
        stringValue = jsonEncode(value);
      }
      
      await _storage.write(key: key, value: stringValue);
      _logger.i('[SecureStorage] Wrote to SecureStorage: $key');
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to write to SecureStorage: $key', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<T?> read<T>(String key, {String? boxName}) async {
    try {
      final value = await _storage.read(key: key);
      
      if (value == null) return null;
      
      // Try to decode JSON for complex types
      if (T != String) {
        try {
          final decoded = jsonDecode(value);
          return decoded as T;
        } catch (e) {
          // Not JSON, return as is
          return value as T;
        }
      }
      
      return value as T;
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to read from SecureStorage: $key', error: e, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<void> delete(String key, {String? boxName}) async {
    try {
      await _storage.delete(key: key);
      _logger.i('[SecureStorage] Deleted from SecureStorage: $key');
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to delete from SecureStorage: $key', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> clear({String? boxName}) async {
    try {
      await _storage.deleteAll();
      _logger.i('[SecureStorage] Cleared all SecureStorage');
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to clear SecureStorage', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<bool> contains(String key, {String? boxName}) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getAll({String? boxName}) async {
    try {
      final all = await _storage.readAll();
      return all;
    } catch (e, stack) {
      _logger.e('[SecureStorage] Failed to get all from SecureStorage', error: e, stackTrace: stack);
      return {};
    }
  }

  @override
  Future<void> close() async {
    // SecureStorage doesn't need closing
    _isInitialized = false;
    _logger.i('[SecureStorage] SecureStorage closed');
  }

  // SecureStorage-specific methods
  Future<bool> containsKey(String key) async {
    return contains(key);
  }

  Future<Map<String, dynamic>> readAll() async {
    return getAll();
  }

}