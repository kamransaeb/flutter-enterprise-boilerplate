import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/cache_manager.dart'
    as infrastructure;
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/models/cache_entry.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/models/cache_statistics.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';
import '../storage/local_storage.dart';
import 'package:path/path.dart' as path;

@LazySingleton(as: infrastructure.CacheManager)
class CacheManagerImpl implements infrastructure.CacheManager {
  late final LocalStorage _storage;
  late final BaseCacheManager _cacheManager;
  final _lock = Lock();

  /// Key for storing cache metadata in local storage
  @visibleForTesting
  static const String cacheMetadataKey = 'cache_metadata';

  /// Key for storing cached URLs list
  @visibleForTesting
  static const String cachedUrlsKey = 'cached_urls';

  // @visibleForTesting It’s mostly documentation + analyzer guidance; it does not change runtime behavior.
  /// Key for storing cache configuration
  @visibleForTesting
  static const String cacheConfigKey = 'cache_config';

  /// Default cache configuration
  // static const Duration _defaultStalePeriod = Duration(days: 7);
  // static const int _defaultMaxSize = 100 * 1024 * 1024; // 100MB
  // static const int _defaultMaxObjects = 1000;
  // static const Duration _defaultCleanupInterval = Duration(hours: 24);

  /// Creates a new [CacheManagerImpl] with the given storage and optional configuration.
  CacheManagerImpl(
    @Named('hive_storage') LocalStorage storage, 
    AppConfig appConfig,
    // @factoryParam is an injectable annotation that marks constructor
    // parameters as values passed at resolve time, not registered as dependencies.
    // @factoryParam = “this constructor argument comes from the caller at creation time.”
    // *** It only works for factory registrations (@factory, @injectable(as:...) 
    // with a factory constructor pattern or module factory methods, not @LazySingleton)
    // @factoryParam BaseCacheManager? cacheManager,
    // @factoryParam Duration? stalePeriod,
    // @factoryParam int? maxSize,
    // @factoryParam int? maxObjects,
    // @factoryParam Duration? cleanupInterval,
  ) {
     _storage = storage;    
    _stalePeriod = appConfig.cacheStalePeriod;
    _maxSize = appConfig.cacheMaxSize;
    _maxObjects = appConfig.cacheMaxObjects;
    _cleanupInterval = appConfig.cacheCleanupInterval;
    _cacheManager = DefaultCacheManager();
    // Schedule cache cleanup task
    _scheduleCleanup();
  }

  late final Duration _stalePeriod;
  late final int _maxSize;
  late final int _maxObjects;
  late final Duration _cleanupInterval;
  bool _isDisposed = false;

