import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    @Default(false) bool inStock,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default([]) List<String> categories,
    @Default({}) Map<String, dynamic> attributes,
    double? originalPrice,
    String? brand,
    String? sku,
    int? stockQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isFavorite,
    @Default(false) bool isFeatured,
  }) = _Product;

  factory Product.empty() => const Product(
        id: '',
        name: '',
        description: '',
        price: 0.0,
        imageUrl: '',
      );

  double get discountPercentage {
    if (originalPrice == null || originalPrice! <= 0) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  bool get hasDiscount => discountPercentage > 0;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  String? get formattedOriginalPrice {
    if (originalPrice == null) return null;
    return '\$${originalPrice!.toStringAsFixed(2)}';
  }

  String get formattedDiscount {
    if (!hasDiscount) return '';
    return '${discountPercentage.toStringAsFixed(0)}% OFF';
  }
}

// @freezed
// class ProductCategory with _$ProductCategory {
//   const factory ProductCategory({
//     required String id,
//     required String name,
//     String? description,
//     String? imageUrl,
//     String? parentId,
//     @Default(0) int productCount,
//     @Default([]) List<ProductCategory> children,
//   }) = _ProductCategory;

//   factory ProductCategory.fromJson(Map<String, dynamic> json) =>
//       _$ProductCategoryFromJson(json);
// }

// @freezed
// class ProductReview with _$ProductReview {
//   const factory ProductReview({
//     required String id,
//     required String productId,
//     required String userId,
//     required String userName,
//     String? userAvatar,
//     required double rating,
//     required String comment,
//     required DateTime createdAt,
//     @Default([]) List<String> likes,
//     @Default([]) List<String> dislikes,
//     @Default(false) bool verifiedPurchase,
//   }) = _ProductReview;

//   factory ProductReview.fromJson(Map<String, dynamic> json) =>
//       _$ProductReviewFromJson(json);
// }

// @freezed
// class ProductFilter with _$ProductFilter {
//   const factory ProductFilter({
//     @Default([]) List<String> categories,
//     double? minPrice,
//     double? maxPrice,
//     @Default(false) bool inStockOnly,
//     double? minRating,
//     String? sortBy,
//     String? searchQuery,
//     @Default(1) int page,
//     @Default(20) int limit,
//   }) = _ProductFilter;

//   factory ProductFilter.fromJson(Map<String, dynamic> json) =>
//       _$ProductFilterFromJson(json);
// }