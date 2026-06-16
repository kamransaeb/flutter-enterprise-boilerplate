import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_category_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/paginated_cache_response.dart';

abstract class ProductLocalDataSource {
  // Product caching
  Future<void> cacheProducts({
    required List<ProductModel> products,
    required int page,
    required int limit,
    ProductFilter? filter,
  });
  
  Future<PaginatedCacheResponse<ProductModel>?> getCachedProducts({
    required int page,
    required int limit,
    ProductFilter? filter,
  });
  
  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel?> getCachedProduct(String productId);
  Future<void> cacheMultipleProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProductsByIds(List<String> productIds);
  
  // Category caching
  Future<void> cacheCategories(List<ProductCategoryModel> categories);
  Future<List<ProductCategoryModel>> getCachedCategories();
  Future<ProductCategoryModel?> getCachedCategory(String categoryId);
  
  // Review caching
  Future<void> cacheReviews({
    required String productId,
    required List<ProductReviewModel> reviews,
    required int page,
    required int limit,
  });
  Future<List<ProductReviewModel>> getCachedReviews(String productId);
  
  // Search and filter
  Future<List<ProductModel>> searchCachedProducts(String query);
  Future<List<ProductModel>> filterCachedProducts(ProductFilter filter);
  
  // Recently viewed
  Future<void> addToRecentlyViewed(ProductModel product);
  Future<List<ProductModel>> getRecentlyViewed();
  Future<void> clearRecentlyViewed();
  
  // Wishlist
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String productId);
  Future<bool> isInWishlist(String productId);
  Future<List<ProductModel>> getWishlist();
  Future<void> clearWishlist();
  
  // Cache management
  Future<void> clearCache();
  Future<void> clearExpiredCache();
  Future<int> getCacheSize();
}