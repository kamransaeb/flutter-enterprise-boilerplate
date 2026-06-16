import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter.freezed.dart';

@freezed
abstract class ProductFilter with _$ProductFilter {
  const ProductFilter._();
  
  const factory ProductFilter({
    @Default([]) List<String> categories,
    double? minPrice,
    double? maxPrice,
    @Default(false) bool inStockOnly,
    double? minRating,
    String? sortBy,
    String? sortOrder,
    String? searchQuery,
    @Default(1) int page,
    @Default(20) int limit,
  }) = _ProductFilter;
}
