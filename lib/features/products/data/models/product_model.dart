import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product.dart';


part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();
  
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'in_stock') @Default(false) bool inStock,
    @Default(0.0) double rating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @Default([]) List<String> categories,
    @Default({}) Map<String, dynamic> attributes,
    @JsonKey(name: 'original_price') double? originalPrice,
    String? brand,
    String? sku,
    @JsonKey(name: 'stock_quantity') int? stockQuantity,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      inStock: inStock,
      rating: rating,
      reviewCount: reviewCount,
      categories: categories,
      attributes: attributes,
      originalPrice: originalPrice,
      brand: brand,
      sku: sku,
      stockQuantity: stockQuantity,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isFavorite: isFavorite,
      isFeatured: isFeatured,
    );
  }
}

extension ProductExtension on Product {
  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
      inStock: inStock,
      rating: rating,
      reviewCount: reviewCount,
      categories: categories,
      attributes: attributes,
      originalPrice: originalPrice,
      brand: brand,
      sku: sku,
      stockQuantity: stockQuantity,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isFavorite: isFavorite,
      isFeatured: isFeatured,
    );
  }
}

// @freezed
// class ProductCategoryModel with _$ProductCategoryModel {
//   const factory ProductCategoryModel({
//     required String id,
//     required String name,
//     String? description,
//     @JsonKey(name: 'image_url') String? imageUrl,
//     @JsonKey(name: 'parent_id') String? parentId,
//     @JsonKey(name: 'product_count') @Default(0) int productCount,
//     @Default([]) List<ProductCategoryModel> children,
//   }) = _ProductCategoryModel;

//   factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductCategoryModelFromJson(json);

//   ProductCategory toEntity() {
//     return ProductCategory(
//       id: id,
//       name: name,
//       description: description,
//       imageUrl: imageUrl,
//       parentId: parentId,
//       productCount: productCount,
//       children: children.map((child) => child.toEntity()).toList(),
//     );
//   }
// }

// @freezed
// class ProductReviewModel with _$ProductReviewModel {
//   const factory ProductReviewModel({
//     required String id,
//     @JsonKey(name: 'product_id') required String productId,
//     @JsonKey(name: 'user_id') required String userId,
//     @JsonKey(name: 'user_name') required String userName,
//     @JsonKey(name: 'user_avatar') String? userAvatar,
//     required double rating,
//     required String comment,
//     @JsonKey(name: 'created_at') required DateTime createdAt,
//     @Default([]) List<String> likes,
//     @Default([]) List<String> dislikes,
//     @JsonKey(name: 'verified_purchase') @Default(false) bool verifiedPurchase,
//   }) = _ProductReviewModel;

//   factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductReviewModelFromJson(json);

//   ProductReview toEntity() {
//     return ProductReview(
//       id: id,
//       productId: productId,
//       userId: userId,
//       userName: userName,
//       userAvatar: userAvatar,
//       rating: rating,
//       comment: comment,
//       createdAt: createdAt,
//       likes: likes,
//       dislikes: dislikes,
//       verifiedPurchase: verifiedPurchase,
//     );
//   }
// }

// @freezed
// class ProductFilterModel with _$ProductFilterModel {
//   const factory ProductFilterModel({
//     @Default([]) List<String> categories,
//     @JsonKey(name: 'min_price') double? minPrice,
//     @JsonKey(name: 'max_price') double? maxPrice,
//     @JsonKey(name: 'in_stock_only') @Default(false) bool inStockOnly,
//     @JsonKey(name: 'min_rating') double? minRating,
//     @JsonKey(name: 'sort_by') String? sortBy,
//     @JsonKey(name: 'search_query') String? searchQuery,
//     @Default(1) int page,
//     @Default(20) int limit,
//   }) = _ProductFilterModel;

//   factory ProductFilterModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductFilterModelFromJson(json);

//   ProductFilter toEntity() {
//     return ProductFilter(
//       categories: categories,
//       minPrice: minPrice,
//       maxPrice: maxPrice,
//       inStockOnly: inStockOnly,
//       minRating: minRating,
//       sortBy: sortBy,
//       searchQuery: searchQuery,
//       page: page,
//       limit: limit,
//     );
//   }
// }

// extension ProductExtension on Product {
//   ProductModel toModel() {
//     return ProductModel(
//       id: id,
//       name: name,
//       description: description,
//       price: price,
//       imageUrl: imageUrl,
//       inStock: inStock,
//       rating: rating,
//       reviewCount: reviewCount,
//       categories: categories,
//       attributes: attributes,
//       originalPrice: originalPrice,
//       brand: brand,
//       sku: sku,
//       stockQuantity: stockQuantity,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       isFavorite: isFavorite,
//       isFeatured: isFeatured,
//     );
//   }
// }

// extension ProductCategoryExtension on ProductCategory {
//   ProductCategoryModel toModel() {
//     return ProductCategoryModel(
//       id: id,
//       name: name,
//       description: description,
//       imageUrl: imageUrl,
//       parentId: parentId,
//       productCount: productCount,
//       children: children.map((child) => child.toModel()).toList(),
//     );
//   }
// }

// extension ProductReviewExtension on ProductReview {
//   ProductReviewModel toModel() {
//     return ProductReviewModel(
//       id: id,
//       productId: productId,
//       userId: userId,
//       userName: userName,
//       userAvatar: userAvatar,
//       rating: rating,
//       comment: comment,
//       createdAt: createdAt,
//       likes: likes,
//       dislikes: dislikes,
//       verifiedPurchase: verifiedPurchase,
//     );
//   }
// }

// extension ProductFilterExtension on ProductFilter {
//   ProductFilterModel toModel() {
//     return ProductFilterModel(
//       categories: categories,
//       minPrice: minPrice,
//       maxPrice: maxPrice,
//       inStockOnly: inStockOnly,
//       minRating: minRating,
//       sortBy: sortBy,
//       searchQuery: searchQuery,
//       page: page,
//       limit: limit,
//     );
//   }
// }