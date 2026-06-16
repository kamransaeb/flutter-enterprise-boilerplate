import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';

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
  Future<Either<Failure, void>> toggleFavorite(String productId);
  
  Future<Either<Failure, List<Product>>> getFavorites({
    int page,
    int limit,
  });
  
  // Search operations
  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int page,
    int limit,
  });
  
  // Recently viewed
  Future<Either<Failure, List<Product>>> getRecentlyViewed({
    int limit,
  });
  
  // Analytics
  Future<Either<Failure, void>> trackProductView(String productId);
  
  // Streams
  Stream<List<Product>> watchProducts();
  Stream<List<Product>> watchFavorites();
  
  // Cache management
  Future<Either<Failure, void>> clearCache();
}