import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/models/cache_statistics.dart';

/// Abstract interface for cache manager implementations.
///
/// Defines the contract for file caching: get, cache, remove, and manage
/// cached files by URL with configurable size, staleness, and cleanup.
abstract class CacheManager {

  /// Returns the data from the cache for [key].
  Future<Either<Failure, String>> getDataFromCache(String key, {String? boxName});

  /// Caches the data for [key].
  Future<Either<Failure, Unit>> cacheData(String key, String value, {String? boxName});

  /// Returns the path to a cached file for [url], downloading it if not cached or stale.
  Future<Either<Failure, String>> getCachedFile(String url);

  /// Returns the cached [File] for [url] if present and valid, otherwise null.
  Future<Either<Failure, File?>> getFileFromCache(String url);

  /// Downloads and caches the file at [url].
  Future<Either<Failure, Unit>> cacheFile(String url);

  /// Pre-caches multiple [urls], optionally reporting [onProgress](completed, total).
  Future<Either<Failure, Unit>> preCacheFiles(
    List<String> urls, {
    void Function(int completed, int total)? onProgress,
  });

  /// Clears all cached files and metadata.
  Future<Either<Failure, Unit>> clearCache();

  /// Returns total size in bytes of all cached files.
  Future<Either<Failure, int>> getCacheSize();

  /// Returns the list of URLs currently tracked as cached.
  Future<Either<Failure, List<String>>> getCachedUrls();

  /// Returns whether a valid cached file exists for [url].
  Future<Either<Failure, bool>> isFileCached(String url);

  /// Removes the cached file for [url].
  Future<Either<Failure, Unit>> removeCachedFile(String url);

  /// Removes cached files for all [urls].
  Future<Either<Failure, Unit>> removeCachedFiles(List<String> urls);

  /// Returns cache statistics (entries, size, hit rate, etc.).
  Future<Either<Failure, CacheStatistics>> getStatistics();

  /// Returns whether the cache entry for [url] is still valid, optionally within [maxAge].
  Future<Either<Failure, bool>> isValidCache(
    String url, {
    Duration? maxAge,
  });

  /// Re-downloads and replaces the cached file for [url].
  Future<Either<Failure, Unit>> refreshCache(String url);

  /// Removes expired entries and returns the count of removed items.
  Future<Either<Failure, int>> cleanExpired();

  /// Sets the maximum cache size in bytes.
  Future<Either<Failure, Unit>> setMaxSize(int sizeInBytes);

  /// Sets how long cached files are considered fresh.
  Future<Either<Failure, Unit>> setStalePeriod(Duration duration);

  /// Sets the maximum number of cached objects.
  Future<Either<Failure, Unit>> setMaxObjects(int maxObjects);

  /// Returns current cache configuration (stalePeriod, maxSize, maxObjects, cleanupInterval).
  Future<Either<Failure, Map<String, dynamic>>> getConfig();

  /// Disposes the cache manager and releases resources.
  Future<Either<Failure, Unit>> dispose();
}