  @override
  Future<Either<Failure, String>> getCachedFile(String url) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Tries cache first. If a valid cached file exists for that URL/key, it returns that file.
      // If not (missing or too old), it downloads the file, caches it, then returns it.
      final file = await _cacheManager.getSingleFile(url);
      await _updateMetadata(url, accessedAt: DateTime.now());
      return Right(file.path);
    } on Exception catch (e, stackTrace) {
      logger.e(
        'Failed to get cached file: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure(
          message: 'Failed to get cached file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getDataFromCache(
    String url, {
    String? boxName,
  }) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Tries cache first. If a valid cached file exists for that URL/key, it returns that file.
      // If not (missing or too old), it downloads the file, caches it, then returns it.
      final file = await _cacheManager.getSingleFile(url);
      await _updateMetadata(url, accessedAt: DateTime.now());
      return Right(file.path);
    } on Exception catch (e, stackTrace) {
      logger.e(
        'Failed to get cached file: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure(
          message: 'Failed to get cached file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, File?>> getFileFromCache(String url) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Looks only in the cache. If there’s an entry for that key, you get a FileInfo.
      // If not, or it’s expired, you get null.
      final fileInfo = await _cacheManager.getFileFromCache(url);
      if (fileInfo != null) {
        await _updateMetadata(url, accessedAt: DateTime.now());
        return Right(fileInfo.file);
      }
      return const Right(null);
    } on Exception catch (e, stackTrace) {
      logger.e(
        'Failed to get file from cache: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure(
          message: 'Failed to get file from cache: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> cacheFile(String url) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Downloads the file from url and stores it in the underlying cache
      await _cacheManager.downloadFile(url);
      // Adds the URL to the list of cached URLs
      await _addToCachedUrl(url);
      // Updates the metadata for the cached file
      await _updateMetadata(
        url,
        cachedAt: DateTime.now(),
        accessedAt: DateTime.now(),
      );

      // Check if we need to clean up old cache
      unawaited(_maintainCacheSize());
      unawaited(_maintainCacheObjects());

      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      logger.e('Failed to cache file: $e', error: e, stackTrace: stackTrace);
      return Left(
        CacheFailure(
          message: 'Failed to cache file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheData(
    String key,
    String value, {
    String? boxName,
  }) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Store the value in the storage
      await _storage.write(key, value, boxName: boxName);
      await _addToCachedUrl(key);
      // Updates the metadata for the cached file
      await _updateMetadata(
        key,
        cachedAt: DateTime.now(),
        accessedAt: DateTime.now(),
      );
      // Check if we need to clean up old cache
      unawaited(_maintainCacheSize());
      unawaited(_maintainCacheObjects());

      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      logger.e('Failed to cache file: $e', error: e, stackTrace: stackTrace);
      return Left(
        CacheFailure(
          message: 'Failed to cache file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> preCacheFiles(
    List<String> urls, {
    void Function(int completed, int total)? onProgress,
  }) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      int completed = 0;
      final total = urls.length;

      await Future.wait(
        urls.map((url) async {
          await _cacheManager.downloadFile(url);
          completed++;
          onProgress?.call(completed, total);
        }),
      );

      await _addToCachedUrls(urls);
      // Because nothing awaits it, it becomes an unhandled asynchronous error.
      // In Dart, that is reported by the current Zone (e.g. via Zone.current.handleUncaughtError). So:
      // In development you usually see it in the console / debugger.
      // In Flutter, it can be reported by the framework’s error handling (e.g. FlutterError.onError or runZonedGuarded).
      unawaited(_maintainCacheSize());
      unawaited(_maintainCacheObjects());

      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      logger.e(
        'Failed to pre-cache files: $e',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        CacheFailure(
          message: 'Failed to pre-cache files: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> clearCache() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      await _lock.synchronized(() async {
        await _cacheManager.emptyCache();
        await _storage.delete(cacheMetadataKey);
        await _storage.delete(cachedUrlsKey);
      });
      // Unit is a type that means “no meaningful value” — like void
      // Right(unit) = “success, but there’s nothing else to return” (you only signal success).
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to clear cache: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, int>> getCacheSize() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      final urlsResult = await getCachedUrls();

      return urlsResult.fold(
        (failure) => Left(
          CacheFailure(
            message: 'Failed to get cached URLs: ${failure.message}',
          ),
        ),
        (data) async {
          int totalSize = 0;
          for (final url in data) {
            final fileInfo = await _cacheManager.getFileFromCache(url);
            if (fileInfo != null && await fileInfo.file.exists()) {
              totalSize += await fileInfo.file.length();
            }
          }
          return Right(totalSize);
        },
      );
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to get cache size: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, List<String>>> getCachedUrls() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      final urls = await _storage.read<List<String>>(cachedUrlsKey);
      return Right(urls ?? []);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to get cached URLs: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, bool>> isFileCached(String url) async {
    if (_isDisposed) {
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      final fileInfo = await _cacheManager.getFileFromCache(url);
      final isCached = fileInfo != null;

      if (isCached) {
        await _updateMetadata(url, accessedAt: DateTime.now());
      }

      return Right(isCached);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to check if file is cached: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> removeCachedFile(String url) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Runs the async callback with exclusive access; other callers wait.
      // Protects shared cache state from concurrent async updates (mutex for async code).
      await _lock.synchronized(() async {
        await _cacheManager.removeFile(url);
        await _removeFromCachedUrls(url);
        await _removeMetadata(url);
      });

      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to remove cached file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  /// Removes a cached data item from the storage
  Future<Either<Failure, Unit>> removeCachedData(
    String key, {
    String? boxName,
  }) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      // Runs the async callback with exclusive access; other callers wait.
      // Protects shared cache state from concurrent async updates (mutex for async code).
      await _lock.synchronized(() async {
        await _storage.delete(key, boxName: boxName);
        await _removeFromCachedUrls(key);
        await _removeMetadata(key);
      });

      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to remove cached file: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> removeCachedFiles(List<String> urls) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      await _lock.synchronized(() async {
        await Future.wait(urls.map((url) => _cacheManager.removeFile(url)));
        for (final url in urls) {
          await _removeFromCachedUrls(url);
          await _removeMetadata(url);
        }
      });
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to remove cached files: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, CacheStatistics>> getStatistics() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      final urlsResult = await getCachedUrls();
      // if (urlsResult.isLeft()) {
      //   return Left(urlsResult.asLeft());
      // }

      return urlsResult.fold(
        (failure) => Left(
          CacheFailure(
            message: 'Failed to get cached URLs: ${failure.message}',
          ),
        ),
        (data) async {
          int totalSize = 0;
          final entries = <CacheEntry>[];
          int hits = 0;
          int misses = 0;

          for (final url in data) {
            final fileInfo = await _cacheManager.getFileFromCache(url);
            if (fileInfo != null && await fileInfo.file.exists()) {
              final fileSize = await fileInfo.file.length();
              totalSize += fileSize;
              hits++;

              entries.add(
                CacheEntry(
                  url: url,
                  size: fileSize,
                  cachedAt: await _getCachedAt(url),
                  lastAccessed: await _getLastAccessed(url),
                  validUntil: fileInfo.validTill,
                  filePath: fileInfo.file.path,
                  // accessCount: fileInfo.accessCount,
                ),
              );
            } else {
              misses++;
              // Clean up stale metadata
              await _removeFromCachedUrls(url);
              await _removeMetadata(url);
            }
          }

          // Sort by last accessed (most recent first)
          entries.sort((a, b) => b.lastAccessed.compareTo(a.lastAccessed));
          final cacheDir = await getTemporaryDirectory();
          final cachePath = path.join(cacheDir.path, 'flutter_cache_manager');

          return Right(
            CacheStatistics(
              totalFiles: entries.length,
              totalSize: totalSize,
              entries: entries,
              oldestEntry: entries.isNotEmpty ? entries.last : null,
              newestEntry: entries.isNotEmpty ? entries.first : null,
              hitRate: hits + misses > 0 ? hits / (hits + misses) : 0,
              maxSize: _maxSize,
              maxObjects: _maxObjects,
              stalePeriod: _stalePeriod,
              cachePath: cachePath,
              lastCleanup: await _getLastCleanupTime(),
            ),
          );
        },
      );
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to get cache statistics: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, bool>> isValidCache(
    String url, {
    Duration? maxAge,
  }) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      final fileInfo = await _cacheManager.getFileFromCache(url);
      if (fileInfo == null) return const Right(false);

      final maxCacheAge = maxAge ?? _stalePeriod;
      final isValid =
          DateTime.now().difference(fileInfo.validTill) < maxCacheAge;

      return Right(isValid);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to validate cache: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> refreshCache(String url) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }

    try {
      await _lock.synchronized(() async {
        final now = DateTime.now();
        await _cacheManager.removeFile(url);
        await _cacheManager.downloadFile(url);
        await _updateMetadata(url, cachedAt: now, accessedAt: now);
      });
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to refresh cache: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, int>> cleanExpired() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      return await _lock.synchronized(() async {
        final urlsResult = await getCachedUrls();
        return urlsResult.fold(
          (failure) => Left(
            CacheFailure(
              message: 'Failed to get cached URLs: ${failure.message}',
            ),
          ),
          (data) async {
            int removed = 0;
            final now = DateTime.now();
            for (final url in data) {
              final fileInfo = await _cacheManager.getFileFromCache(url);
              if (fileInfo != null && fileInfo.validTill.isBefore(now)) {
                await _cacheManager.removeFile(url);
                await _removeFromCachedUrls(url);
                await _removeMetadata(url);
                removed++;
              } else {
                // Clean up stale metadata
                await _removeFromCachedUrls(url);
                await _removeMetadata(url);
                removed++;
              }
            }
            await _updateLastCleanupTime();
            return Right(removed);
          },
        );
      });
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to clean expired cache: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> setMaxSize(int sizeInBytes) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      _maxSize = sizeInBytes;
      await _saveConfig();
      unawaited(_maintainCacheSize());
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to set max cache size: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> setStalePeriod(Duration duration) async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      _stalePeriod = duration;
      await _saveConfig();
      // unawaited(_maintainCacheSize());
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to set stale period: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> setMaxObjects(int maxObjects) async {
    if (_isDisposed) {
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      _maxObjects = maxObjects;
      await _saveConfig();
      unawaited(_maintainCacheObjects());
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to set max objects: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getConfig() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    try {
      return Right({
        'stalePeriod': _stalePeriod.inMilliseconds,
        'maxSize': _maxSize,
        'maxObjects': _maxObjects,
        'cleanupInterval': _cleanupInterval.inMilliseconds,
      });
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to get config: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, Unit>> dispose() async {
    if (_isDisposed) {
      logger.e('Cache manager is disposed');
      return const Left(CacheFailure(message: 'Cache manager is disposed'));
    }
    _isDisposed = true;
    try {
      _isDisposed = true;
      await _cacheManager.dispose();
      return const Right(unit);
    } on Exception catch (e, stackTrace) {
      return Left(
        CacheFailure(
          message: 'Failed to dispose cache manager: $e',
          details: {'stackTrace': stackTrace.toString()},
        ),
      );
    }
  }

  // Private helper methods
  void _scheduleCleanup() {
    Future.delayed(_cleanupInterval, () async {
      await cleanExpired();
      _scheduleCleanup();
    });
  }

  Future<void> _saveConfig() async {
    await _storage.write(cacheConfigKey, {
      'stalePeriod': _stalePeriod.inMilliseconds,
      'maxSize': _maxSize,
      'maxObjects': _maxObjects,
      'cleanupInterval': _cleanupInterval.inMilliseconds,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _addToCachedUrl(String url) => _addToCachedUrls([url]);

  Future<void> _addToCachedUrls(List<String> urls) async {
    await _lock.synchronized(() async {
      final existing = await _storage.read<List<String>>(cachedUrlsKey) ?? [];
      final updated = {...existing, ...urls}.toList();
      await _storage.write(cachedUrlsKey, updated);
    });
  }

  Future<void> _removeFromCachedUrls(String url) async {
    await _lock.synchronized(() async {
      final existing = await _storage.read<List<String>>(cachedUrlsKey) ?? [];
      existing.remove(url);
      await _storage.write(cachedUrlsKey, existing);
    });
  }

  Future<void> _updateMetadata(
    String url, {
    DateTime? cachedAt,
    DateTime? accessedAt,
  }) async {
    await _lock.synchronized(() async {
      final metadata =
          await _storage.read<Map<String, dynamic>>(cacheMetadataKey) ?? {};
      final entry = (metadata[url] as Map<String, dynamic>?) ?? {};

      if (cachedAt != null) {
        entry['cachedAt'] = cachedAt.toIso8601String();
      }
      if (accessedAt != null) {
        entry['accessedAt'] = accessedAt.toIso8601String();
      }
      entry['lastUpdated'] = DateTime.now().toIso8601String();

      metadata[url] = entry;
      await _storage.write(cacheMetadataKey, metadata);
    });
  }

  Future<void> _removeMetadata(String url) async {
    await _lock.synchronized(() async {
      final metadata =
          await _storage.read<Map<String, dynamic>>(cacheMetadataKey) ?? {};
      metadata.remove(url);
      await _storage.write(cacheMetadataKey, metadata);
    });
  }

  Future<DateTime> _getCachedAt(String url) async {
    final metadata =
        await _storage.read<Map<String, dynamic>>(cacheMetadataKey) ?? {};
    final entry = metadata[url] as Map<String, dynamic>?;
    if (entry?.containsKey('cachedAt') ?? false) {
      return DateTime.parse(entry!['cachedAt'] as String);
    }
    return DateTime.now();
  }

  Future<DateTime> _getLastAccessed(String url) async {
    final metadata =
        await _storage.read<Map<String, dynamic>>(cacheMetadataKey) ?? {};
    final entry = metadata[url] as Map<String, dynamic>?;
    if (entry?.containsKey('accessedAt') ?? false) {
      return DateTime.parse(entry!['accessedAt'] as String);
    }
    return DateTime.now();
  }

  Future<int> _getAccessCount(String url) async {
    final metadata =
        await _storage.read<Map<String, dynamic>>(cacheMetadataKey) ?? {};
    final entry = metadata[url] as Map<String, dynamic>?;
    return (entry?['accessCount'] as int?) ?? 0;
  }

  Future<DateTime?> _getLastCleanupTime() async {
    final config =
        await _storage.read<Map<String, dynamic>>(cacheConfigKey) ?? {};
    if (config.containsKey('lastCleanup')) {
      return DateTime.parse(config['lastCleanup'] as String);
    }
    return null;
  }

  Future<void> _updateLastCleanupTime() async {
    final config =
        await _storage.read<Map<String, dynamic>>(cacheConfigKey) ?? {};
    config['lastCleanup'] = DateTime.now().toIso8601String();
    await _storage.write(cacheConfigKey, config);
  }

  Future<void> _maintainCacheSize() async {
    final sizeResult = await getCacheSize();
    return sizeResult.fold((_) => unit, (cacheSize) async {
      if (cacheSize > _maxSize) {
        // Remove oldest accessed files until under limit
        final statistics = await getStatistics();
        return statistics.fold((_) => unit, (data) async {
          // Sort by lastAccessed ascending (oldest first)
          final entries = data.entries
            ..sort((a, b) => a.lastAccessed.compareTo(b.lastAccessed));
          for (final entry in entries) {
            final currentSize = await getCacheSize();
            final size = currentSize.fold((_) => _maxSize + 1, (data) => data);
            if (size <= _maxSize) break;
            await removeCachedFile(entry.url);
          }
        });
      }
    });
  }

  Future<void> _maintainCacheObjects() async {
    final urlsResult = await getCachedUrls();
    return urlsResult.fold((_) => unit, (urls) async {
      if (urls.length > _maxObjects) {
        final entries = <CacheEntry>[];
        for (final url in urls) {
          final lastAccessed = await _getLastAccessed(url);
          final accessCount = await _getAccessCount(url);
          final now = DateTime.now();
          entries.add(
            CacheEntry(
              url: url,
              lastAccessed: lastAccessed,
              accessCount: accessCount,
              size: 0,
              cachedAt: now,
              validUntil: now,
            ),
          );
        }
        entries.sort((a, b) {
          // Sort by access count then by last accessed
          if (a.accessCount != b.accessCount) {
            return a.accessCount.compareTo(b.accessCount);
          }
          return a.lastAccessed.compareTo(b.lastAccessed);
        });

        final toRemove = entries.length - _maxObjects;
        for (var i = 0; i < toRemove; i++) {
          await removeCachedFile(entries.elementAt(i).url);
        }
      }
    });
  }
}
