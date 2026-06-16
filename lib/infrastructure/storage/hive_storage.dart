import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_adapters/user_adapter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';

class HiveStorage implements LocalStorage {
  final EnvironmentService _env;
  final Future<Box> _settingsBox;
  final Future<Box> _userBox;
  final Future<Box> _cacheBox;
  final Future<Box> _productsBox;
  final Future<Box> _ordersBox;
  final Future<Box> _notificationsBox;
  final Future<Box> _apiCacheBox;

  final Map<String, Box> _openBoxes = {};
  bool _isInitialized = false;

  HiveStorage({
    required EnvironmentService env,
    required Future<Box> settingsBox,
    required Future<Box> userBox,
    required Future<Box> cacheBox,
    required Future<Box> productsBox,
    required Future<Box> ordersBox,
    required Future<Box> notificationsBox,
    required Future<Box> apiCacheBox,
  }) : _env = env,
       _settingsBox = settingsBox,
       _userBox = userBox,
       _cacheBox = cacheBox,
       _productsBox = productsBox,
       _ordersBox = ordersBox,
       _notificationsBox = notificationsBox,
       _apiCacheBox = apiCacheBox;

  @override
  bool get isInitialized => _isInitialized;

  /// Initialize Hive
  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      logger.i('[Hive] Initializing Hive storage...');

      // Get application documents directory
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      // Register adapters
      _registerAdapters();

      // Open default boxes
      await Future.wait([
        _openBox(StorageConstants.settingsBox, enableLazy: false),
        _openBox(StorageConstants.userBox, enableLazy: false),
        _openBox(StorageConstants.cacheBox, enableLazy: true),
        _openBox(StorageConstants.productsBox, enableLazy: true),
        _openBox(StorageConstants.ordersBox, enableLazy: true),
        _openBox(StorageConstants.notificationsBox, enableLazy: true),
        _openBox(StorageConstants.apiCacheBox, enableLazy: true),
      ]);

      // Clear cache in development if needed
      if (_env.shouldClearCacheOnStartup) {
        await clear();
      }

