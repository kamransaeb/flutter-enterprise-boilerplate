class CacheEntry {
  final String url;
  final int size;
  final DateTime cachedAt;
  final DateTime lastAccessed;
  final DateTime validUntil;
  
  final String? filePath;
  final int accessCount;

  CacheEntry({
    required this.url,
    required this.size,
    required this.cachedAt,
    required this.lastAccessed,
    required this.validUntil,
    this.filePath,
    this.accessCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'url': url,
    'size': size,
    'cachedAt': cachedAt.toIso8601String(),
    'lastAccessed': lastAccessed.toIso8601String(),
    'validUntil': validUntil.toIso8601String(),
    
    'filePath': filePath,
    'accessCount': accessCount,
  };

  factory CacheEntry.fromJson(Map<String, dynamic> json) => CacheEntry(
    url: json['url'] as String,
    size: json['size'] as int,
    cachedAt: DateTime.parse(json['cachedAt'] as String),
    lastAccessed: DateTime.parse(json['lastAccessed'] as String),
    validUntil: DateTime.parse(json['validUntil'] as String),
    
    filePath: json['filePath'] as String?,
    accessCount: json['accessCount'] as int? ?? 0,
  );
}