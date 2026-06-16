// lib/infrastructure/storage/shared_prefs_storage.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @Injecatble() Tells Injecatble that this class is part of DI.
/// Register it so that when someone asks for a LocalStorage, they get an instance of this implementation.
class SharedPrefsStorage implements LocalStorage {
  final SharedPreferences _prefs;
  final bool _enableLogging;
  bool _isInitialized = true; // SharedPreferences is initialized at construction time.

  SharedPrefsStorage({
    required SharedPreferences prefs,
    required bool enableLogging,
  })  : _prefs = prefs,
        _enableLogging = enableLogging;

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    // Already initialized via constructor
    _log('SharedPreferences already initialized');
  }

  @override
  Future<void> write(String key, dynamic value, {String? boxName}) async {
    try {
      bool success = false;
      
      if (value is String) {
        success = await _prefs.setString(key, value);
      } else if (value is int) {
        success = await _prefs.setInt(key, value);
      } else if (value is double) {
        success = await _prefs.setDouble(key, value);
      } else if (value is bool) {
        success = await _prefs.setBool(key, value);
      } else if (value is List<String>) {
        success = await _prefs.setStringList(key, value);
      } else {
        // For complex objects, store as JSON string
        final jsonString = jsonEncode(value);
        success = await _prefs.setString(key, jsonString);
      }
      
      if (!success) {
        throw Exception('Failed to write to SharedPreferences');
      }
      
      _log('Wrote to SharedPreferences: $key');
    } catch (e, stack) {
      _logError('Failed to write to SharedPreferences: $key', e, stack);
      rethrow;
    }
  }

  @override
  Future<T?> read<T>(String key, {String? boxName}) async {
    try {
      final value = _prefs.get(key);
      
      if (value == null) return null;
      
      // Handle type casting
      if (T == String) return value as T;
      if (T == int) return value as T;
      if (T == double) return value as T;
      if (T == bool) return value as T;
      if (T == List<String>) return value as T;
      
      // For complex types, try to decode from JSON
      if (value is String) {
        try {
          final decoded = jsonDecode(value);
          return decoded as T;
        } catch (e) {
          // Not JSON, return as is if it matches
          return value as T?;
        }
      }
      
      return null;
    } catch (e, stack) {
      _logError('Failed to read from SharedPreferences: $key', e, stack);
      return null;
    }
  }

  @override
  Future<void> delete(String key, {String? boxName}) async {
    try {
      await _prefs.remove(key);
      _log('Deleted from SharedPreferences: $key');
    } catch (e, stack) {
      _logError('Failed to delete from SharedPreferences: $key', e, stack);
      rethrow;
    }
  }

  @override
  Future<void> clear({String? boxName}) async {
    try {
      await _prefs.clear();
      _log('Cleared all SharedPreferences');
    } catch (e, stack) {
      _logError('Failed to clear SharedPreferences', e, stack);
      rethrow;
    }
  }

  @override
  Future<bool> contains(String key, {String? boxName}) async {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getAll({String? boxName}) async {
    try {
      return _prefs.getKeys().fold<Map<String, dynamic>>(
        {},
        (map, key) {
          map[key] = _prefs.get(key);
          return map;
        },
      );
    } catch (e, stack) {
      _logError('Failed to get all from SharedPreferences', e, stack);
      return {};
    }
  }

  @override
  Future<void> close() async {
    // SharedPreferences doesn't need closing
    _log('SharedPreferences closed (no-op)');
  }

  void _log(String message) {
    if (_enableLogging) {
      debugPrint('📦 [SharedPrefs] $message');
    }
  }

  void _logError(String message, Object error, StackTrace stack) {
    debugPrint('❌ [SharedPrefs] $message');
    debugPrint('   Error: $error');
    if (_enableLogging) {
      debugPrint('   Stack: $stack');
    }
  }
}