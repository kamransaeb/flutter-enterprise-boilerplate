import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter_model.freezed.dart';
part 'product_filter_model.g.dart';

@freezed 
abstract class ProductFilterModel with _$ProductFilterModel {
  const ProductFilterModel._();

  const factory ProductFilterModel({
    @Default([]) List<String> categories,
    @JsonKey(name: 'min_price') double? minPrice,
    @JsonKey(name: 'max_price') double? maxPrice,
    @JsonKey(name: 'in_stock_only') @Default(false) bool inStockOnly,
    @JsonKey(name: 'min_rating') double? minRating,
    @JsonKey(name: 'sort_by') String? sortBy,
    @JsonKey(name: 'search_query') String? searchQuery,
    @Default(1) int page,
    @Default(20) int limit,
  }) = _ProductFilterModel;

  factory ProductFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterModelFromJson(json);

  ProductFilter toEntity() {
    return ProductFilter(
      categories: categories,
      minPrice: minPrice,
      maxPrice: maxPrice,
      inStockOnly: inStockOnly,
      minRating: minRating,
      sortBy: sortBy,
      searchQuery: searchQuery,
      page: page,
      limit: limit,
    );
  }
}

extension ProductFilterExtension on ProductFilter {
  ProductFilterModel toModel() {
    return ProductFilterModel(
      categories: categories,
      minPrice: minPrice,
      maxPrice: maxPrice,
      inStockOnly: inStockOnly,
      minRating: minRating,
      sortBy: sortBy,
      searchQuery: searchQuery,
      page: page,
      limit: limit,
    );  
  }  
}