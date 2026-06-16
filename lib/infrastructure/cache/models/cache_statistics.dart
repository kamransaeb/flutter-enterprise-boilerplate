import 'package:flutter_enterprise_boilerplate/infrastructure/cache/models/cache_entry.dart';

class CacheStatistics {
  final int totalFiles;
  final int totalSize;
  final List<CacheEntry> entries;
  final CacheEntry? oldestEntry;
  final CacheEntry? newestEntry;
  final double hitRate;
  final int maxSize;
  final int maxObjects;
  final Duration stalePeriod;
  final String cachePath;
  final DateTime? lastCleanup;

  CacheStatistics({
    required this.totalFiles,
    required this.totalSize,
    required this.entries,
    this.oldestEntry,
    this.newestEntry,
    required this.hitRate,
    required this.maxSize,
    required this.maxObjects,
    required this.stalePeriod,
    required this.cachePath,
    this.lastCleanup,
  });

  String get formattedSize {
    if (totalSize < 1024) return '$totalSize B';
    if (totalSize < 1024 * 1024) {
      return '${(totalSize / 1024).toStringAsFixed(2)} KB';
    }
    if (totalSize < 1024 * 1024 * 1024) {
      return '${(totalSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(totalSize / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  String get maxSizeFormatted {
    if (maxSize < 1024) return '$maxSize B';
    if (maxSize < 1024 * 1024) {
      return '${(maxSize / 1024).toStringAsFixed(2)} KB';
    }
    if (maxSize < 1024 * 1024 * 1024) {
      return '${(maxSize / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(maxSize / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  double get usagePercentage => (totalSize / maxSize) * 100;

  Map<String, dynamic> toJson() => {
    'totalFiles': totalFiles,
    'totalSize': totalSize,
    'formattedSize': formattedSize,
    'entries': entries.map((e) => e.toJson()).toList(),
    'hitRate': hitRate,
    'maxSize': maxSize,
    'maxSizeFormatted': maxSizeFormatted,
    'usagePercentage': usagePercentage,
    'maxObjects': maxObjects,
    'stalePeriod': stalePeriod.inMilliseconds,
    'cachePath': cachePath,
    'lastCleanup': lastCleanup?.toIso8601String(),
  };
}