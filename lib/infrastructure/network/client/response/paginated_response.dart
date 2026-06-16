import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'api_response.dart';

part 'paginated_response.g.dart';

/// Paginated response for list endpoints
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> extends Equatable {
  @JsonKey(name: 'data')
  final List<T> data;
  
  @JsonKey(name: 'meta')
  final PaginationMeta meta;
  
  @JsonKey(name: 'links')
  final PaginationLinks? links;

  const PaginatedResponse({
    required this.data,
    required this.meta,
    this.links,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);

  /// Check if there is more data available
  bool get hasMore => meta.currentPage < meta.totalPages;

  /// Check if this is the first page
  bool get isFirstPage => meta.currentPage == 1;

  /// Check if this is the last page
  bool get isLastPage => meta.currentPage == meta.totalPages;

  /// Get next page number if available
  int? get nextPage => hasMore ? meta.currentPage + 1 : null;

  /// Get previous page number if available
  int? get previousPage => !isFirstPage ? meta.currentPage - 1 : null;

  @override
  List<Object?> get props => [data, meta, links];
}

/// Pagination metadata
@JsonSerializable()
class PaginationMeta extends Equatable {
  @JsonKey(name: 'current_page')
  final int currentPage;
  
  @JsonKey(name: 'per_page')
  final int perPage;
  
  @JsonKey(name: 'total')
  final int total;
  
  @JsonKey(name: 'total_pages')
  final int totalPages;
  
  @JsonKey(name: 'from')
  final int? from;
  
  @JsonKey(name: 'to')
  final int? to;
  
  @JsonKey(name: 'has_more')
  final bool? hasMore;

  const PaginationMeta({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
    this.from,
    this.to,
    this.hasMore,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);

  /// Get the offset for database queries
  int get offset => (currentPage - 1) * perPage;

  /// Check if the pagination is empty
  bool get isEmpty => total == 0;

  /// Check if the pagination is not empty
  bool get isNotEmpty => total > 0;

  @override
  List<Object?> get props => [
        currentPage,
        perPage,
        total,
        totalPages,
        from,
        to,
        hasMore,
      ];
}

/// Pagination links for navigation
@JsonSerializable()
class PaginationLinks extends Equatable {
  @JsonKey(name: 'first')
  final String? first;
  
  @JsonKey(name: 'last')
  final String? last;
  
  @JsonKey(name: 'prev')
  final String? prev;
  
  @JsonKey(name: 'next')
  final String? next;

  const PaginationLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) =>
      _$PaginationLinksFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationLinksToJson(this);

  @override
  List<Object?> get props => [first, last, prev, next];
}

/// Helper extension for creating paginated responses
extension PaginatedResponseExtension<T> on List<T> {
  /// Convert list to paginated response
  PaginatedResponse<T> toPaginatedResponse({
    required int page,
    required int perPage,
    required int total,
  }) {
    final totalPages = (total / perPage).ceil();
    final from = total == 0 ? null : (page - 1) * perPage + 1;
    final to = total == 0 ? null : (page * perPage).clamp(1, total);

    return PaginatedResponse(
      data: this,
      meta: PaginationMeta(
        currentPage: page,
        perPage: perPage,
        total: total,
        totalPages: totalPages,
        from: from,
        to: to,
        hasMore: page < totalPages,
      ),
    );
  }
}

// 
//import 'package:freezed_annotation/freezed_annotation.dart';

// part 'paginated_response.freezed.dart';
// part 'paginated_response.g.dart';

// /// Base pagination metadata interface
// abstract class PaginationMetadata {
//   int get currentPage;
//   int get totalPages;
//   int get totalItems;
//   int get itemsPerPage;
//   bool get hasNext;
//   bool get hasPrevious;
// }

// /// Pagination info with Freezed
// @freezed
// class PaginationInfo with _$PaginationInfo implements PaginationMetadata {
//   const factory PaginationInfo({
//     @JsonKey(name: 'current_page') required int currentPage,
//     @JsonKey(name: 'total_pages') required int totalPages,
//     @JsonKey(name: 'total_items') required int totalItems,
//     @JsonKey(name: 'items_per_page') required int itemsPerPage,
//     @JsonKey(name: 'has_next') required bool hasNext,
//     @JsonKey(name: 'has_previous') required bool hasPrevious,
//     @JsonKey(name: 'from') int? from,
//     @JsonKey(name: 'to') int? to,
//     @JsonKey(name: 'sort_by') String? sortBy,
//     @JsonKey(name: 'sort_order') SortOrder? sortOrder,
//     @JsonKey(name: 'search_query') String? searchQuery,
//   }) = _PaginationInfo;
  
//   const PaginationInfo._();
  
//   /// Empty pagination info
//   factory PaginationInfo.empty() => const PaginationInfo(
//         currentPage: 0,
//         totalPages: 0,
//         totalItems: 0,
//         itemsPerPage: 0,
//         hasNext: false,
//         hasPrevious: false,
//       );
  
//   factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
//       _$PaginationInfoFromJson(json);
  
//   /// Calculate offset for API requests
//   int get offset => (currentPage - 1) * itemsPerPage;
  
//   /// Get next page number if available
//   int? get nextPage => hasNext ? currentPage + 1 : null;
  
//   /// Get previous page number if available
//   int? get previousPage => hasPrevious ? currentPage - 1 : null;
  
//   /// Check if this is the first page
//   bool get isFirstPage => currentPage == 1;
  
//   /// Check if this is the last page
//   bool get isLastPage => currentPage == totalPages;
  
//   /// Get progress percentage (0-100)
//   double get progressPercentage {
//     if (totalItems == 0) return 0.0;
//     return (currentPage * itemsPerPage / totalItems) * 100;
//   }
  
//   /// Get range string (e.g., "1-10 of 100")
//   String get rangeString {
//     if (totalItems == 0) return '0 of 0';
//     final from = ((currentPage - 1) * itemsPerPage) + 1;
//     final to = (currentPage * itemsPerPage).clamp(1, totalItems);
//     return '$from-$to of $totalItems';
//   }
// }

// /// Sort order enum
// enum SortOrder {
//   @JsonValue('asc')
//   asc,
//   @JsonValue('desc')
//   desc;
// }

// /// Generic paginated response with Freezed
// @freezed
// class PaginatedResponse<T> with _$PaginatedResponse<T> {
//   const PaginatedResponse._();
  
//   const factory PaginatedResponse({
//     required List<T> data,
//     required PaginationInfo pagination,
//     String? nextUrl,
//     String? previousUrl,
//     String? firstUrl,
//     String? lastUrl,
//   }) = _PaginatedResponse<T>;
  
//   /// Create from JSON with custom converter
//   factory PaginatedResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(Object? json) fromJsonT,
//   ) {
//     return PaginatedResponse<T>(
//       data: (json['data'] as List)
//           .map((e) => fromJsonT(e))
//           .toList(),
//       pagination: PaginationInfo.fromJson(
//         json['pagination'] as Map<String, dynamic>,
//       ),
//       nextUrl: json['next_url'] as String?,
//       previousUrl: json['previous_url'] as String?,
//       firstUrl: json['first_url'] as String?,
//       lastUrl: json['last_url'] as String?,
//     );
//   }
  
//   /// Convert to JSON with custom converter
//   Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
//     return {
//       'data': data.map(toJsonT).toList(),
//       'pagination': pagination.toJson(),
//       'next_url': nextUrl,
//       'previous_url': previousUrl,
//       'first_url': firstUrl,
//       'last_url': lastUrl,
//     };
//   }
  
//   /// Create an empty paginated response
//   factory PaginatedResponse.empty() => PaginatedResponse<T>(
//         data: const [],
//         pagination: PaginationInfo.empty(),
//       );
  
//   /// Check if response is empty
//   bool get isEmpty => data.isEmpty;
  
//   /// Check if response is not empty
//   bool get isNotEmpty => data.isNotEmpty;
  
//   /// Map the data list to a different type
//   PaginatedResponse<U> map<U>(U Function(T) mapper) {
//     return PaginatedResponse<U>(
//       data: data.map(mapper).toList(),
//       pagination: pagination,
//       nextUrl: nextUrl,
//       previousUrl: previousUrl,
//       firstUrl: firstUrl,
//       lastUrl: lastUrl,
//     );
//   }
// }