      _isInitialized = true;
      logger.i(
        '[Hive] Hive storage initialized with ${_openBoxes.length} boxes',
      );
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to initialize Hive storage',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Register Hive adapters
  void _registerAdapters() {
    // Register type adapters here
    // Register User adapter (typeId: 1)
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserAdapter());
    }
  }

  /// Open a Hive box
  Future<Box> _openBox(String name, {bool enableLazy = false}) async {
    try {
      if (_openBoxes.containsKey(name) && _openBoxes[name]!.isOpen) {
        return _openBoxes[name]!;
      }

      final box = await Hive.openBox(
        name,
        compactionStrategy: (entries, deletedEntries) {
          // Auto-compact when many entries are deleted
          return deletedEntries > 100;
        },
      );

      _openBoxes[name] = box;
      logger.i('[Hive] Opened Hive box: $name');
      return box;
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to open Hive box: $name',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Get a box by name
  Box _getBox(String boxName) {
    if (!_openBoxes.containsKey(boxName) || !_openBoxes[boxName]!.isOpen) {
      throw Exception('Box $boxName is not open');
    }
    return _openBoxes[boxName]!;
  }

  //============================================================================
  // CRUD Operations
  //============================================================================

  @override
  Future<void> write(String key, dynamic value, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      await box.put(key, value);
      logger.i('[Hive] Wrote to Hive: $key');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to write to Hive: $key',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  @override
  Future<T?> read<T>(String key, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      final value = box.get(key);
      return value as T?;
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to read from Hive: $key',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  @override
  Future<void> delete(String key, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      await box.delete(key);
      logger.i('[Hive] Deleted from Hive: $key');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to delete from Hive: $key',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  @override
  Future<void> clear({String? boxName}) async {
    try {
      if (boxName != null) {
        final box = _getBox(boxName);
        await box.clear();
        logger.i('[Hive] Cleared Hive box: $boxName');
      } else {
        // Clear all open boxes
        for (final entry in _openBoxes.entries) {
          if (entry.value.isOpen) {
            await entry.value.clear();
          }
        }
        logger.i('[Hive] Cleared all Hive boxes');
      }
    } catch (e, stack) {
      logger.e('[Hive] Failed to clear Hive', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<bool> contains(String key, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      return box.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getAll({String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      return box.toMap().cast<String, dynamic>();
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to get all from Hive',
        error: e,
        stackTrace: stack,
      );
      return {};
    }
  }

  //============================================================================
  // Batch Operations
  //============================================================================

  /// Write multiple values at once
  Future<void> writeAll(Map<String, dynamic> entries, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      await box.putAll(entries);
      logger.i('[Hive] Wrote ${entries.length} entries to Hive: $boxName');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to write all to Hive: $boxName',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Delete multiple keys at once
  Future<void> deleteAll(List<String> keys, {String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      await box.deleteAll(keys);
      logger.i('[Hive] Deleted ${keys.length} entries from Hive: $boxName');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to delete all from Hive: $boxName',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  //============================================================================
  // Cache Management
  //============================================================================

  /// Clear only cache boxes (not user data)
  Future<void> clearCache() async {
    try {
      await clear(boxName: 'cache');
      await clear(boxName: 'api_cache');
      await clear(boxName: 'products');
      logger.i('[Hive] Cleared all cache boxes');
    } catch (e, stack) {
      logger.e('[Hive] Failed to clear cache', error: e, stackTrace: stack);
    }
  }

  /// Clear user data (logout scenario)
  Future<void> clearUserData() async {
    try {
      await clear(boxName: 'user');
      await clear(boxName: 'settings');
      logger.i('[Hive] Cleared user data');
    } catch (e, stack) {
      logger.e('[Hive] Failed to clear user data', error: e, stackTrace: stack);
    }
  }

  /// Clear all data (factory reset)
  Future<void> clearAll() async {
    try {
      await clear();
      logger.i('[Hive] Cleared all data');
    } catch (e, stack) {
      logger.e('[Hive] Failed to clear all data', error: e, stackTrace: stack);
    }
  }

  //============================================================================
  // Hive-specific methods
  //============================================================================

  /// Watch a box for changes
  Stream<BoxEvent> watchBox({String boxName = 'settings'}) {
    final box = _getBox(boxName);
    return box.watch();
  }

  /// Get all keys in a box
  List<String> getKeys({String boxName = 'settings'}) {
    final box = _getBox(boxName);
    return box.keys.cast<String>().toList();
  }

  /// Get box length
  int getLength({String boxName = 'settings'}) {
    final box = _getBox(boxName);
    return box.length;
  }

  /// Check if box is empty
  bool isEmpty({String boxName = 'settings'}) {
    final box = _getBox(boxName);
    return box.isEmpty;
  }

  /// Check if box is not empty
  bool isNotEmpty({String boxName = 'settings'}) {
    final box = _getBox(boxName);
    return box.isNotEmpty;
  }

  /// Compact a box
  Future<void> compact({String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      await box.compact();
      logger.i('[Hive] Compacted Hive box: ${boxName ?? 'settings'}');
    } catch (e, stack) {
      logger.e('[Hive] Failed to compact Hive', error: e, stackTrace: stack);
    }
  }

  /// Get box size on disk (for debugging)
  Future<int> getBoxSize({String? boxName}) async {
    try {
      final box = _getBox(boxName ?? 'settings');
      // This is an estimate - actual implementation may vary
      return box.length;
    } catch (e) {
      return 0;
    }
  }

  //============================================================================
  // JSON Serialization Helpers
  //============================================================================

  /// Write JSON object
  Future<void> writeJson(
    String key,
    Map<String, dynamic> value, {
    String? boxName,
  }) async {
    await write(key, jsonEncode(value), boxName: boxName);
  }

  /// Read JSON object
  Future<Map<String, dynamic>?> readJson(String key, {String? boxName}) async {
    final value = await read<String>(key, boxName: boxName);
    if (value != null) {
      return jsonDecode(value) as Map<String, dynamic>;
    }
    return null;
  }

  /// Write list as JSON
  Future<void> writeJsonList(
    String key,
    List<dynamic> value, {
    String? boxName,
  }) async {
    await write(key, jsonEncode(value), boxName: boxName);
  }

  /// Read JSON list
  Future<List<dynamic>?> readJsonList(String key, {String? boxName}) async {
    final value = await read<String>(key, boxName: boxName);
    if (value != null) {
      return jsonDecode(value) as List<dynamic>;
    }
    return null;
  }

  //============================================================================
  // Box Management
  //============================================================================

  /// Close a box
  Future<void> closeBox({String? boxName}) async {
    try {
      if (boxName != null) {
        final box = _openBoxes[boxName];
        if (box != null && box.isOpen) {
          await box.close();
          _openBoxes.remove(boxName);
          logger.i('[Hive] Closed Hive box: $boxName');
        }
      }
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to close Hive box: $boxName',
        error: e,
        stackTrace: stack,
      );
    }
  }

  /// Close all boxes
  @override
  Future<void> close() async {
    try {
      for (final entry in _openBoxes.entries) {
        if (entry.value.isOpen) {
          await entry.value.close();
        }
      }
      _openBoxes.clear();
      _isInitialized = false;
      logger.i('[Hive] Closed all Hive boxes');
    } catch (e, stack) {
      logger.e('[Hive] Failed to close Hive', error: e, stackTrace: stack);
    }
  }

  /// Delete a box from disk
  Future<void> deleteBox(String boxName) async {
    try {
      if (_openBoxes.containsKey(boxName)) {
        await closeBox(boxName: boxName);
      }
      await Hive.deleteBoxFromDisk(boxName);
      logger.i('[Hive] Deleted Hive box from disk: $boxName');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to delete Hive box: $boxName',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  //============================================================================
  // Export/Import (for debugging)
  //============================================================================
  /// Export box data (for debugging)
  /// Export box data (for debugging)
  Map<String, dynamic> exportBox({String boxName = 'settings'}) {
    try {
      final box = _getBox(boxName);
      final Map<String, dynamic> export = {};

      for (final key in box.keys) {
        final value = box.get(key);
        export[key.toString()] = value;
      }

      return export;
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to export Hive box: $boxName',
        error: e,
        stackTrace: stack,
      );
      return {};
    }
  }

  /// Export all boxes (for debugging)
  Map<String, Map<String, dynamic>> exportAllBoxes() {
    final export = <String, Map<String, dynamic>>{};
    for (final boxName in _openBoxes.keys) {
      export[boxName] = exportBox(boxName: boxName);
    }
    return export;
  }

  /// Import data into a box (for testing)
  Future<void> importBox(String boxName, Map<String, dynamic> data) async {
    try {
      final box = _getBox(boxName);
      await box.clear();
      await box.putAll(data);
      logger.i('[Hive] Imported ${data.length} entries into box: $boxName');
    } catch (e, stack) {
      logger.e(
        '[Hive] Failed to import into box: $boxName',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  //============================================================================
  // Specific Box Getters (Convenience Methods)
  //============================================================================

  /// Get settings box
  Box get settingsBox => _getBox('settings');

  /// Get user box
  Box get userBox => _getBox('user');

  /// Get cache box
  Box get cacheBox => _getBox('cache');

  /// Get products box
  Box get productsBox => _getBox('products');

  /// Get orders box
  Box get ordersBox => _getBox('orders');

  /// Get notifications box
  Box get notificationsBox => _getBox('notifications');

  /// Get API cache box
  Box get apiCacheBox => _getBox('api_cache');
}



// Example usage
// Write user data
// await hiveStorage.write('user_id', '12345', boxName: 'user');
// await hiveStorage.writeJson('user_profile', {
//   'name': 'John Doe',
//   'email': 'john@example.com',
// }, boxName: 'user');

// // Read user data
// final userId = await hiveStorage.read<String>('user_id', boxName: 'user');
// final userProfile = await hiveStorage.readJson('user_profile', boxName: 'user');

// // Watch for changes
// hiveStorage.watchBox(boxName: 'settings').listen((event) {
//   print('Box changed: ${event.key} = ${event.value}');
// });

// // Clear cache on logout
// await hiveStorage.clearUserData();

// // Export for debugging
// final allData = hiveStorage.exportAllBoxes();
// print(allData);