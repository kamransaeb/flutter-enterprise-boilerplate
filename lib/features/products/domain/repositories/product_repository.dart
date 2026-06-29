import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_category.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_review.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';



abstract class ProductRepository {
  // Product operations
  Future<Either<Failure, List<Product>>> getProducts({
    int page,
    int limit,
    ProductFilter? filter,
  });
  
  Future<Either<Failure, Product>> getProductById({required String productId});
  
  Future<Either<Failure, List<Product>>> getFeaturedProducts({
    int limit,
  });
  
  Future<Either<Failure, List<Product>>> getRelatedProducts(
    String productId, {
    int limit,
  });
  
  Future<Either<Failure, List<Product>>> getTrendingProducts({
    int limit,
  });
  
  Future<Either<Failure, List<Product>>> getRecommendations({
    int limit,
  });
  
  // Category operations
  Future<Either<Failure, List<ProductCategory>>> getCategories({
    String? parentId,
  });

  Future<Either<Failure, ProductCategory>> getCategoryById({
    required String categoryId,
  });

  Future<Either<Failure, List<Product>>> getProductsByIds({
    required List<String> productIds,
  });

  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int page,
    int limit,
  });

  Future<Either<Failure, List<Product>>> filterProducts(ProductFilter filter);
  
  // Review operations
  Future<Either<Failure, List<ProductReview>>> getProductReviews(
    String productId, {
    int page,
    int limit,
  });
  
  Future<Either<Failure, ProductReview>> addProductReview({
    required String productId,
    required double rating,
    required String comment,
  });
  
  // Favorite operations
  Future<Either<Failure, void>> toggleWishlist(String productId);
  
  Future<Either<Failure, List<Product>>> getWishlist({
    int page,
    int limit,
  });

  Future<Either<Failure, void>> addToWishlist(String productId);
  Future<Either<Failure, void>> removeFromWishlist(String productId);

  Future<Either<Failure, bool>> isInWishlist(String productId);

  Future<Either<Failure, void>> clearWishlist();
  
  
  // Recently viewed
  Future<Either<Failure, List<Product>>> getRecentlyViewed({
    int limit,
  });

  Future<Either<Failure, void>> addToRecentlyViewed(String productId);

  Future<Either<Failure, void>> clearRecentlyViewed();
  
  // // Analytics
  // Future<Either<Failure, void>> trackProductView(String productId);
  
  // // Streams
  // Stream<List<Product>> watchProducts();
  // Stream<List<Product>> watchWishList();
  
  // Cache management
  Future<Either<Failure, void>> clearCache();

  Future<Either<Failure, void>> clearExpiredCache();

  Future<Either<Failure, int>> getCacheSize();
}