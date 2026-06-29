import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_adapters/user_adapter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

class HiveStorage implements LocalStorage {
  final LoggerService _logger;
  final EnvironmentService _env;

  final Map<String, Box> _openBoxes = {};

  bool _isInitialized = false;

  HiveStorage({
    required EnvironmentService env,
    required LoggerService logger,
  })  : _env = env,
        _logger = logger;

  @override
  bool get isInitialized => _isInitialized;

  /// Initialize Hive
  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _logger.i('[Hive] Initializing Hive storage...');

      // Get application documents directory
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      // Register adapters
      _registerAdapters();

      // Open default boxes
      await Future.wait([
        _openBox(StorageConstants.settingsBox),
        _openBox(StorageConstants.userBox),
        _openBox(StorageConstants.cacheBox),
        _openBox(StorageConstants.productsBox),
        _openBox(StorageConstants.ordersBox),
        _openBox(StorageConstants.notificationsBox),
        _openBox(StorageConstants.apiCacheBox),
      ]);

      // Clear cache in development if needed
      if (_env.shouldClearCacheOnStartup) {
        await clear();
      }

      _isInitialized = true;
      _logger.i(
        '[Hive] Hive storage initialized with ${_openBoxes.length} boxes',
      );
    } catch (e, stack) {
      _logger.e(
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
  Future<Box> _openBox(String name) async {
    try {
      if (_openBoxes.containsKey(name) && _openBoxes[name]!.isOpen) {
        return _openBoxes[name]!;
      }

      final box = await Hive.openBox<dynamic>(
        name,
        // 
        compactionStrategy: (entries, deletedEntries) {
          // Auto-compact when many entries are deleted
          return deletedEntries > 100;
        },
      );

      _openBoxes[name] = box;
      _logger.i('[Hive] Opened Hive box: $name');
      return box;
    } catch (e, stack) {
      _logger.e(
        '[Hive] Failed to open Hive box: $name',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  /// Get a box by name
  Box _getBox(String boxName) {
    _ensureInitialized();
    if (!_openBoxes.containsKey(boxName) || !_openBoxes[boxName]!.isOpen) {
      throw Exception('Box $boxName is not open');
    }
    return _openBoxes[boxName]!;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('Hive storage is not initialized');
    }
  }
  //============================================================================
  // CRUD Operations
  //============================================================================

  @override
  Future<void> write(String key, dynamic value, {String? boxName}) async {
    try {
      final box = _getBox(_resolveBoxName(boxName));
      await box.put(key, value);
      _logger.i('[Hive] Wrote to Hive: $key');
    } catch (e, stack) {
      _logger.e(
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
      final box = _getBox(_resolveBoxName(boxName));
      final value = box.get(key);
      return value as T?;
    } catch (e, stack) {
      _logger.e(
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
      final box = _getBox(_resolveBoxName(boxName));
      await box.delete(key);
      _logger.i('[Hive] Deleted from Hive: $key');
    } catch (e, stack) {
      _logger.e(
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
        final box = _getBox(_resolveBoxName(boxName));
        await box.clear();
        _logger.i('[Hive] Cleared Hive box: $boxName');
      } else {
        // Clear all open boxes
        for (final entry in _openBoxes.entries) {
          if (entry.value.isOpen) {
            await entry.value.clear();
          }
        }
        _logger.i('[Hive] Cleared all Hive boxes');
      }
    } catch (e, stack) {
      _logger.e('[Hive] Failed to clear Hive', error: e, stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<bool> contains(String key, {String? boxName}) async {
    try {
      final box = _getBox(_resolveBoxName(boxName));
      return box.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getAll({String? boxName}) async {
    try {
      final box = _getBox(_resolveBoxName(boxName));
      return box.toMap().cast<String, dynamic>();
    } catch (e, stack) {
      _logger.e(
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
      final box = _getBox(_resolveBoxName(boxName));
      await box.putAll(entries);
      _logger.i('[Hive] Wrote ${entries.length} entries to Hive: $boxName');
    } catch (e, stack) {
      _logger.e(
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
      final box = _getBox(_resolveBoxName(boxName));
      await box.deleteAll(keys);
      _logger.i('[Hive] Deleted ${keys.length} entries from Hive: $boxName');
    } catch (e, stack) {
      _logger.e(
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
      await clear(boxName: StorageConstants.cacheBox);
      await clear(boxName: StorageConstants.apiCacheBox);
      await clear(boxName: StorageConstants.productsBox);
      _logger.i('[Hive] Cleared all cache boxes');
    } catch (e, stack) {
      _logger.e('[Hive] Failed to clear cache', error: e, stackTrace: stack);
    }
  }

  /// Clear user data (logout scenario)
  Future<void> clearUserData() async {
    try {
      await clear(boxName: StorageConstants.userBox);
      await clear(boxName: StorageConstants.settingsBox);
      _logger.i('[Hive] Cleared user data');
    } catch (e, stack) {
      _logger.e('[Hive] Failed to clear user data', error: e, stackTrace: stack);
    }
  }

  /// Clear all data (factory reset)
  Future<void> clearAll() async {
    try {
      await clear();
      _logger.i('[Hive] Cleared all data');
    } catch (e, stack) {
      _logger.e('[Hive] Failed to clear all data', error: e, stackTrace: stack);
    }
  }

  //============================================================================
  // Hive-specific methods
  //============================================================================

  /// Watch a box for changes
  Stream<BoxEvent> watchBox({String boxName = StorageConstants.settingsBox}) {
    final box = _getBox(_resolveBoxName(boxName));
    return box.watch();
  }

  /// Get all keys in a box
  List<String> getKeys({String boxName = StorageConstants.settingsBox}) {
    final box = _getBox(_resolveBoxName(boxName));
    return box.keys.cast<String>().toList();
  }

  /// Get box length
  int getLength({String boxName = StorageConstants.settingsBox}) {
    final box = _getBox(_resolveBoxName(boxName));
    return box.length;
  }

  /// Check if box is empty
  bool isEmpty({String boxName = StorageConstants.settingsBox}) {
    final box = _getBox(_resolveBoxName(boxName));
    return box.isEmpty;
  }

  /// Check if box is not empty
  bool isNotEmpty({String boxName = StorageConstants.settingsBox}) {
    final box = _getBox(_resolveBoxName(boxName));
    return box.isNotEmpty;
  }

  /// Compact a box
  Future<void> compact({String? boxName}) async {
    try {
      final box = _getBox(_resolveBoxName(boxName));
      await box.compact();
      _logger.i(
        '[Hive] Compacted Hive box: ${boxName ?? StorageConstants.settingsBox}',
      );
    } catch (e, stack) {
      _logger.e('[Hive] Failed to compact Hive', error: e, stackTrace: stack);
    }
  }

  /// Get box size on disk (for debugging)
  Future<int> getBoxSize({String? boxName}) async {
    try {
      final box = _getBox(_resolveBoxName(boxName));
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
          _logger.i('[Hive] Closed Hive box: $boxName');
        }
      }
    } catch (e, stack) {
      _logger.e(
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
      _logger.i('[Hive] Closed all Hive boxes');
    } catch (e, stack) {
      _logger.e('[Hive] Failed to close Hive', error: e, stackTrace: stack);
    }
  }

  /// Delete a box from disk
  Future<void> deleteBox(String boxName) async {
    try {
      if (_openBoxes.containsKey(boxName)) {
        await closeBox(boxName: boxName);
      }
      await Hive.deleteBoxFromDisk(boxName);
      _logger.i('[Hive] Deleted Hive box from disk: $boxName');
    } catch (e, stack) {
      _logger.e(
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
  Map<String, dynamic> exportBox({String? boxName}) {
    try {
      final box = _getBox(_resolveBoxName(boxName));
      final Map<String, dynamic> export = {};

      for (final key in box.keys) {
        final value = box.get(key);
        export[key.toString()] = value;
      }

      return export;
    } catch (e, stack) {
      _logger.e(
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
      final box = _getBox(_resolveBoxName(boxName));
      await box.clear();
      await box.putAll(data);
      _logger.i('[Hive] Imported ${data.length} entries into box: $boxName');
    } catch (e, stack) {
      _logger.e(
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
  Box get settingsBox => _getBox(StorageConstants.settingsBox);

  /// Get user box
  Box get userBox => _getBox(StorageConstants.userBox);

  /// Get cache box
  Box get cacheBox => _getBox(StorageConstants.cacheBox);

  /// Get products box
  Box get productsBox => _getBox(StorageConstants.productsBox);

  /// Get orders box
  Box get ordersBox => _getBox(StorageConstants.ordersBox);

  /// Get notifications box
  Box get notificationsBox => _getBox(StorageConstants.notificationsBox);

  /// Get API cache box
  Box get apiCacheBox => _getBox(StorageConstants.apiCacheBox);

  String _resolveBoxName(String? boxName) =>
      boxName ?? StorageConstants.settingsBox;
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