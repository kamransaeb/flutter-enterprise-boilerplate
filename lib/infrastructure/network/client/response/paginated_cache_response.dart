import 'package:equatable/equatable.dart';

class PaginatedCacheResponse<T> extends Equatable {
  const PaginatedCacheResponse({
    required this.items,
    required this.page,
    required this.limit,
    required this.cachedAt,
    this.totalCount,
    this.hasMore = false,
  });

  final List<T> items;
  final int page;
  final int limit;
  final DateTime cachedAt;
  final int? totalCount;
  final bool hasMore;

  @override
  List<Object?> get props => [items, page, limit, cachedAt, totalCount, hasMore];
}